import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/vendor.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:translation_vendor/values/string.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  XFile? profileimage = XFile('');
  Vendor? vendor;

  Future<void> profileImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileimage = image;
      update();
    }
  }

  getVendor() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendor/show';
    GetStorage box = GetStorage();
    String api_token = box.read('api_token');
    print(api_token);
    var data = {
      'api_token': api_token,
    };
    print(data);
    var response = await Api.execute(url: url, data: data);
    print(response);
    if (!response['error']) {
      vendor = Vendor(response['Vendor']);
      mainController.vendor = vendor;
      mainController.refresh();
      update();
      LoadingHelper.dismiss();
    } else {
      LoadingHelper.dismiss();
      Get.snackbar('Error!', response['error_data']);
    }
  }

  void editprofile() async {
    LoadingHelper.show();

    var url = BASE_URL + 'vendor/update';
    GetStorage box = GetStorage();
    int id = box.read('vender_id');
    String? api_token = box.read('api_token');
    print('objectdfdgfdg');
    final profileimg = base64Encode(File(profileimage!.path).readAsBytesSync());

    var data = {
      'vendor_id': id,
      'api_token': api_token,
      'profilepic': profileimg
    };
    var response = await Api.execute(url: url, data: data);
    print(response);
    LoadingHelper.dismiss();
    return response;
  }
}
