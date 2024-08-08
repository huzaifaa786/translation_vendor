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
  /////////////////
  @override
  @override
  void initState() {
    super.initState();
    fetchCountry();
  }

  void fetchCountry() async {
    authController.country = await authController.fetchCountryFromIP();
    print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
    print(authController.country);
  }

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
        builder: (controller) => SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: Get.height * 0.5 / 2,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: greenishgradient,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: 110,
                          color: White,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 250, 250),
                        borderRadius: BorderRadius.only(
                            // topRight: Radius.circular(30),
                            // topLeft: Radius.circular(30),
                            )),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            child: Text(
                              'WELCOME',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: greenish),
                            ),
                          ),
                        ),
                      ],
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
                              'Existing',
                              'New',
                            ],
                            totalSwitches: 2,
                            onToggle: (index) {
                              getindex(index);
                            },
                            borderWidth: 1,
                            radiusStyle: true,
                            fontSize: 15,
                            minWidth: 110,
                            minHeight:
                                MediaQuery.of(context).size.height * 0.06,
                            cornerRadius: 40,
                            inactiveFgColor: const Color.fromARGB(255, 9, 9, 9),
                            activeFgColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            inactiveBgColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            activeBgColor: const [greenish],
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
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: IconInputFields(
                                  imageIcon: 'assets/images/Letter.png',
                                  hint: 'Email Address',
                                  controller: authController.email,
                                  validate: authController.validateSignInForm,
                                  validator: (field) =>
                                      Validators.emailValidator(field),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: InputFieldPassword(
                                  imageIcon: 'assets/images/Lock.png',
                                  hint: 'Password',
                                  toggle: _toggle,
                                  obscure: _obscureText,
                                  controller: authController.password,
                                  validate: authController.validateSignInForm,
                                  validator: (password) =>
                                      Validators.passwordValidator(password),
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
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: greenish,
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            color: greenish,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, bottom: 30),
                                child: SizedBox(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.9,
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
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 13.0, bottom: 13, left: 20, right: 20),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/Male User (1).png",
                            ),
                            Text(
                              "Add Photo",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF7A8495),
                              ),
                            ),
                            Stackinput(
                              icon: "assets/images/Male User (1).png",
                              controller: authController.vendorName,
                              labelText: 'Name',
                              hint: '',
                              validate: authController.validateSignUpForm,
                              validator: (field) =>
                                  Validators.emptyStringValidator(
                                      field, '* Name '),
                            ),
                            Stackinput(
                              icon: "assets/images/Male User (1).png",
                              controller: authController.bioController,
                              labelText: 'Bio',
                              hint: '',
                              // validate: authController.validateSignUpForm,
                              // validator: (field) =>
                              //     Validators.emptyStringValidator(
                              //         field, '* Name '),
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
                                // label: Text(
                                //   'Date Of Birth',
                                //   style: TextStyle(
                                //       fontFamily: 'Montserrat',
                                //       fontWeight: FontWeight.w600,
                                //       fontSize: 13,
                                //       color: Colors.black),
                                // ),

                                contentPadding: EdgeInsets.only(
                                    left: 2, right: 2, top: 16, bottom: 16),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // labelText: "Date Of Birth",
                                // labelStyle: TextStyle(
                                //     fontFamily: 'Montserrat',
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 13,
                                //     color: Colors.black),
                              ),
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
                                imageIcon: 'assets/images/Passport.png',
                                simageIcon: 'assets/images/Upload.png',
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
                                imageIcon: 'assets/images/CV.png',
                                simageIcon: 'assets/images/Upload.png',
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
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: Text(
                            //     'select atleast 2 languages',
                            //     style: TextStyle(color: Colors.red),
                            //   ),
                            // ),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: LanguageAdd(
                                  svgimage: "assets/images/Globe.png",
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
                              padding: const EdgeInsets.only(top: 14),
                              child: Text(
                                'select atleast 2 languages',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 17.0,
                              ),
                              child: IconInputFields(
                                imageIcon: 'assets/images/Male User.png',
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
                                imageIcon: 'assets/images/Letter.png',
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
                                imageIcon: 'assets/images/Phone.png',
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
                                imageIcon: 'assets/images/Lock.png',
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
                                imageIcon: 'assets/images/Lock.png',
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
                                  const EdgeInsets.only(top: 26.0, bottom: 33),
                              child: SizedBox(
                                height: 60,
                                width: Get.width * 0.9,
                                child: LargeButton(
                                  rounded: 60,
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
                            ),
                          ]),
                        )
                ],
              ),
            ],
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
      title: "Your Form Has Been Submitted Successfully And Is Under Review",
      content: Column(
        children: [Image.asset("assets/images/Ok.png")],
      ),
      buttons: [
        DialogButton(
          color: mainColor,
          height: 60,
          radius: BorderRadius.all(
            Radius.circular(30),
          ),
          child: Text(
            "Done",
            style: TextStyle(color: White, fontSize: 25),
          ),
          onPressed: () => Get.back(),
        ),
      ],
    ).show();
  }
}
