import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/screen/profile/profilecontroller.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/password_field_two.dart';
import 'package:translation_vendor/values/Validator.dart';
import 'dart:ui' as ui;

import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class EditModel extends StatefulWidget {
  EditModel({Key? key}) : super(key: key);

  @override
  State<EditModel> createState() => _EditModelState();
}

class _EditModelState extends State<EditModel> {
  bool _passwordVisible = true;
  bool _newpasswordVisible = true;
  bool _cpasswordVisible = true;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggle1() {
    setState(() {
      _newpasswordVisible = !_newpasswordVisible;
    });
  }

  void _toggle2() {
    setState(() {
      _cpasswordVisible = !_cpasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          InputFieldPasswordTwo(
            hint: 'Enter current password',
            toggle: _toggle,
            obscure: _passwordVisible,
            controller: profileController.currentPassword,
            validate: profileController.validateChangepasswordForm,
            validator: (password) => Validators.passwordValidator(password),
          ),
          SizedBox(height: 10),
          InputFieldPasswordTwo(
            hint: 'Enter new password',
            toggle: _toggle1,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _newpasswordVisible,
            controller: profileController.newPassword,
            validate: profileController.validateChangepasswordForm,
            validator: (password) => Validators.passwordValidator(password),
          ),
          SizedBox(height: 10),
          InputFieldPasswordTwo(
            hint: 'Enter confirm new password',
            toggle: _toggle2,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _cpasswordVisible,
            controller: profileController.confirmNewPassword,
            validate: profileController.validateChangepasswordForm,
            validator: (password) => Validators.passwordValidator(password),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LargeButton(
              title: 'Change',
              textcolor: White,
              onPressed: () {
                print('object');
                profileController.changepassword((success) {
                  if (success) {
                    // update(context);
                    Get.back();
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
