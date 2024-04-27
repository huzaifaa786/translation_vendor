import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:translation_vendor/screen/forgot.dart/resetPassword.dart';

class EmailOtpVerifyScreen extends StatefulWidget {
  const EmailOtpVerifyScreen({super.key});

  @override
  State<EmailOtpVerifyScreen> createState() => _EmailOtpVerifyScreenState();
}

class _EmailOtpVerifyScreenState extends State<EmailOtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 50),
                //     child: Image.asset("assets/images/otplogo.png"),
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Verify Your Email',
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: greenish),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset("assets/images/Email.png"),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  // margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: EdgeInsets.all(4),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90, right: 90),
                    child: Text(
                      'Entered the 4 digit code received on your entered email.',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: greenish,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                OtpTextField(
                  margin: EdgeInsets.only(right: 14),
                  numberOfFields: 4,
                  fieldWidth: 50,
                  borderColor: Color(0xFF512DA8),
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    if (authController.otp.toString() == verificationCode) {
                      authController.verify = true.obs;
                      // Get.to(() => ResetPasswordScreen());
                    } else {
                      authController.verify = false.obs;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                // Center(
                //   child: Container(
                //     width: 70,
                //     height: 30,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[200],
                //       borderRadius: BorderRadius.circular(5.0),
                //     ),
                //     child: Text(
                //       '00:59',
                //       style: TextStyle(
                //         fontSize: 15.0,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     // Get.to(() => RegisterScreen());
                //   },
                //   child: Center(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text('Not received ? '),
                //         Text(
                //           'Resend',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             color: greenish,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: SizedBox(
                  height: Get.height * 0.08,
                  width: Get.width * 0.4,
                  child: LargeButton(
                    title: 'Submit',
                    buttonWidth: 0.85,
                    onPressed: () {
                      if (authController.verify.value == true) {
                        Get.snackbar('OTP verified successfully!',
                            'You have successfully completed the verification process.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: mainColor,
                            colorText: Colors.white);
                        Get.to(() => ResetPasswordScreen());
                      } else {
                        Get.snackbar('ERROR!',
                            "Entered Otp is incorrect. Please enter correct Otp to proceed Further.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    },
                    color: mainColor,
                    textcolor: Colors.white,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
