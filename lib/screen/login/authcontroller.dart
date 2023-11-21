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
  TextEditingController forgotemail = TextEditingController();
  TextEditingController resetPassword = TextEditingController();
  var otp;
  RxBool verify = true.obs;
  RxBool validateForgotForm = false.obs;
  RxBool validateSignUpForm = false.obs;
  RxBool validateSignInForm = false.obs;
  RxBool success = new RxBool(true);
  TextEditingController vendorName = TextEditingController();
  TextEditingController certificateName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController languageController = TextEditingController();
  String year = '';
  String month = '';
  String day = '';
  List? languege = [];
  XFile? passportImage = XFile('');
  XFile? certificateImage = XFile('');
  XFile? CVImage = XFile('');

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
    email.clear();
    password.clear();
    confirmPassword.clear();
    languageController.clear();
    certificateName.clear();
    phone.clear();
    year = '';
    month = '';
    day = '';
    languege = [];
    passportImage = XFile('');
    CVImage = XFile('');
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

  Future<void> selectCVImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CVImage = image;
      update();
    } else {
      CVImage = XFile('');
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

  // deleteLang() {
   
  // }

//////////////////////////  Register Functions   ///////////////////////////////////

  void SignUp(void Function(bool) callback) async {
    LoadingHelper.show();
    final bool isFormValid = Validators.languageValidator(languege) == null &&
        Validators.emptyStringValidator(vendorName.text, '') == null &&
        Validators.emptyStringValidator(userName.text, '') == null &&
        Validators.emptyStringValidator(password.text, '') == null &&
        Validators.emptyStringValidator(confirmPassword.text, '') == null &&
        Validators.emailValidator(email.text) == null;
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
            if (CVImage!.path != '') {
              if (passportImage!.path != '') {
                final passport =
                    base64Encode(File(passportImage!.path).readAsBytesSync());
                final cv = base64Encode(File(CVImage!.path).readAsBytesSync());

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
                        'email': email.text.toString(),
                        'DOB': date.toString(),
                        'password': password.text.toString(),
                        'passport': passport,
                        'language': lang,
                        'number': phone.text.toString(),
                        'firebase_token': token,
                        'cvImage': cv,
                      };

                      var response = await Api.execute(
                        url: url,
                        data: data,
                      );
                      print((response['Vendor']));

                      if (!response['error']) {
                        LoadingHelper.dismiss();
                        Get.offAll(() => LoginScreen());
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
                    final cv =
                        base64Encode(File(CVImage!.path).readAsBytesSync());

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
                          'email': email.text.toString(),
                          'DOB': date.toString(),
                          'password': password.text.toString(),
                          'passport': passport,
                          'certificate': certificate,
                          'certifcate_name': certificateName.text.toString(),
                          'language': lang,
                          'cvImage': cv,
                          'number': phone.text.toString(),
                          'firebase_token': token
                        };
                        var response = await Api.execute(url: url, data: data);
                        if (!response['error']) {
                          Get.offAll(() => LoginScreen());
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
              Get.snackbar("Cv Image can't be empty.", '',
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
    final bool isFormValid = Validators.emailValidator(email.text) == null &&
        Validators.emptyStringValidator(password.text, '') == null;
    if (isFormValid) {
      var token = await FirebaseMessaging.instance.getToken();
      var url = BASE_URL + 'vendor/login';
      var data = {
        'email': email.text.toString(),
        'password': password.text.toString(),
        'firebase_token': token.toString(),
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
        Get.snackbar(response['error_data'], '',
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
    box.remove('vendor_id');
    Get.snackbar('Logout Successfully', '',
        colorText: Colors.white,
        backgroundColor: mainColor,
        snackPosition: SnackPosition.BOTTOM);
    Get.offAll(() => LoginScreen());
    LoadingHelper.dismiss();
  }

  ////////////////////////////////// Fetch User AND Send Otp to Mail if user exit ////////////////////////////////

  getOTPusingEmail(void Function(bool) callback) async {
    LoadingHelper.show();
    print(forgotemail.text);
    if (forgotemail.text.isNotEmpty) {
      var url = BASE_URL + 'forgetvendorpassword';
      var data = {'email': forgotemail.text.toString()};

      var response = await Api.execute(url: url, data: data);
      LoadingHelper.dismiss();
      if (!response['error']) {
        otp = response['otp'];
        Get.snackbar('OTP sent successfully!',
            'We have sent a One-Time Password (OTP) to your registered email address.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: mainColor,
            colorText: Colors.white);
        return callback(true);
      } else {
        LoadingHelper.dismiss();
        print(response['error_data']);
        Get.snackbar('ERROR!', response['error_data'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }
    } else {
      LoadingHelper.dismiss();
    }
  }

  //////////////////// Call This function after otp Successfully placed to reset Password ////////////////////

  ResetPassword(void Function(bool) callback) async {
    print(resetPassword.text);
    final bool isFormValid =
        Validators.passwordValidator(resetPassword.text) == null;
    if (!isFormValid) {
      return callback(false);
    } else {
      LoadingHelper.show();
      var url = BASE_URL + 'vendorforgetchangepassword';
      var data = {
        'email': forgotemail.text.toString(),
        'password': resetPassword.text.toString()
      };
      var response = await Api.execute(url: url, data: data);
      print(response);
      if (!response['error']) {
        LoadingHelper.dismiss();
        // GetStorage box = GetStorage();
        // box.write('api_token', response['update']['api_token']);
        ClearForgotVariable();
        return callback(true);
      } else {
        LoadingHelper.dismiss();
        return callback(false);
      }
    }
  }

////////////////////////////////// Clear Forgot Screen Variables //////////////////////////////////////////////

  ClearForgotVariable() {
    forgotemail.clear();
    resetPassword.clear();
    update();
  }
}
