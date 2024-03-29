import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/screen/forgot.dart/forgotAccount.dart';
import 'package:translation_vendor/screen/login/authcontroller.dart';
import 'package:translation_vendor/screen/main/main.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/certificate.dart';
import 'package:translation_vendor/static/dropdown.dart';
import 'package:translation_vendor/static/icon_inputfield.dart';
import 'package:translation_vendor/static/imageinput.dart';
import 'package:translation_vendor/static/language_add.dart';
import 'package:translation_vendor/static/password_input.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:translation_vendor/static/stackinputfield.dart';
import 'package:translation_vendor/values/Validator.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:translation_vendor/values/language.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _obscureText1 = true;
  int index = 1;

  switchfromlang(value) {
    setState(() {
      authController.selectedLanguage = value as String;
      authController.storeLanguageList();
    });
  }

  getindex(id) async {
    setState(() {
      index = id;
    });
    authController.ClearSignupVariables();
    authController.validateSignUpForm = false.obs;
    authController.validateSignInForm = false.obs;
  }

  bool showCreate = false;
  bool show = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    int endYear = currentYear - 10;
    int startYear = currentYear - 80;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GetBuilder<AuthController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: 110,
                      )
                    ],
                  ),
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
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(300),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3))
                          ],
                        ),
                        child: ToggleSwitch(
                          initialLabelIndex: index,
                          labels: const [
                            'New',
                            'Existing',
                          ],
                          totalSwitches: 2,
                          onToggle: (index) {
                            getindex(index);
                          },
                          borderWidth: 1,
                          radiusStyle: true,
                          fontSize: 15,
                          minWidth: 110,
                          minHeight: MediaQuery.of(context).size.height * 0.06,
                          cornerRadius: 40,
                          inactiveFgColor: const Color.fromARGB(255, 9, 9, 9),
                          activeFgColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          inactiveBgColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          activeBgColor: const [mainColor],
                          activeBorders: [
                            Border.all(
                              color: White,
                              width: 3.5,
                            ),
                            Border.all(
                              color: White,
                              width: 3.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                index == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 13.0, bottom: 13),
                        child: Column(children: [
                          Stackinput(
                            controller: authController.vendorName,
                            labelText: 'Vendor Name',
                            hint: '',
                            validate: authController.validateSignUpForm,
                            validator: (field) =>
                                Validators.emptyStringValidator(
                                    field, '*Vendor name '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 4, bottom: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Date Of Birth',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          DropdownDatePicker(
                            inputDecoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 2, right: 2, top: 16, bottom: 16),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            isDropdownHideUnderline: true,
                            isFormValidator: true,
                            startYear: startYear,
                            endYear: endYear,
                            width: 10,
                            onChangedDay: (value) =>
                                authController.day = value!,
                            onChangedMonth: (value) =>
                                authController.month = value!,
                            onChangedYear: (value) =>
                                authController.year = value!,
                            dayFlex: 2,
                            textStyle: TextStyle(fontSize: 12),
                            hintTextStyle:
                                TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Imageinput(
                              labelText: ' Passport ',
                              imageIcon: 'assets/images/image.svg',
                              text: authController.passportImage!.name,
                              onpressed: () {
                                authController.selectPassportImage();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Imageinput(
                              labelText: ' CV ',
                              imageIcon: 'assets/images/image.svg',
                              text: authController.CVImage!.name,
                              onpressed: () {
                                authController.selectCVImage();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Certificateinput(
                              controller: authController.certificateName,
                              labelText: 'Certificate',
                              hint: 'Enter certificate name',
                              onpressed: () {
                                authController.selectCertificateImage();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'select atleast 2 languages',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: LanguageAdd(
                                labelText: ' Language',
                                text: authController.languege!.join(',  '),
                                validate: authController.validateSignUpForm,
                                validator: (language) =>
                                    Validators.languageValidator(language),
                                imageIcon: 'assets/images/add.svg',
                                onpressed: () {
                                  setState(() {
                                    showCreate = !showCreate;
                                    print(showCreate);
                                  });
                                },
                                ondeltap: () {
                                  if (authController.languege!.isNotEmpty) {
                                    authController.languege!.removeLast();
                                    setState(() {});
                                  }
                                },
                              )),
                          showCreate == true
                              ? DropdownField(
                                  items: Languages(),
                                  text: 'Add Language',
                                  selectedvalue:
                                      authController.selectedLanguage,
                                  icon: ImageIcon(AssetImage(
                                      'assets/images/drop_arrow.png')),
                                  onChange: switchfromlang)
                              //  InputFields(
                              //     hint: 'Add language',
                              //     controller: authController.languageController,
                              //     showSuffix: true,
                              //     suffix: 'ADD',
                              //     onpressed: () {
                              //       if (authController
                              //           .languageController.text.isNotEmpty) {
                              //         authController.storeLanguageList();
                              //       }
                              //     },
                              //   )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: IconInputFields(
                              imageIcon: 'assets/images/email.svg',
                              controller: authController.userName,
                              hint: 'Username',
                              width: 12,
                              borderColor: Colors.black,
                              imageColor: Colors.black,
                              validate: authController.validateSignUpForm,
                              validator: (field) =>
                                  Validators.emptyStringValidator(
                                      field, '*userame'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: IconInputFields(
                              imageIcon: 'assets/images/emailIcon.svg',
                              controller: authController.email,
                              hint: 'Email',
                              width: 12,
                              borderColor: Colors.black,
                              imageColor: Colors.black,
                              validate: authController.validateSignUpForm,
                              validator: (field) =>
                                  Validators.emailValidator(field),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: IconInputFields(
                              imageIcon: 'assets/images/email.svg',
                              controller: authController.phone,
                              hint: 'Phone',
                              width: 12,
                              borderColor: Colors.black,
                              imageColor: Colors.black,
                              validate: authController.validateSignUpForm,
                              validator: (field) =>
                                  Validators.emptyStringValidator(
                                      field, '*phone'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: InputFieldPassword(
                              controller: authController.password,
                              imageIcon: 'assets/images/password.svg',
                              hint: 'Password',
                              borderColor: Colors.black,
                              imageColor: Colors.black,
                              toggle: _toggle,
                              obscure: _obscureText,
                              validate: authController.validateSignUpForm,
                              validator: (password) =>
                                  Validators.passwordValidator(password),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: InputFieldPassword(
                              controller: authController.confirmPassword,
                              imageIcon: 'assets/images/password.svg',
                              hint: 'Confirm Password',
                              borderColor: Colors.black,
                              imageColor: Colors.black,
                              toggle: _toggle1,
                              obscure: _obscureText1,
                              validate: authController.validateSignUpForm,
                              validator: (password) =>
                                  Validators.passwordValidator(password),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 30),
                            child: LargeButton(
                              title: 'Submit',
                              textcolor: White,
                              onPressed: () {
                                setState(() {});
                                authController.SignUp((success) async {
                                  if (success) {
                                    // await
                                    vendorrequest(context);
                                  }
                                });
                              },
                            ),
                          ),
                        ]),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: IconInputFields(
                              imageIcon: 'assets/images/emailIcon.svg',
                              hint: 'Email',
                              controller: authController.email,
                              validate: authController.validateSignInForm,
                              validator: (field) =>
                                  Validators.emailValidator(field),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: InputFieldPassword(
                              imageIcon: 'assets/images/password.svg',
                              hint: 'Password',
                              toggle: _toggle,
                              obscure: _obscureText,
                              controller: authController.password,
                              // validate: authController.validateSignInForm,
                              // validator: (password) =>
                              //     Validators.passwordValidator(password),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => ForgotScreen());
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 30),
                            child: LargeButton(
                              title: 'Login',
                              textcolor: White,
                              onPressed: () {
                                setState(() {
                                  showCreate = false;
                                  print(showCreate);
                                });
                                authController.login((success) {
                                  if (success) {
                                    authController.ClearSignupVariables();
                                    Get.offAll(MainScreen());
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      )),
    );
  }

  vendorrequest(context) {
    Alert(
      style: AlertStyle(
        titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      context: context,
      image: SvgPicture.asset(
        'assets/images/tick.svg',
      ),
      title:
          "You have Successfully Submitted  your application and you will notified within 24 hours.",
      buttons: [
        DialogButton(
          color: mainColor,
          height: 60,
          radius: BorderRadius.all(
            Radius.circular(15),
          ),
          child: Text(
            "ok",
            style: TextStyle(color: White, fontSize: 25),
          ),
          onPressed: () => Get.back(),
        ),
      ],
    ).show();
  }
}
