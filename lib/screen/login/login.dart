import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/icon_inputfield.dart';
import 'package:translation_vendor/static/password_input.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:translation_vendor/values/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/logo.svg',
                            height: 110,
                            width: 110,
                          )
                        ],
                      ),
                    ),
                    // Positioned(
                    //   bottom: 10,
                    //   left: 55,
                    //   child: Text(
                    //     "Sign in to continue",
                    //     style: TextStyle(
                    //       fontSize: 26,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Vendor',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 0.001,
                              blurRadius: 4,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ToggleSwitch(
                          cornerRadius: 30,
                          inactiveBgColor: Colors.white,
                          borderWidth: 9,
                          radiusStyle: true,
                          fontSize: 15,
                          minWidth: 130,
                          minHeight: 40,
                          changeOnTap: true,
                          activeBgColor: [mainColor],
                          activeBorders: [
                            Border.all(
                              color: mainColor,
                              width: 3.0,
                            ),
                            Border.all(
                              color: mainColor,
                              width: 3.0,
                            ),
                          ],
                          initialLabelIndex: 0,
                          totalSwitches: 2,
                          labels: ['New', 'Existing'],
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: IconInputFields(
                    imageIcon: 'assets/images/email.svg',
                    hint: 'Username',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: InputFieldPassword(
                    imageIcon: 'assets/images/password.svg',
                    hint: 'Password',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 30),
                  child: LargeButton(
                    title: 'Login',
                    textcolor: White,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
