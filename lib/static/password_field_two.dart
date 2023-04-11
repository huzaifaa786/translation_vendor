// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
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
      this.type = TextInputType.text,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final bool? validate;
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

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.grey,
            border: OutlineInputBorder(),
            hoverColor: Colors.grey,
            focusColor: Colors.grey,
            labelText: hint,
            hintText: hint,
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.black,
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
        ));
  }
}
