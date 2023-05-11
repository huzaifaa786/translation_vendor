import 'dart:collection';

import 'package:flutter/material.dart';
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
  // Location

  Set<Circle> _circles = HashSet<Circle>();
  double? radius = 500;
  int _circleIdCounter = 1;
  bool _isCircle = true;

  setCircles() {
    final String circleIdVal = 'circle_id_$_circleIdCounter';
    _circleIdCounter++;
    print(
        'Circle | Latitude: ${locationData!.latitude}  Longitude: ${locationData!.longitude}  Radius: $radius');
    _circles.add(Circle(
        circleId: CircleId(circleIdVal),
        center: LatLng(locationData!.latitude!, locationData!.longitude!),
        radius: radius!,
        fillColor: Colors.redAccent.withOpacity(0.5),
        strokeWidth: 3,
        strokeColor: Colors.redAccent));
  }

  void addservice(List<WorkingHour>? workingHours) async {
    print(workingHours!.length);
    for (var element in workingHours) {
      print(element.day);
      print(element.startTime);
      print(element.endTime);
      print(element.isFrozen);
      print('?????????');
    }
    LoadingHelper.show();
    var url = BASE_URL + 'service/store';
    GetStorage box = GetStorage();
    int id = box.read('vender_id');

    var data = {
      'vendor_id': id,
      'schedual': workingHours,
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
