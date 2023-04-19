import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/screen/main/main.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/icon_inputfield.dart';
import 'package:translation_vendor/static/imageinput.dart';
import 'package:translation_vendor/static/inputfield.dart';
import 'package:translation_vendor/static/language_add.dart';
import 'package:translation_vendor/static/password_input.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:translation_vendor/static/stackinputfield.dart';
import 'package:translation_vendor/values/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int index = 1;

  getindex(id) async {
    setState(() {
      index = id;
    });
  }

  bool showCreate = false;
  bool show = false;
  XFile? image = XFile('');
  selectimage() async {
    print('dsff');
    final ImagePicker _picker = ImagePicker();
    var image1 = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = image1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
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
                              color: mainColor,
                              width: 1.0,
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
                            labelText: 'Vendor Name',
                            hint: '',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 4, bottom: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Date Of Birth',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          DropdownDatePicker(
                            inputDecoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                    borderRadius:
                                        BorderRadius.circular(10),)), // optional
                            isDropdownHideUnderline: true, // optional
                            isFormValidator: true, // optional
                            startYear: 1970, // optional
                            endYear: 2030, // optional
                            width: 10, // optional
                            // selectedDay: 14, // optional
                            // selectedMonth: 10, // optional
                            // selectedYear: 1993, // optional
                            onChangedDay: (value) =>
                                print('onChangedDay: $value'),
                            onChangedMonth: (value) =>
                                print('onChangedMonth: $value'),
                            onChangedYear: (value) =>
                                print('onChangedYear: $value'),
                            //boxDecoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey, width: 1.0)), // optional
                            // showDay: false,// optional
                            dayFlex: 2, // optional
                            // monthFlex: 3,
                            // yearFlex: 2,
                            // locale: "zh_CN",// optional
                            hintDay: 'Day', // optional
                            // hintMonth: 'Month', // optional
                            // hintYear: 'Year', // optional
                            // hintTextStyle: TextStyle(color: Colors.grey), // optional
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Imageinput(
                              labelText: ' Passport ',
                              imageIcon: 'assets/images/image.svg',
                              onpressed: () {
                                selectimage();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Imageinput(
                              labelText: ' Certificate (Optional) ',
                              imageIcon: 'assets/images/image.svg',
                              onpressed: () {
                                selectimage();
                              },
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: LanguageAdd(
                                labelText: ' Language',
                                imageIcon: 'assets/images/add.svg',
                                onpressed: () {
                                  print(showCreate);
                                  setState(() {
                                    showCreate = !showCreate;
                                    print(showCreate);
                                  });
                                },
                              )),
                          showCreate == true
                              ? InputFields(
                                  hint: 'Add language',
                                  showSuffix: true,
                                  suffix: 'ADD',
                                  onpressed: () {},
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
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
                            padding: const EdgeInsets.only(top: 12.0),
                            child: InputFieldPassword(
                              imageIcon: 'assets/images/password.svg',
                              hint: 'Confirm Password',
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 30),
                            child: LargeButton(
                              title: 'Submit',
                              textcolor: White,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainScreen(),
                                    ));
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
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 30),
                            child: LargeButton(
                              title: 'Login',
                              textcolor: White,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainScreen(),
                                    ));
                              },
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
