import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/vendor.dart';
import 'package:translation_vendor/screen/login/login.dart';
import 'package:translation_vendor/values/Validator.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/string.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

//////////////////////////  Auth Variable   ///////////////////////////////////

  RxBool validateSignUpForm = false.obs;
  RxBool validateSignInForm = false.obs;
  RxBool success = new RxBool(true);
  TextEditingController vendorName = TextEditingController();
  TextEditingController certificateName = TextEditingController();
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

//////////////////////////  Error Show Functions   ///////////////////////////////////

  void showErrors() {
    validateSignUpForm = true.obs;
    update();
  }

  void showSignInErrors() {
    validateSignInForm = true.obs;
    update();
  }

//////////////////////////  Clear Variable Functions   ///////////////////////////////////

  ClearSignupVariables() {
    vendorName.clear();
    userName.clear();
    password.clear();
    confirmPassword.clear();
    languageController.clear();
    certificateName.clear();
    year = '';
    month = '';
    day = '';
    languege = [];
    passportImage = XFile('');
    certificateImage = XFile('');
    update();
  }

//////////////////////////  select Passport Image Functions   ///////////////////////////////////

  Future<void> selectPassportImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      passportImage = image;
      update();
    } else {
      passportImage = XFile('');
      update();
    }
  }

//////////////////////////  select Certificate Image Functions   ///////////////////////////////////

  Future<void> selectCertificateImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      certificateImage = image;
      // certificateName.text = certificateImage!.name;
      update();
    } else {
      certificateImage = XFile('');
      update();
    }
  }

//////////////////////////  Language store In list Functions   ///////////////////////////////////
  String? selectedLanguage;

  Future<void> storeLanguageList() async {
    languege!.add(selectedLanguage);
    print(languege);
    update();
    selectedLanguage = null;
  }

//////////////////////////  Register Functions   ///////////////////////////////////

  void SignUp(void Function(bool) callback) async {
    LoadingHelper.show();
    final bool isFormValid = Validators.languageValidator(languege) == null &&
        Validators.emptyStringValidator(vendorName.text, '') == null &&
        Validators.emptyStringValidator(userName.text, '') == null &&
        Validators.emptyStringValidator(password.text, '') == null &&
        Validators.emptyStringValidator(confirmPassword.text, '') == null;
    if (isFormValid) {
      if (year == '') {
        LoadingHelper.dismiss();
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

              if (languege!.length >= 2) {
                if (certificateImage!.path == '') {
                  if (password.text == confirmPassword.text) {
                    var token = await FirebaseMessaging.instance.getToken();
                    var lang = jsonEncode(languege);
                    var url = BASE_URL + 'vendor/register';
                    var data;
                    data = {
                      'name': vendorName.text.toString(),
                      'username': userName.text.toString(),
                      'DOB': date.toString(),
                      'password': password.text.toString(),
                      'passport': passport,
                      'language': lang,
                      'firebase_token': token
                    };

                    var response = await Api.execute(
                      url: url,
                      data: data,
                    );

                    if (!response['error']) {
                      LoadingHelper.dismiss();
                      Vendor vendor = Vendor(response['Vendor']);
                      print(vendor);
                      ClearSignupVariables();
                      validateSignUpForm = false.obs;
                      update();
                      return callback(true);
                    } else {
                      LoadingHelper.dismiss();
                      Get.snackbar("Error!", response['error_data'],
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                      return callback(false);
                    }
                  } else {
                    LoadingHelper.dismiss();
                    Get.snackbar("Invalid Password.",
                        'Passowrd And Confirm passsword must be same.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  }
                } else {
                  final certificate = base64Encode(
                      File(certificateImage!.path).readAsBytesSync());
                  final bool isFormValid = Validators.emptyStringValidator(
                          certificateName.text, '') ==
                      null;
                  if (isFormValid) {
                    if (password.text == confirmPassword.text) {
                      var token = await FirebaseMessaging.instance.getToken();
                      var lang = jsonEncode(languege);
                      var url = BASE_URL + 'vendor/register';
                      var data;
                      data = {
                        'name': vendorName.text.toString(),
                        'username': userName.text.toString(),
                        'DOB': date.toString(),
                        'password': password.text.toString(),
                        'passport': passport,
                        'certificate': certificate,
                        'certifcate_name': certificateName.text.toString(),
                        'language': lang,
                        'firebase_token': token
                      };
                      var response = await Api.execute(url: url, data: data);
                      if (!response['error']) {
                        Vendor vendor = Vendor(response['Vendor']);
                        print(vendor);
                        ClearSignupVariables();
                        validateSignUpForm = false.obs;
                        update();
                        LoadingHelper.dismiss();
                        return callback(true);
                      } else {
                        LoadingHelper.dismiss();
                        Get.snackbar("Error!", response['error_data'],
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                        return callback(false);
                      }
                    } else {
                      LoadingHelper.dismiss();
                      Get.snackbar("Invalid Password.",
                          'Passowrd And Confirm passsword must be same.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                    }
                  } else {
                    LoadingHelper.dismiss();
                    Get.snackbar('Please enter certificate name', '',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  }
                }
              } else {
                LoadingHelper.dismiss();
                Get.snackbar(
                    "Language Field Invalid.", 'Select atleast two Language.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
              }
            } else {
              LoadingHelper.dismiss();
              Get.snackbar("Passport Image can't be empty.", '',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
          } else {
            LoadingHelper.dismiss();
            Get.snackbar(
                'Invalid Date Format.', 'Select complete Date of Birth.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        } else {
          LoadingHelper.dismiss();
          Get.snackbar('Invalid Date Format.', 'Select complete Date of Birth.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      }
    } else {
      LoadingHelper.dismiss();
      showErrors();
      update();
    }
  }

/////////////////////////////// Login Function ///////////////////////////////////////////

  void login(void Function(bool) callback) async {
    LoadingHelper.show();
    final bool isFormValid =
        Validators.emptyStringValidator(userName.text, '') == null &&
            Validators.emptyStringValidator(password.text, '') == null;
    if (isFormValid) {
      var token = await FirebaseMessaging.instance.getToken();
      var url = BASE_URL + 'vendor/login';
      var data = {
        'username': userName.text,
        'password': password.text,
        'firebase_token': token,
      };

      var response = await Api.execute(url: url, data: data);
      if (!response['error']) {
        Vendor vendor = Vendor(response['vendor']);
        GetStorage box = GetStorage();
        box.write('api_token', vendor.apiToken);
        box.write('vendor_id', vendor.id);
        LoadingHelper.dismiss();
        return callback(true);
      } else {
        LoadingHelper.dismiss();
        Get.snackbar('ERROR!', response['error_data'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }
    } else {
      LoadingHelper.dismiss();
      showSignInErrors();
    }
  }

  /////////////////////////////// Logout Function ///////////////////////////////////////////

  void logout() {
    LoadingHelper.show();
    print('object');
    GetStorage box = GetStorage();
    box.remove('api_token');
    Get.snackbar('Logout Successfully', '',
        colorText: Colors.white,
        backgroundColor: mainColor,
        snackPosition: SnackPosition.BOTTOM);
    Get.offAll(() => LoginScreen());
    LoadingHelper.dismiss();
  }
}
