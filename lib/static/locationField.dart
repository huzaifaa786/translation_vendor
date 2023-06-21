// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/values/colors.dart';

class LocationField extends StatelessWidget {
  const LocationField(
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
        TextFormField(
          maxLength: 6,
          controller: controller,
          validator: validator,
          onChanged: onChange,
          keyboardType: type,
          autovalidateMode: autovalidateMode ??
              (validate == true.obs
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 231, 229, 229),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
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
        ),
      ],
    );
  }
}
