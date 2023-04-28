import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/models/vendor.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/values/Validator.dart';
import 'package:translation_vendor/values/string.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxBool validateSignUpForm = false.obs;
  RxBool success = new RxBool(true);

//////////////////////////  Register screen Variables & functions   ///////////////////////////////////

  TextEditingController vendorName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController languageController = TextEditingController();
  String year = '';
  String month = '';
  String day = '';
  List? languege = [];
  XFile? passportImage = XFile('');
  XFile? certificateImage = XFile('');

  void showErrors() {
    validateSignUpForm = true.obs;
  }

  ClearSignupVariables() {
    vendorName.clear();
    userName.clear();
    password.clear();
    confirmPassword.clear();
    languageController.clear();
    year = '';
    month = '';
    day = '';
    languege = [];
    passportImage = XFile('');
    certificateImage = XFile('');
  }

  Future<void> selectPassportImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      passportImage = image;
      update();
    }
  }

  Future<void> selectCertificateImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      certificateImage = image;
      update();
    }
  }

  Future<void> storeLanguageList() async {
    print('object');
    languege!.add(languageController.text);
    print(languege);
    update();
    languageController.clear();
  }

  void SignUp(void Function(bool) callback) async {
    final bool isFormValid =
        Validators.emptyStringValidator(vendorName.text, '') == null &&
            Validators.emptyStringValidator(userName.text, '') == null &&
            Validators.emptyStringValidator(password.text, '') == null &&
            Validators.emptyStringValidator(confirmPassword.text, '') == null;
    if (isFormValid) {
      print(vendorName.text);
      print(userName.text);
      print(password.text);
      print(confirmPassword.text);
      print(passportImage!.name);
      print(certificateImage!.name);
      if (year == '') {
        Get.snackbar('Invalid Date Format.', 'Select complete Date of Birth.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        print('object');
      } else {
        if (month != '') {
          if (day != '') {
            DateTime date = DateTime(int.parse(year.toString()),
                int.parse(month.toString()), int.parse(day.toString()));
            print(date);
            if (passportImage!.path != '') {
              final passport =
                  base64Encode(File(passportImage!.path).readAsBytesSync());

              if (languege!.length >= 1) {
                if (certificateImage!.path == '') {
                  var url = BASE_URL + 'register';
                  var data;
                  data = {
                    'name': vendorName.text.toString(),
                    'username': userName.text.toString(),
                    'DOB': date.toString(),
                    'password': password.text.toString(),
                    'passport': passport,
                    'language': jsonEncode(languege)
                  };

                  var response = await Api.execute(
                    url: url,
                    data: data,
                  );
                  print(response);

                  if (!response['error']) {
                    Vendor vendor = Vendor(response['vendor']);
                    print(vendor);
                    return callback(true);
                  } else {
                    print('error');
                    // Fluttertoast.showToast(msg: response['error_data']);
                    return callback(false);
                  }
                } else {
                  final certificate = base64Encode(
                      File(certificateImage!.path).readAsBytesSync());
                  var url = BASE_URL + 'register';
                  var data;
                  data = {
                    'name': vendorName.text.toString(),
                    'username': userName.text.toString(),
                    'DOB': date,
                    'password': password.text.toString(),
                    'passport': passport,
                    'certificate': certificate,
                    'language': jsonEncode(languege)
                  };

                  var response = await Api.execute(
                    url: url,
                    data: data,
                  );
                  print(response);

                  if (!response['error']) {
                    Vendor vendor = Vendor(response['vendor']);
                    print(vendor);
                    return callback(true);
                  } else {
                    print('error');
                    // Fluttertoast.showToast(msg: response['error_data']);
                    return callback(false);
                  }
                }
              } else {
                Get.snackbar("Language Field Invalid.",
                    'Select more then 2 language atleast.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
              }
            } else {
              Get.snackbar("Passport Image can't be empty.", '',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
          } else {
            Get.snackbar(
                'Invalid Date Format.', 'Select complete Date of Birth.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        } else {
          Get.snackbar('Invalid Date Format.', 'Select complete Date of Birth.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      }
    } else {
      showErrors();
    }
  }

  alerts() async {
    await Get.defaultDialog(
        title:
            "You have Successfully Submitted  your application and you will notified within24 hours.",
        titlePadding: EdgeInsets.only(top: 16),
        contentPadding: EdgeInsets.all(16),
        titleStyle: TextStyle(color: Colors.red),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You want to remove ',
                style: TextStyle(),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LargeButton(
                    title: 'Remove',
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.red,
                    buttonWidth: 0.25,
                  ),
                  LargeButton(
                    title: 'Cancel',
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.green,
                    buttonWidth: 0.25,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
