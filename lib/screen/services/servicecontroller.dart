import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';

import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/values/string.dart';
import 'package:location/location.dart';
import 'package:translation_vendor/models/documentlist.dart';

class ServiceController extends GetxController {
  static ServiceController instance = Get.find();
   TextEditingController audiovideoController = TextEditingController();
    TextEditingController inpersionController = TextEditingController();
  LocationData? locationData;
  List<WorkingHour> workingHours = [];
  List<Documentlist> unurgentdocument = [];
  List<Documentlist> urgentdocument = [];
  String? InPersonPrice;
  String? audioORvideo;

  save(inperson, audio) {
    InPersonPrice = inperson;
    audioORvideo = audio;
    update();
  }

  void addservice() async {
    LoadingHelper.show();
    List<Map<String, dynamic>> jsonList =
        workingHours.map((wh) => wh.toJson()).toList();
    String workinghours = jsonEncode(jsonList);
    List<Map<String, dynamic>> jsonList1 =
        urgentdocument.map((wh) => wh.toJson()).toList();
    String urgent = jsonEncode(jsonList1);
    List<Map<String, dynamic>> jsonList2 =
        unurgentdocument.map((wh) => wh.toJson()).toList();
    String unurgent = jsonEncode(jsonList2);
    var url = BASE_URL + 'service/store';
    GetStorage box = GetStorage();
    int id = box.read('vender_id');
    String? api_token = box.read('api_token');
    print('objectdfdgfdg');
    print(unurgentdocument);
    print(audiovideoController.text);

    var data = {
      'vendor_id': id,
      'api_token': api_token,
      'schedual': workinghours,
      'urgent': urgent,
      'unurgent' :unurgent,
      'inperson':inpersionController.text.toString(),
      'audiovideo':audiovideoController.text.toString()

    };
    var response = await Api.execute(url: url, data: data);
    print(response);
    LoadingHelper.dismiss();
    return response;
  }

  getlocation() async {
    LoadingHelper.show();
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    print(
        'latitude: ${locationData!.latitude}, longitude: ${locationData!.longitude}');

    LoadingHelper.dismiss();
    update();
  }
}
