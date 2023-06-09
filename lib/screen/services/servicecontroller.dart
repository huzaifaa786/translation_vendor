import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/string.dart';
import 'package:location/location.dart';
import 'package:translation_vendor/models/documentlist.dart';

class ServiceController extends GetxController {
  static ServiceController instance = Get.find();
  TextEditingController audiovideoController = TextEditingController();
  TextEditingController onlineAudiovideoController = TextEditingController();
  TextEditingController inpersionController = TextEditingController();
  TextEditingController UnurgentController = TextEditingController();
  TextEditingController urgentController = TextEditingController();
  LocationData? locationData;
  List<WorkingHour> workingHours = [];
  List<Documentlist> unurgentdocument = [];
  List<Documentlist> urgentdocument = [];
  String? InPersonPrice;
  String? UnurgentPrice;
  String? urgentPrice;
  String? audioORvideo;
  String? onlineAudioORvideo;
  RxBool showInPersonPriceField = false.obs;
  RxBool showaudioORvideoPriceField = false.obs;
  RxBool showOnlineAudioORvideoPriceField = false.obs;
  RxBool showUnurgentPriceField = false.obs;
  RxBool showurgentPriceField = false.obs;
  RxBool validateSignUpForm = false.obs;
  double? radius;
  LatLng? chnagePoint;

////////////////////////// Inperson Input Functionlity ////////////////////////
  openInPersonField() {
    showInPersonPriceField = true.obs;
    update();
  }

  EditInPersonPrice() {
    showInPersonPriceField = false.obs;
    if (inpersionController.text == '') {
      InPersonPrice = null;
    } else {
      InPersonPrice = inpersionController.text;
    }
    update();
  }

////////////////////////// Audio/Video Input Functionlity ////////////////////////

  openaudioORvideoField() {
    showaudioORvideoPriceField = true.obs;
    update();
  }

  EditaudioORvideoAbout() {
    showaudioORvideoPriceField = false.obs;
    audioORvideo = audiovideoController.text;
    update();
  }

////////////////////////// Audio/Video Input Functionlity ////////////////////////

  openOnlineAudioORvideoField() {
    showOnlineAudioORvideoPriceField = true.obs;
    update();
  }

  EditOnlineAudioORvideoAbout() {
    showOnlineAudioORvideoPriceField = false.obs;
    onlineAudioORvideo = onlineAudiovideoController.text;
    update();
  }

////////////////////////// Unurgent Document Functionlity ////////////////////////
  openUnurgentField() {
    showUnurgentPriceField = true.obs;
    update();
  }

  EditUnurgentPrice() {
    showUnurgentPriceField = false.obs;
    if (UnurgentController.text == '') {
      UnurgentPrice = null;
    } else {
      UnurgentPrice = UnurgentController.text;
    }
    update();
  }

////////////////////////// Urgent Document Functionlity ////////////////////////
  openurgentField() {
    showurgentPriceField = true.obs;
    update();
  }

  EditurgentPrice() {
    showurgentPriceField = false.obs;
    if (urgentController.text == '') {
      urgentPrice = null;
    } else {
      urgentPrice = urgentController.text;
    }
    update();
  }

  save(inperson, audio) {
    InPersonPrice = inperson;
    audioORvideo = audio;
    update();
  }

  void addservice() async {
    LoadingHelper.show();
    if (chnagePoint != null) {
      if (radius != null) {
        if (onlineAudioORvideo != null) {
          if (audioORvideo != null) {
            if (InPersonPrice != null) {
              if (workingHours.length != 0) {
                if (urgentdocument.length != 0) {
                  if (unurgentdocument.length != 0) {
                    if (urgentPrice != null) {
                      if (UnurgentPrice != null) {
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
                        var data = {
                          'vendor_id': id,
                          'api_token': api_token,
                          'schedual': workinghours,
                          'urgent': urgent,
                          'unurgent': unurgent,
                          'inperson': inpersionController.text.toString(),
                          'audiovideo': audiovideoController.text.toString(),
                          'onlineaudiovideo':
                              onlineAudiovideoController.text.toString(),
                          'urgentprice': urgentPrice,
                          'unurgentprice': UnurgentPrice,
                          'latitude': chnagePoint!.latitude.toString(),
                          'longitude': chnagePoint!.longitude.toString(),
                          'radius': radius.toString()
                        };
                        var response = await Api.execute(url: url, data: data);
                        print(response);
                        LoadingHelper.dismiss();
                        Get.snackbar('Successfully.',
                            'Service has been added successfully.',
                            colorText: Colors.white,
                            backgroundColor: Colors.green,
                            snackPosition: SnackPosition.BOTTOM);
                        return response;
                      } else {
                        LoadingHelper.dismiss();
                        Get.snackbar('Error!',
                            'Unurgetnt Per page price is not defined.',
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    } else {
                      LoadingHelper.dismiss();
                      Get.snackbar(
                          'Error!', 'urgetnt Per page price is not defined.',
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  } else {
                    LoadingHelper.dismiss();
                    Get.snackbar('Error!', 'Unurgent document data is missing.',
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM);
                  }
                } else {
                  LoadingHelper.dismiss();
                  Get.snackbar('Error!', 'Urgent document data is missing.',
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM);
                }
              } else {
                LoadingHelper.dismiss();
                Get.snackbar('Error!', 'Working hours not defined.',
                    colorText: Colors.white,
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM);
              }
            } else {
              LoadingHelper.dismiss();
              Get.snackbar('Error!', 'Inperson price is not defined.',
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM);
            }
          } else {
            LoadingHelper.dismiss();
            Get.snackbar('Error!', 'Audio/Video price is not defined.',
                colorText: Colors.white,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          LoadingHelper.dismiss();
          Get.snackbar('Error!', 'Online Audio/Video price is not defined.',
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        LoadingHelper.dismiss();
        Get.snackbar('Error!', 'Select Location And save before procede next.',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      LoadingHelper.dismiss();
      Get.snackbar('Error!', 'Select Location And save before procede next.',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
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

  clearServiceScreen() {
    unurgentdocument = [];
    urgentdocument = [];
    InPersonPrice = null;
    UnurgentPrice = null;
    urgentPrice = null;
    audioORvideo = null;
    chnagePoint = null;
    radius = null;
    inpersionController.clear();
    audiovideoController.clear();
    onlineAudiovideoController.clear();
    urgentController.clear();
    UnurgentController.clear();
    onlineAudioORvideo = null;
    showInPersonPriceField = false.obs;
    showaudioORvideoPriceField = false.obs;
    showUnurgentPriceField = false.obs;
    showurgentPriceField = false.obs;
    showOnlineAudioORvideoPriceField = false.obs;
    update();
  }
}
