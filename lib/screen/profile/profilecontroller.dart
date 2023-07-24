import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/vendor.dart';
import 'package:translation_vendor/screen/main/main.dart';
import 'package:translation_vendor/screen/services/map.dart';
import 'package:translation_vendor/values/Validator.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:translation_vendor/values/string.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  XFile? profileimg = XFile('');
  Vendor? vendor;
  RxBool showNameField = false.obs;
  TextEditingController userNameController = TextEditingController();
  RxBool showNumberField = false.obs;
  TextEditingController userNumberController = TextEditingController();
  RxBool showEnglishField = false.obs;
  TextEditingController userEngAboutController = TextEditingController();
  RxBool showArabicField = false.obs;
  RxBool showCertificateField = false.obs;
  TextEditingController userArabicAboutController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  XFile? certificateImage = XFile('');
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  TextEditingController certificateName = TextEditingController();
  RxBool validateChangepasswordForm = false.obs;

//////////////////////////// Profile Image Picker //////////////////////////////////////

  selectcertificateImage() async {
    final ImagePicker _picker = ImagePicker();
    var image1 = await _picker.pickImage(source: ImageSource.gallery);
    if (image1 != null) {
      certificateImage = image1;
      // certificateName.text = certificateImage!.name;
      // showCertificateField = false.obs;
      update();
    } else {
      certificateImage = XFile('');
      update();
    }
  }

//////////////////////////// Profile Image Picker //////////////////////////////////////

  Future<void> profileImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileimg = image;
      update();
    } else {
      profileimg = XFile('');
      update();
    }
  }

//////////////////////////// Get Vendor From Database //////////////////////////////////////

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
      update();
      LoadingHelper.dismiss();
    } else {
      LoadingHelper.dismiss();
      Get.snackbar('Error!', response['error_data']);
    }
  }

