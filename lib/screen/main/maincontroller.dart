import 'dart:developer';

import 'package:get/get.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/vendor.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:translation_vendor/values/string.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  static MainController instance = Get.find();
  bool isOnline = false;
  int i = 0;

  CheckNotications() async {
    LoadingHelper.show();
    var url = BASE_URL + 'notification/check';
    GetStorage box = GetStorage();

    String api_token = box.read('api_token');
    var data = {'api_token': api_token};
    var response = await Api.execute(url: url, data: data);

    LoadingHelper.dismiss();
    if (response['exist'] == true) {
      print("kjkjkjhkjhkjh");
      return true;
    } else {
      print("kjkjkjhkjhkjhghjgjhgjhg");
      return false;
    }
  }

  void online() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendor/online';
    GetStorage box = GetStorage();
    String api_token = box.read('api_token');
    print(api_token);
    var data = {
      'api_token': api_token,
      'online': isOnline.toString(),
    };
    var response = await Api.execute(url: url, data: data);
    print('AAAAAAAAAAAAAAAAAAAAAAQQQQQQQQQQQQQQQQQQQQQQQQQQQQQFFFFFFFFFFFFFFF');
    print(response);
    LoadingHelper.dismiss();
    return response;
  }

  toggleonline(index) {
    if (index == 0) {
      isOnline = true;
      i = index;
    } else {
      isOnline = false;
      i = index;
    }
    update();
    online();
  }

  Vendor? vendor;

  void getVendor() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendor/show';
    GetStorage box = GetStorage();
    String api_token = box.read('api_token');

    var data = {
      'api_token': api_token,
    };
    print(data);
    var response = await Api.execute(url: url, data: data);
    print(response);
    if (!response['error']) {
      vendor = Vendor(response['Vendor']);
      GetStorage box = GetStorage();
      box.write('vender_id', vendor!.id);
      if (vendor!.online == 1) {
        i = 0;
        print(i);
      } else {
        i = 1;
        print(i);
      }
      update();
      LoadingHelper.dismiss();
    } else {
      LoadingHelper.dismiss();
      Get.snackbar('Error!', response['error_data']);
    }
  }
}
