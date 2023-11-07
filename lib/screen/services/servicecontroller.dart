import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/service.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/screen/main/main.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';
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
  VendorService? service;
  bool iAudioOrVideo = false;
  bool isInperson = false;
  bool isDocument = false;

////////////////////////// Inperson Input Functionlity ////////////////////////
  openInPersonField() {
    showInPersonPriceField = true.obs;
    update();
  }

  EditInPersonPrice() {
    showInPersonPriceField = false.obs;
    if (inpersionController.text == '' || inpersionController.text == '0') {
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

  EditaudioORvideoPrice() {
    showaudioORvideoPriceField = false.obs;
    if (audiovideoController.text == '' || audiovideoController.text == '0') {
      audioORvideo = null;
    } else {
      audioORvideo = audiovideoController.text;
    }
    update();
  }

////////////////////////// Audio/Video Input Functionlity ////////////////////////

  openOnlineAudioORvideoField() {
    showOnlineAudioORvideoPriceField = true.obs;
    update();
  }

  EditOnlineAudioORvideoPrice() {
    showOnlineAudioORvideoPriceField = false.obs;
    if (onlineAudiovideoController.text == '' ||
        onlineAudiovideoController.text == '0') {
      onlineAudioORvideo = null;
    } else {
      onlineAudioORvideo = onlineAudiovideoController.text;
    }
    update();
  }

////////////////////////// Unurgent Document Functionlity ////////////////////////
  openUnurgentField() {
    showUnurgentPriceField = true.obs;
    update();
  }

  EditUnurgentPrice() {
    showUnurgentPriceField = false.obs;
    if (UnurgentController.text == '' || UnurgentController.text == '0') {
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
    if (urgentController.text == '' || UnurgentController.text == '0') {
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

/////////////////////////////////////////////Add Services///////////////////////////////////////////

  void addservice() async {
    LoadingHelper.show();
    if (iAudioOrVideo && !isInperson && !isDocument) {
      if (onlineAudioORvideo != null) {
        if (audioORvideo != null) {
          if (workingHours.length != 0) {
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
            String id = box.read('vender_id');
            String? api_token = box.read('api_token');
            print('object**********************************');
            print(iAudioOrVideo);
            var data = {
              'vendor_id': id,
              'api_token': api_token,
              'schedual': workinghours,
              'urgent': urgent,
              'unurgent': unurgent,
              'inperson': InPersonPrice,
              'audiovideo': audioORvideo,
              'onlineaudiovideo': onlineAudioORvideo,
              'urgentprice': urgentPrice,
              'unurgentprice': UnurgentPrice,
              // 'latitude': chnagePoint!.latitude.toString(),
              // 'longitude': chnagePoint!.longitude.toString(),
              // 'radius': radius.toString(),
              'isInperson': isInperson,
              'isAudioVideo': iAudioOrVideo,
              'isdocument': isDocument
            };
            var response = await Api.execute(url: url, data: data);
            print(response);
            LoadingHelper.dismiss();
            Get.snackbar(
                'Successfully.', 'Service has been added successfully.',
                colorText: Colors.white,
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM);
            Get.to(() => MainScreen());
            return response;
          } else {
            LoadingHelper.dismiss();
            Get.snackbar('Error!', 'Working hours not defined.',
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
    } else if (!iAudioOrVideo && isInperson && !isDocument) {
      if (chnagePoint != null) {
        if (radius != null) {
          if (InPersonPrice != null) {
            if (workingHours.length != 0) {
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
              String id = box.read('vender_id');
              String? api_token = box.read('api_token');
              var data = {
                'vendor_id': id,
                'api_token': api_token,
                'schedual': workinghours,
                'urgent': urgent,
                'unurgent': unurgent,
                'inperson': InPersonPrice,
                'audiovideo': audioORvideo,
                'onlineaudiovideo': onlineAudioORvideo,
                'urgentprice': urgentPrice,
                'unurgentprice': UnurgentPrice,
                'latitude': chnagePoint!.latitude.toString(),
                'longitude': chnagePoint!.longitude.toString(),
                'radius': radius.toString(),
                'isInperson': isInperson,
                'isAudioVideo': iAudioOrVideo,
                'isdocument': isDocument
              };
              var response = await Api.execute(url: url, data: data);
              print(response);
              LoadingHelper.dismiss();
              Get.snackbar(
                  'Successfully.', 'Service has been added successfully.',
                  colorText: Colors.white,
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.BOTTOM);
              Get.to(() => MainScreen());
              return response;
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
          Get.snackbar(
              'Error!', 'Select Location And save before procede next.',
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
    } else if (!iAudioOrVideo && !isInperson && isDocument) {
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
                String id = box.read('vender_id');
                String? api_token = box.read('api_token');
                var data = {
                  'vendor_id': id,
                  'api_token': api_token,
                  'schedual': workinghours,
                  'urgent': urgent,
                  'unurgent': unurgent,
                  'inperson': InPersonPrice,
                  'audiovideo': audioORvideo,
                  'onlineaudiovideo': onlineAudioORvideo,
                  'urgentprice': urgentPrice,
                  'unurgentprice': UnurgentPrice,
                  // 'latitude': chnagePoint!.latitude.toString(),
                  // 'longitude': chnagePoint!.longitude.toString(),
                  // 'radius': radius.toString(),
                  'isInperson': isInperson,
                  'isAudioVideo': iAudioOrVideo,
                  'isdocument': isDocument
                };
                var response = await Api.execute(url: url, data: data);
                print(response);
                LoadingHelper.dismiss();
                Get.snackbar(
                    'Successfully.', 'Service has been added successfully.',
                    colorText: Colors.white,
                    backgroundColor: Colors.green,
                    snackPosition: SnackPosition.BOTTOM);
                Get.to(() => MainScreen());
                return response;
              } else {
                LoadingHelper.dismiss();
                Get.snackbar(
                    'Error!', 'Unurgent Per page price is not defined.',
                    colorText: Colors.white,
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM);
              }
            } else {
              LoadingHelper.dismiss();
              Get.snackbar('Error!', 'urgetnt Per page price is not defined.',
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
    } else if (iAudioOrVideo && isInperson && !isDocument) {
      if (chnagePoint != null) {
        if (radius != null) {
          if (onlineAudioORvideo != null) {
            if (audioORvideo != null) {
              if (InPersonPrice != null) {
                if (workingHours.length != 0) {
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
                  String id = box.read('vender_id');
                  String? api_token = box.read('api_token');
                  var data = {
                    'vendor_id': id,
                    'api_token': api_token,
                    'schedual': workinghours,
                    'urgent': urgent,
                    'unurgent': unurgent,
                    'inperson': InPersonPrice,
                    'audiovideo': audioORvideo,
                    'onlineaudiovideo': onlineAudioORvideo,
                    'urgentprice': urgentPrice,
                    'unurgentprice': UnurgentPrice,
                    'latitude': chnagePoint!.latitude.toString(),
                    'longitude': chnagePoint!.longitude.toString(),
                    'radius': radius.toString(),
                    'isInperson': isInperson,
                    'isAudioVideo': iAudioOrVideo,
                    'isdocument': isDocument
                  };
                  var response = await Api.execute(url: url, data: data);
                  print(response);
                  LoadingHelper.dismiss();
                  Get.snackbar(
                      'Successfully.', 'Service has been added successfully.',
                      colorText: Colors.white,
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM);
                  Get.to(() => MainScreen());
                  return response;
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
          Get.snackbar(
              'Error!', 'Select Location And save before procede next.',
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
    } else if (iAudioOrVideo && !isInperson && isDocument) {
      if (onlineAudioORvideo != null) {
        if (audioORvideo != null) {
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
                    String id = box.read('vender_id');
                    String? api_token = box.read('api_token');
                    var data = {
                      'vendor_id': id,
                      'api_token': api_token,
                      'schedual': workinghours,
                      'urgent': urgent,
                      'unurgent': unurgent,
                      'inperson': InPersonPrice,
                      'audiovideo': audioORvideo,
                      'onlineaudiovideo': onlineAudioORvideo,
                      'urgentprice': urgentPrice,
                      'unurgentprice': UnurgentPrice,
                      // 'latitude': chnagePoint!.latitude.toString(),
                      // 'longitude': chnagePoint!.longitude.toString(),
                      // 'radius': radius.toString(),
                      'isInperson': isInperson,
                      'isAudioVideo': iAudioOrVideo,
                      'isdocument': isDocument
                    };
                    var response = await Api.execute(url: url, data: data);
                    print(response);
                    LoadingHelper.dismiss();
                    Get.snackbar(
                        'Successfully.', 'Service has been added successfully.',
                        colorText: Colors.white,
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM);
                    Get.to(() => MainScreen());
                    return response;
                  } else {
                    LoadingHelper.dismiss();
                    Get.snackbar(
                        'Error!', 'Unurgent Per page price is not defined.',
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
    } else if (!iAudioOrVideo && isInperson && isDocument) {
      if (chnagePoint != null) {
        if (radius != null) {
          if (onlineAudioORvideo != null) {
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
                        String id = box.read('vender_id');
                        String? api_token = box.read('api_token');
                        var data = {
                          'vendor_id': id,
                          'api_token': api_token,
                          'schedual': workinghours,
                          'urgent': urgent,
                          'unurgent': unurgent,
                          'inperson': InPersonPrice,
                          'audiovideo': audioORvideo,
                          'onlineaudiovideo': onlineAudioORvideo,
                          'urgentprice': urgentPrice,
                          'unurgentprice': UnurgentPrice,
                          'latitude': chnagePoint!.latitude.toString(),
                          'longitude': chnagePoint!.longitude.toString(),
                          'radius': radius.toString(),
                          'isInperson': isInperson,
                          'isAudioVideo': iAudioOrVideo,
                          'isdocument': isDocument
                        };
                        var response = await Api.execute(url: url, data: data);
                        print(response);
                        LoadingHelper.dismiss();
                        Get.snackbar('Successfully.',
                            'Service has been added successfully.',
                            colorText: Colors.white,
                            backgroundColor: Colors.green,
                            snackPosition: SnackPosition.BOTTOM);
                        Get.to(() => MainScreen());
                        return response;
                      } else {
                        LoadingHelper.dismiss();
                        Get.snackbar(
                            'Error!', 'Unurgent Per page price is not defined.',
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
            Get.snackbar('Error!', 'Online Audio/Video price is not defined.',
                colorText: Colors.white,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          LoadingHelper.dismiss();
          Get.snackbar(
              'Error!', 'Select Location And save before procede next.',
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
    } else if (iAudioOrVideo && isInperson && isDocument) {
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
                              unurgentdocument
                                  .map((wh) => wh.toJson())
                                  .toList();
                          String unurgent = jsonEncode(jsonList2);
                          var url = BASE_URL + 'service/store';
                          GetStorage box = GetStorage();
                          String id = box.read('vender_id');
                          String? api_token = box.read('api_token');
                          var data = {
                            'vendor_id': id,
                            'api_token': api_token,
                            'schedual': workinghours,
                            'urgent': urgent,
                            'unurgent': unurgent,
                            'inperson': InPersonPrice,
                            'audiovideo': audioORvideo,
                            'onlineaudiovideo': onlineAudioORvideo,
                            'urgentprice': urgentPrice,
                            'unurgentprice': UnurgentPrice,
                            'latitude': chnagePoint!.latitude.toString(),
                            'longitude': chnagePoint!.longitude.toString(),
                            'radius': radius.toString(),
                            'isInperson': isInperson,
                            'isAudioVideo': iAudioOrVideo,
                            'isdocument': isDocument
                          };
                          var response =
                              await Api.execute(url: url, data: data);
                          print(response);
                          LoadingHelper.dismiss();
                          Get.snackbar('Successfully.',
                              'Service has been added successfully.',
                              colorText: Colors.white,
                              backgroundColor: Colors.green,
                              snackPosition: SnackPosition.BOTTOM);
                          Get.to(() => MainScreen());
                          return response;
                        } else {
                          LoadingHelper.dismiss();
                          Get.snackbar('Error!',
                              'Unurgent Per page price is not defined.',
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
                      Get.snackbar(
                          'Error!', 'Unurgent document data is missing.',
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
          Get.snackbar(
              'Error!', 'Select Location And save before procede next.',
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
      Get.snackbar('Error!', 'Select atleast one service type.',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

/////////////////////////////////////////////GET Location///////////////////////////////////////////

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
    return 'latitude: ${locationData!.latitude}, longitude: ${locationData!.longitude}';
  }

/////////////////////////////////////////////Clear Varaible//////////////////////////////////////////

  clearServiceScreen() {
    iAudioOrVideo = false;
    isInperson = false;
    isDocument = false;
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

/////////////////////////////////////GET Services Data To edit///////////////////////////////////////

  getservice() async {
    LoadingHelper.show();
    var url = BASE_URL + 'service/get';
    GetStorage box = GetStorage();
    String vendor_id = box.read('vendor_id');
    print(vendor_id);
    var data = {
      'id': vendor_id,
    };
    print(data);
    var response = await Api.execute(url: url, data: data);
    print(response);
    if (!response['error']) {
      response['service'] != null
          ? service = VendorService(response['service'])
          : '';
      if (response['service'] != null) {
        iAudioOrVideo = response['service']['isAudioVideo'];
        isInperson = response['service']['isInperson'];
        isDocument = response['service']['isdocument'];
      }
      update();
      LoadingHelper.dismiss();
    } else {
      LoadingHelper.dismiss();
      Get.snackbar('Error!', response['error_data']);
    }
  }
}
