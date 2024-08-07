// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/screen/forgot.dart/emailOtp.dart';
import 'package:translation_vendor/static/input_field1.dart';
import 'package:translation_vendor/screen/login/authcontroller.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/values/Validator.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AuthController>(
            builder: (controller) => SingleChildScrollView(
                  child: Stack(
                    children: [
                      // Image.asset(
                      //   "assets/images/loginback.jpg",
                      //   height: MediaQuery.of(context).size.height * 0.25,
                      //   width: double.infinity,
                      // ),
                      Column(
                        children: [
                          Container(
                            height: Get.height * 0.2,
                            color: greenish,
                            child: Center(
                              child: Image(
                                image:
                                    AssetImage("assets/images/splashLogo.png"),
                                height: 105,
                                color: White,
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: MediaQuery.of(context).size.height * 0.72,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 250, 250, 250),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30))),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 20),
                                      child: Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            color: mainColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: InputField1(
                                        hint: 'Email Address ',
                                        icon: 'assets/images/email.svg',
                                        controller: authController.forgotemail,
                                        validator: (user) =>
                                            Validators.emptyStringValidator(
                                                user, 'Email'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.08,
                                      width: Get.width * 0.4,
                                      child: LargeButton(
                                        title: 'NEXT',
                                        buttonWidth: 0.9,
                                        onPressed: () {
                                          authController
                                              .getOTPusingEmail((success) {
                                            if (success) {
                                              Get.to(
                                                  () => EmailOtpVerifyScreen());
                                            }
                                          });
                                        },
                                        color: mainColor,
                                        textcolor: Colors.white,
                                      ),
                                    ),
                                  ]),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
