// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class Scheduleinput extends StatelessWidget {
  const Scheduleinput(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.obscure = false,
      this.showSuffix = false,
      this.validator,
      this.autovalidateMode,
      this.validate,
      this.suffix,
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
  final type;
  final showSuffix;
  final suffix;
  final obscure;
  final text;
  final autovalidateMode;
  final maxlines;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.3,
            child: TextFormField(
              readOnly: true,
              onTap: onpressed,
              enabled: enabled,
              obscureText: obscure,
              controller: controller,
              style: TextStyle(fontSize: fontSize, color: mainColor),
              keyboardType: type,
              validator: validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: hint,
                contentPadding: const EdgeInsets.only(left: 12.0, right: 12,top: 12,bottom:16 ),
                hintStyle: TextStyle(color: hintColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey[500]!),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey[500]!),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              cursorColor: Colors.black,
              maxLines: maxlines == true ? null : 1,
            ),
          ),
        ],
      ),
    );
  }
}
