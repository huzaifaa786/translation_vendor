// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/values/colors.dart';

class InputFieldPasswordTwo extends StatelessWidget {
  const InputFieldPasswordTwo(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.icon,
      this.imageIcon,
      this.obscure = false,
      this.toggle,
      this.onChange,
      this.validator,
      this.validate,
      this.autovalidateMode,
      this.label,
      this.type = TextInputType.text,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final RxBool? validate;
  final autovalidateMode;
  final obscure;
  final hint;
  final type;
  final text;
  final icon;
  final imageIcon;
  final toggle;
  final onChange;
  final onpressed;
  final label;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            // label: label,
            fillColor: Colors.grey,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: greenish)),
            hoverColor: Colors.grey,
            focusColor: Colors.grey,
            labelText: label,
            hintText: hint,
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: greenish,
              ),
              onPressed: () {
                toggle();
              },
            ),
          ),
          keyboardType: type,
          cursorColor: Colors.black,
          obscureText: obscure,
          maxLines: 1,
          validator: validator,
          autovalidateMode: autovalidateMode ??
              (validator == true.obs
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction),
        ));
  }
}
