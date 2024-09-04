import 'dart:convert';
import 'dart:io';
import 'dart:math';
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
  TextEditingController bioController = TextEditingController();
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
  String? country = '';
  List? languege = [];
  XFile? passportImage = XFile('');
  XFile? certificateImage = XFile('');
  XFile? profileImage = XFile('');

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
    bioController.clear();
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

  ////////////////////profile image////////////////////////
  Future<void> selectProfileImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = image;
      update();
    } else {
      profileImage = XFile('');
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
        Validators.emptyStringValidator(vendorName.text, 'Vendor Name') ==
            null &&
        Validators.emptyStringValidator(userName.text, 'User Name') == null &&
        Validators.emptyStringValidator(password.text, 'Password') == null &&
        Validators.emptyStringValidator(
                confirmPassword.text, 'Confirm Password') ==
            null &&
        Validators.emailValidator(email.text) == null &&
        Validators.emptyStringValidator(phone.text, 'Phone Number') == null &&
        year.isNotEmpty &&
        month.isNotEmpty &&
        day.isNotEmpty;

    if (isFormValid) {
      if (password.text != confirmPassword.text) {
        LoadingHelper.dismiss();
        Get.snackbar("Invalid Password.",
            'Password and Confirm Password must be the same.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }

      DateTime date =
          DateTime(int.parse(year), int.parse(month), int.parse(day));
      if (certificateImage!.path.isEmpty) {
        LoadingHelper.dismiss();
        Get.snackbar("certificateImage can't be empty.",
            'Please select all required images.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }
      if (certificateName.text == '') {
        LoadingHelper.dismiss();
        Get.snackbar("certificateName can't be empty.",
            'Please select all required images.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }
      if (CVImage!.path.isEmpty) {
        LoadingHelper.dismiss();
        Get.snackbar(
            "CVImage can't be empty.", 'Please select all required images.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }
      if (passportImage!.path.isEmpty) {
        LoadingHelper.dismiss();
        Get.snackbar("passportImage can't be empty.",
            'Please select all required images.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }

      if (languege!.length < 2) {
        LoadingHelper.dismiss();
        Get.snackbar(
            "Language Field Invalid.", 'Select at least two languages.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }

      var token = await FirebaseMessaging.instance.getToken();
      var lang = jsonEncode(languege);
      var passport = base64Encode(File(passportImage!.path).readAsBytesSync());
      var cv = base64Encode(File(CVImage!.path).readAsBytesSync());
      var profile = base64Encode(File(profileImage!.path).readAsBytesSync());

      var url = BASE_URL + 'vendor/register';
      var data = {
        'name': vendorName.text,
        'username': userName.text,
        'email': email.text,
        'DOB': date.toString(),
        'password': password.text,
        'passport': passport,
        'language': lang,
        'number': phone.text,
        'firebase_token': token,
        'cvImage': cv,
        'country': country,
        'bio': bioController.text,
        'profilepic': profile
      };
      print('ddddddddddddddddddddddddddddffffffff');
      print(data);
      if (certificateImage!.path.isNotEmpty) {
        var certificate =
            base64Encode(File(certificateImage!.path).readAsBytesSync());
        data['certificate'] = certificate;
        data['certifcate_name'] = certificateName.text;
      }

      var response = await Api.execute(url: url, data: data);
      print(response);

      if (!response['error']) {
        LoadingHelper.dismiss();
        Get.offAll(() => LoginScreen());
        Vendor vendor = Vendor(response['Vendor']);
        ClearSignupVariables();
        validateSignUpForm = false.obs;
        print('jhhhhhhhhhhhhhhhhhhjjjjjjjjjjjjjjjjjjjjjjjjj');
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
      showErrors();
      update();
    }
  }

  /////////////////////////////
  Future<String?> fetchCountryFromIP() async {
    const url = 'http://ip-api.com/json';

    try {
      var response = await Api.execute(url: url, data: {});

      if (response != null && response['status'] == 'success') {
        return response['country'];
      } else {
        return 'Failed to get country';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  storeCountryToGetTimeZone(country) async {
    const url = BASE_URL + 'user/country/store';

    try {
      GetStorage box = GetStorage();
      var api_token = await box.read('api_token');
      var response = await Api.execute(url: url, data: {
        'api_token': api_token,
        'country': country,
      });

      if (!response['error']) {
      } else {}
    } catch (e) {
      return 'Error: $e';
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
