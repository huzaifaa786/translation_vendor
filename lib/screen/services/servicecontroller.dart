import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/values/string.dart';
import 'package:location/location.dart';

class ServiceController extends GetxController {
  static ServiceController instance = Get.find();
  LocationData? locationData;
  List<WorkingHour> workingHours = [];
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
    var url = BASE_URL + 'service/store';
    GetStorage box = GetStorage();
    int id = box.read('vender_id');
    String? api_token = box.read('api_token');

    var data = {
      'vendor_id': id,
      'api_token': api_token,
      'schedual': workinghours,
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
