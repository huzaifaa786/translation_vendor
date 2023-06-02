import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/models/notification.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/values/string.dart';

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();

  List<Notificationn> notifications = [];
  getnoti() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendor/notification';
    GetStorage box = GetStorage();

    String api_token = box.read('api_token');
    int vendor_id = box.read('vendor_id');
    var data = {
      'api_token': api_token,
      'id': vendor_id,
    };
    print(data);
    var response = await Api.execute(url: url, data: data);

    if (!response['error']) {
      for (var van in response['notifications']) {
        notifications.add(Notificationn(van));
      }
      print(response);
      LoadingHelper.dismiss();

     
    } else {
      print(response['error']);
      LoadingHelper.dismiss();
    }
  }
}
