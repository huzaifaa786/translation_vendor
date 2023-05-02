import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/values/string.dart';

class MainController extends GetxController {
  static MainController instance = Get.find();
  bool isOnline = false;
  static online() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendor/online';
    var response = await Api.execute(url: url);
    print(response);

    return response;
  }

  toggleonline(index) {
    if (index == 0) {
      isOnline = true;
    } else {
      isOnline = false;
    }
    update();
    online();
  }
}
