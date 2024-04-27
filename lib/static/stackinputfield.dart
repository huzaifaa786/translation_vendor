// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/values/colors.dart';

class Stackinput extends StatelessWidget {
  const Stackinput(
      {Key? key,
      this.controller,
      this.text,
      this.labelText,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.obscure = false,
      this.onChange,
      this.validator,
      this.autovalidateMode,
      this.validate,
      this.color,
      this.icon,
      this.hint,
      this.type = TextInputType.text,
      this.fontSize = 14.0,
      this.width = 0.98,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final RxBool? validate;
  final hint;
  final width;
  final labelText;
  final type;
  final color;
  final icon;
  final obscure;
  final text;
  final autovalidateMode;
  final maxlines;
  final onChange;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 30),
            child: TextFormField(
              controller: controller,
              validator: validator,
              autovalidateMode: autovalidateMode ??
                  (validate == true.obs
                      ? AutovalidateMode.always
                      : AutovalidateMode.onUserInteraction),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset(
                    icon,
                    width: 40,
                    height: 40,
                  ),
                ),
                fillColor: Colors.grey,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                hoverColor: Colors.grey,
                focusColor: Colors.grey,
                labelText: labelText,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black),
                hintText: hint,
              ),
            )),
      ],
    );
  }
}
