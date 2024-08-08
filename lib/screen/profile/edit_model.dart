import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/screen/profile/profilecontroller.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/password_field_two.dart';
import 'package:translation_vendor/values/Validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Change Password",
                style: TextStyle(
                    color: greenish, fontSize: 20, fontWeight: FontWeight.w700),
              )
            ],
          ),
          SizedBox(height: 10),
          InputFieldPasswordTwo(
            label: "Old password",
            // hint: 'Enter current password',
            toggle: _toggle,
            obscure: _passwordVisible,
            controller: profileController.currentPassword,
            validate: profileController.validateChangepasswordForm,
            validator: (password) => Validators.passwordValidator(password),
          ),
          SizedBox(height: 10),
          InputFieldPasswordTwo(
            label: "New password",
            // hint: 'Enter new password',
            toggle: _toggle1,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _newpasswordVisible,
            controller: profileController.newPassword,
            validate: profileController.validateChangepasswordForm,
            validator: (password) => Validators.passwordValidator(password),
          ),
          SizedBox(height: 10),
          InputFieldPasswordTwo(
            label: "Confirm new password",
            // hint: 'Enter confirm new password',
            toggle: _toggle2,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _cpasswordVisible,
            controller: profileController.confirmNewPassword,
            validate: profileController.validateChangepasswordForm,
            validator: (password) => Validators.passwordValidator(password),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 120,
                  child: LargeButton(
                    title: 'Update',
                    textcolor: White,
                    onPressed: () {
                      print('object');
                      profileController.changepassword((success) {
                        if (success) {
                          Get.back();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  insetAnimationCurve: Curves.bounceOut,
                                  insetAnimationDuration: Duration(seconds: 2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    height: Get.height * 0.3,
                                    child: Column(
                                      children: [
                                        Gap(15),
                                        Text(
                                          "Successfully \n Updated",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: greenish,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Image.asset(
                                          "assets/images/tick.png",
                                          height: 80,
                                          color: greenish,
                                        ),
                                        Gap(5),
                                        SizedBox(
                                            height: Get.height * 0.06,
                                            width: Get.width * 0.4,
                                            child: LargeButton(
                                                title: "Done",
                                                textcolor: White,
                                                onPressed: () {
                                                  Get.back();
                                                }))
                                      ],
                                    ),
                                  ));
                            },
                          );
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  update(context) {
    Dialog(
      child: Text("Usaa"),
    );

    //   Alert(
    //     style: AlertStyle(
    //       titleStyle: TextStyle(
    //           ),
    //     ),

    //     context: context,
    //     image: Image.asset(
    //       "assets/images/tick.png",
    //       height: 90,
    //       color: greenish,
    //     ),

    //     title: "Successfully Updated ",

    //     buttons: [
    //       DialogButton(
    //         radius: BorderRadius.all(
    //           Radius.circular(30),
    //         ),
    //         height: 50,
    //         width: 100,
    //         child: Text(
    //           "Done",
    //           style: TextStyle(color: Colors.white, fontSize: 20),
    //         ),
    //         onPressed: () {
    //           Get.back();
    //         },
    //         color: mainColor,
    //       ),
    //     ],
    //   ).show();
  }
}