//////////////////////////// Edit Profile In database //////////////////////////////////////

  void editprofile() async {
    LoadingHelper.show();

    var url = BASE_URL + 'vendor/update';
    GetStorage box = GetStorage();
    String? api_token = box.read('api_token');
    var lang = jsonEncode(vendor!.language);

    if (profileimg!.path != '') {
      final profileimge =
          base64Encode(File(profileimg!.path).readAsBytesSync());
      if (certificateImage!.path != '') {
        print('Yes*****************************************************');
        final certiimge =
            base64Encode(File(certificateImage!.path).readAsBytesSync());
        final bool isFormValid =
            Validators.emptyStringValidator(certificateName.text, '') == null;
        if (isFormValid) {
          var data = {
            'api_token': api_token,
            'profilepic': profileimge,
            'username': vendor!.username,
            'about(Eng)': vendor!.aboutEng,
            'about(arabic)': vendor!.aboutArabic,
            'language': lang,
            'certificate': certiimge,
            'certifcate_name': certificateName.text.toString(),
          };
          var response = await Api.execute(url: url, data: data);
          if (!response['error']) {
            vendor = Vendor(response['vendor']);
            mainController.vendor = vendor;
            mainController.refresh();
            update();
            Get.snackbar("Upadte.", "Profile Update Sucessfully.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white);
            Get.offAll(() => MainScreen());
            LoadingHelper.dismiss();
          } else {
            LoadingHelper.dismiss();
            Get.snackbar('Error!', response['error_data'],
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
      } else {
        print('No*****************************************************');
        var data = {
          'api_token': api_token,
          'profilepic': profileimge,
          'username': vendor!.username,
          'about(Eng)': vendor!.aboutEng,
          'about(arabic)': vendor!.aboutArabic,
          'language': lang,
        };
        var response = await Api.execute(url: url, data: data);
        if (!response['error']) {
          vendor = Vendor(response['vendor']);
          mainController.vendor = vendor;
          mainController.refresh();
          update();
          Get.snackbar("Upadte.", "Profile Update Sucessfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          Get.offAll(() => MainScreen());
          LoadingHelper.dismiss();
        } else {
          LoadingHelper.dismiss();
          Get.snackbar('Error!', response['error_data']);
        }
      }
    } else {
      if (certificateImage!.path != '') {
        print('yes***********************************************');
        final certiimge =
            base64Encode(File(certificateImage!.path).readAsBytesSync());
        final bool isFormValid =
            Validators.emptyStringValidator(certificateName.text, '') == null;
        if (isFormValid) {
          var data = {
            'api_token': api_token,
            'username': vendor!.username,
            'about(Eng)': vendor!.aboutEng,
            'about(arabic)': vendor!.aboutArabic,
            'language': lang,
            'number': vendor!.number,
            'certificate': certiimge,
            'certifcate_name': certificateName.text.toString(),
          };
          var response = await Api.execute(url: url, data: data);
          if (!response['error']) {
            vendor = Vendor(response['vendor']);
            mainController.vendor = vendor;
            mainController.refresh();
            update();
            Get.snackbar("Upadte.", "Profile Update Sucessfully.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white);
            Get.offAll(() => MainScreen());
            LoadingHelper.dismiss();
          } else {
            LoadingHelper.dismiss();
            Get.snackbar('Error!', response['error_data'],
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
      } else {
        print('No*****************************************************');
        var data = {
          'api_token': api_token,
          'username': vendor!.username,
          'about(Eng)': vendor!.aboutEng,
          'about(arabic)': vendor!.aboutArabic,
          'language': lang,
          'number': vendor!.number,
        };
        var response = await Api.execute(url: url, data: data);
        if (!response['error']) {
          vendor = Vendor(response['vendor']);
          mainController.vendor = vendor;
          mainController.refresh();
          update();
          Get.snackbar("Upadte.", "Profile Update Sucessfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          Get.offAll(() => MainScreen());
          LoadingHelper.dismiss();
        } else {
          LoadingHelper.dismiss();
          Get.snackbar('Error!', response['error_data']);
        }
      }
    }
  }

/////////////////////////////// Change Password /////////////////////////////

  void changepassword(void Function(bool) callback) async {
    LoadingHelper.show();
    final bool isFormValid =
        Validators.passwordValidator(currentPassword.text) == null &&
            Validators.passwordValidator(newPassword.text) == null &&
            Validators.passwordValidator(confirmNewPassword.text) == null;
    if (isFormValid) {
      if (newPassword.text == confirmNewPassword.text) {
        var url = BASE_URL + 'vendor/changepassword';
        GetStorage box = GetStorage();
        String api_token = box.read('api_token');
        print(api_token);
        var data = {
          'api_token': api_token,
          'password': currentPassword.text.toString(),
          'newpassword': newPassword.text.toString()
        };
        var response = await Api.execute(url: url, data: data);
        print(response);
        if (!response['error']) {
          LoadingHelper.dismiss();
          update();
          clearchangepasswordVariables();
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
        Get.snackbar(
            "Invalid Password.", 'Passowrd And Confirm passsword must be same.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return callback(false);
      }
    } else {
      showError();
      update();
      print(validateChangepasswordForm);
      LoadingHelper.dismiss();
    }
  }

  void showError() {
    validateChangepasswordForm = true.obs;
    update();
  }

//////////////////////////// Name Edit //////////////////////////////////////

  openTextField() {
    showNameField = true.obs;
    userNameController.text = vendor!.username!;
    update();
  }

  EditText() {
    showNameField = false.obs;
    vendor!.username = userNameController.text;
    update();
  }

//////////////////////////// Number Edit //////////////////////////////////////

  openNumberField() {
    showNumberField = true.obs;
    userNumberController.text = vendor!.number!;
    update();
  }

  EditNumber() {
    showNumberField = false.obs;
    vendor!.number = userNumberController.text;
    update();
  }

//////////////////////////// English About Edit //////////////////////////////////////

  openEngField() {
    showEnglishField = true.obs;
    userEngAboutController.text = vendor!.aboutEng!;
    update();
  }

  EditEngAbout() {
    showEnglishField = false.obs;
    vendor!.aboutEng = userEngAboutController.text;
    update();
  }

  //////////////////////////// Arabic About Edit //////////////////////////////////////

  openArabicField() {
    showArabicField = true.obs;
    userArabicAboutController.text = vendor!.aboutArabic!;
    update();
  }

  EditArabicAbout() {
    showArabicField = false.obs;
    vendor!.aboutArabic = userArabicAboutController.text;
    update();
  }

//////////////////////////Clear Screen Variables///////////////////////////

  clearVariables() {
    showNameField = false.obs;
    profileimg = XFile('');
    certificateImage = XFile('');
    vendor = null;
    languageController.clear();
    certificateName.clear();
    showCertificateField = false.obs;
  }

  clearchangepasswordVariables() {
    currentPassword.clear();
    newPassword.clear();
    confirmNewPassword.clear();
  }

///////////////////////// Language Edit /////////////////////////////////////
  String? selectedLanguage;

  void addLanguage() {
    vendor!.language!.add(selectedLanguage);
    print(vendor!.language);
    selectedLanguage = null;
    update();
  }

////////////////////////////// Certificate //////////////////////////////////

  openCertificateField() {
    print(showCertificateField.value.obs);
    showCertificateField.value = !showCertificateField.value;
    update();
  }
}
