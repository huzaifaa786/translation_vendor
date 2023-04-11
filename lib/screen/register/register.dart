// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/static/imageinput.dart';
import 'package:translation_vendor/static/inputfield.dart';
import 'package:translation_vendor/static/stackinputfield.dart';
import 'package:translation_vendor/static/language_add.dart';
import 'package:translation_vendor/static/icon_inputfield.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/password_input.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:translation_vendor/values/colors.dart';

class RegesterScreen extends StatefulWidget {
  const RegesterScreen({super.key});

  @override
  State<RegesterScreen> createState() => _RegesterScreenState();
}

class _RegesterScreenState extends State<RegesterScreen> {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(children: [
            Stackinput(
              labelText: 'Vendor Name',
              hint: 'Enter your name',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Text(
                    'Date Of Birth',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: mainColor),
                  ),
                ],
              ),
            ),
            DropdownDatePicker(
              inputDecoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))), // optional
              isDropdownHideUnderline: true, // optional
              isFormValidator: true, // optional
              startYear: 1970, // optional
              endYear: 2030, // optional
              width: 10, // optional
              // selectedDay: 14, // optional
              // selectedMonth: 10, // optional
              // selectedYear: 1993, // optional
              onChangedDay: (value) => print('onChangedDay: $value'),
              onChangedMonth: (value) => print('onChangedMonth: $value'),
              onChangedYear: (value) => print('onChangedYear: $value'),
              //boxDecoration: BoxDecoration(
              // border: Border.all(color: Colors.grey, width: 1.0)), // optional
              // showDay: false,// optional
              // dayFlex: 2,// optional
              // locale: "zh_CN",// optional
              // hintDay: 'Day', // optional
              // hintMonth: 'Month', // optional
              // hintYear: 'Year', // optional
              // hintTextStyle: TextStyle(color: Colors.grey), // optional
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Imageinput(
                labelText: 'Passport',
                imageIcon: 'assets/images/image.svg',
                onpressed: () {
                  selectimage();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Imageinput(
                labelText: 'Certificate',
                imageIcon: 'assets/images/image.svg',
                onpressed: () {
                  selectimage();
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: LanguageAdd(
                  labelText: 'Certificate',
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
                    onpressed: (){},
                  )
                : Container(),


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
                  padding: const EdgeInsets.only(top: 12.0),
                  child: InputFieldPassword(
                    imageIcon: 'assets/images/password.svg',
                    hint: 'Confirm Password',
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 30),
                  child: LargeButton(
                    title: 'Submit',
                    textcolor: White,
                    onPressed: () {},
                  ),
                ),
          ]),
        ),
      ),
    );
  }
}
