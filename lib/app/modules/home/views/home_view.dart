import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';
import 'package:dio/dio.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ONGKOS KIRIM'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("Tempat Asal",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          DropdownSearch<Province>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Asal",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) =>
                controller.provAsalId.value = value?.provinceId ?? "0",
            // dropdownBuilder: (context, selectedItem) => ListTile(
            //   title: Text(
            //       selectedItem?["province"].toString() ?? "Belum Pilih data"),
            // ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
            ),
            asyncItems: (String filter) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {"key": "5c1a41d60074756b308ad9635d893c76"},
              );
              // print(response.data["rajaongkir"]["results"]);
              var models =
                  Province.fromJsonList(response.data["rajaongkir"]["results"]);
              return models;
            },
          ),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<City>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Asal",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            // dropdownBuilder: (context, selectedItem) => ListTile(
            //   title: Text(
            //       selectedItem?["province"].toString() ?? "Belum Pilih data"),
            // ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
            ),
            onChanged: (value) =>
                controller.cityAsalId.value = value?.cityId ?? "0",
            asyncItems: (String filter) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provAsalId}",
                queryParameters: {"key": "5c1a41d60074756b308ad9635d893c76"},
              );
              // print(response.data["rajaongkir"]["results"]);
              var models =
                  City.fromJsonList(response.data["rajaongkir"]["results"]);
              return models;
            },
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("Tempat Tujuan",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          DropdownSearch<Province>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) =>
                controller.provTujuanId.value = value?.provinceId ?? "0",
            // dropdownBuilder: (context, selectedItem) => ListTile(
            //   title: Text(
            //       selectedItem?["province"].toString() ?? "Belum Pilih data"),
            // ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
            ),
            asyncItems: (String filter) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {"key": "5c1a41d60074756b308ad9635d893c76"},
              );
              // print(response.data["rajaongkir"]["results"]);
              var models =
                  Province.fromJsonList(response.data["rajaongkir"]["results"]);
              return models;
            },
          ),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<City>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            // dropdownBuilder: (context, selectedItem) => ListTile(
            //   title: Text(
            //       selectedItem?["province"].toString() ?? "Belum Pilih data"),
            // ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
            ),
            onChanged: (value) =>
                controller.cityTujuanId.value = value?.cityId ?? "0",
            asyncItems: (String filter) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanId}",
                queryParameters: {"key": "5c1a41d60074756b308ad9635d893c76"},
              );
              // print(response.data["rajaongkir"]["results"]);
              var models =
                  City.fromJsonList(response.data["rajaongkir"]["results"]);
              return models;
            },
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("Kurir",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          DropdownSearch<Map<String, dynamic>>(
            items: [
              {
                "code": "jne",
                "name": "JNE",
              },
              {
                "code": "pos",
                "name": "POS Indonesia",
              },
              {
                "code": "tiki",
                "name": "TIKI",
              }
            ],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kurir",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item['name']}"),
              ),
            ),
            dropdownBuilder: (context, selectedItem) =>
                Text("${selectedItem?['name'] ?? "Pilih Kurir"}"),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("CEK ONGKOS KIRIM"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                padding: MaterialStateProperty.all(EdgeInsets.all(20))),
          ),
        ],
      ),
    );
  }
}
