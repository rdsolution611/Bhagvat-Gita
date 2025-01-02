import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Api extends GetxController {
  @override
  void onInit() {
    getAllData().then((value) {
      isloading = true;
    });
    super.onInit();
  }

  Future getAllData() async {
    final List<Future> fetchers = [
      artilink(),
      bhagwadlink(),
      bhajanlink(),
      mahabharatlink(),
      suvicharlink(),
    ];
    await Future.wait(fetchers);
    return;
  }

  bool isloading = false;
  List arti = [];
  List bhagwad = [];
  List bhajan = [];
  List mahabharat = [];
  List suvichar = [];
  Future<void> artilink() async {
    var url = Uri.parse('https://rdsolution611.github.io/geeta/aarti.json');
    var response = await http.get(url);
    var data = json.decode(utf8.decode(response.bodyBytes));
    arti = data['aartiList'];
    data = true;
    update();
  }

  Future<void> bhagwadlink() async {
    var url =
        Uri.parse('https://rdsolution611.github.io/geeta/bhagvadgeeta.json');
    var response = await http.get(url);
    bhagwad = json.decode(utf8.decode(response.bodyBytes));
    // print(bhagwad);
    update();
  }

  Future<void> bhajanlink() async {
    var url = Uri.parse('https://rdsolution611.github.io/geeta/bhajan.json');
    var response = await http.get(url);
    var data = json.decode(utf8.decode(response.bodyBytes));
    bhajan = data['aartiList'];
    data = true;
    update();
  }

  Future<void> mahabharatlink() async {
    var url = Uri.parse(
        'https://rdsolution611.github.io/geeta/mahabharat_varta.json');
    var response = await http.get(url);
    var data = json.decode(utf8.decode(response.bodyBytes));
    mahabharat = data['aartiList'];
    data = true;
    update();
  }

  Future<void> suvicharlink() async {
    var url = Uri.parse('https://rdsolution611.github.io/geeta/suvichar.json');
    var response = await http.get(url);
    var data = json.decode(utf8.decode(response.bodyBytes));
    suvichar = data['suvicharList'];
    data = true;
    update();
  }

  Future<void> shareImage(
      {required BuildContext context, required String image}) async {
    update();
  }
}

extension IntExtension on int {
  int validate({int value = 0}) {
    return this;
  }

  Widget get height => SizedBox(height: this.toDouble());
  Widget get width => SizedBox(width: this.toDouble());
}

Color text = Colors.white;

Container sc_bg = Container(
  decoration: BoxDecoration(
    // color: Color(0xff0c3c78),
    gradient: LinearGradient(
      colors: [
        Color(0xff25274d),
        Color(0xff25274d),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
);
