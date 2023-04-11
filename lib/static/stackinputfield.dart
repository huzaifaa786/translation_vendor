// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, sort_child_properties_last

import 'package:flutter/material.dart';
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
  final bool? validate;
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
          child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.grey,
            border: OutlineInputBorder(),
            hoverColor: Colors.grey,
            focusColor: Colors.grey,
            labelText: labelText,
            hintText: hint,
          ),
        )
         
        ),
     
      ],
    );
  }
}
