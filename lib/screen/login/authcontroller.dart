import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/models/vendor.dart';
import 'package:translation_vendor/values/string.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  TextEditingController vendorName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  List? languege = [];
  XFile? passportImage = XFile('');
  XFile? certificateImage = XFile('');

    static register(name, email, phone, password,type) async {
   

    var url = BASE_URL + 'register';
    var data;
    data = {
      'name': name.text.toString(),
      'email': email.text.toString(),
      'phone': phone.toString(),
      'password': password.text.toString(),
     
      'user_type': type
    };

    var response = await Api.execute(
      url: url,
      data: data,
    );
    print(response);
  
    if (!response['error']) {
      Vendor vendor = Vendor(response['vendor']);
   
      return true;
    } else {
      print('error');
      // Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }
}
