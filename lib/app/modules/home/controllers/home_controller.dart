import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;
  TextEditingController berat = TextEditingController();

  List<Ongkir> ongkosKirim = [];
  RxBool isLaoding = false.obs;

  RxString codeKurir = "".obs;

  void cekOngkir() async {
    if (provAsalId != "0" &&
        provTujuanId != "0" &&
        cityAsalId != "0" &&
        cityTujuanId != "0" &&
        codeKurir != "" &&
        berat.text != "") {
      //eksekusi
      try {
        //gas
        isLaoding.value = true;
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": berat.text,
            "courier": codeKurir.value,
          },
          headers: {
            "key": "5c1a41d60074756b308ad9635d893c76",
            "content-type": "application/x-www-form-urlencoded",
          },
        );
        // print(response.body);
        isLaoding.value = false;
        List ongkir = json.decode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        // print(ongkir);
        ongkosKirim = Ongkir.fromJsonList(ongkir);
        Get.defaultDialog(
          title: "ONGKOS KIRIM",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ongkosKirim
                .map(
                  (e) => ListTile(
                    title: Text("${e.service!.toUpperCase()}"),
                    subtitle: Text("Rp ${e.cost![0].value}"),
                  ),
                )
                .toList(),
          ),
        );
        // print(data);
        // data.forEach((element) {
        //   print(element.toJson());
        // });
      } catch (e) {
        print(e);
        Get.dialog(
          AlertDialog(
            title: const Text('Terjadi kesalahan'),
            content: const Text('Tidak dapat mengecek ongkos kirim.'),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      }
    } else {
      Get.dialog(
        AlertDialog(
          title: const Text('Terjadi kesalahan'),
          content: const Text('data anda belum terisi lengkap'),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    }
  }
}
