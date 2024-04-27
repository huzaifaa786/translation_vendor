// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/values/colors.dart';

class IconInputFields extends StatelessWidget {
  IconInputFields(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.rounded = false,
      this.borderColor = mainColor,
      this.imageColor = mainColor,
      this.onChange,
      this.imageIcon,
      this.validator,
      this.autovalidateMode,
      this.validate,
      this.icon,
      this.height,
      this.type = TextInputType.text,
      this.fontSize = 14.0,
      this.width = 0.98,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final RxBool? validate;
  final hint;
  final borderColor;
  final imageColor;
  final width;
  final height;
  final type;
  final imageIcon;
  final icon;
  final text;
  final autovalidateMode;
  final maxlines;
  final rounded;
  final onChange;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          // borderRadius: BorderRadius.all(
          //   Radius.circular(6),
          // ),
          ),
      child: TextFormField(
        style: const TextStyle(fontSize: 14),
        controller: controller,
        validator: validator,
        autovalidateMode: autovalidateMode ??
            (validate == true.obs
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: borderColor,
                  // ),
                  // // borderRadius: BorderRadius.all(
                  //   Radius.circular(30),
                  // ),
                  ),
              child: SvgPicture.asset(
                imageIcon,
                height: 17,
                width: 17,
                color: greenish,
              ),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(color: hintColor),
          contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: borderColor)),
        ),
        keyboardType: type,
        cursorColor: Colors.black,
        maxLines: 1,
      ),
    );
  }
}
