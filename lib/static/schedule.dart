// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
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
      this.fontSize = 8.0,
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
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onpressed,
            child: SizedBox(
              height: 36,
              width: MediaQuery.of(context).size.width * 0.23,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                readOnly: true,
                 onTap: onpressed,
                enabled: enabled,
                obscureText: obscure,
                controller: controller,
                style: TextStyle(fontSize: 12, color: White),
                keyboardType: type,
                validator: validator,
                decoration: InputDecoration(
                  suffixIconConstraints: BoxConstraints(
                      minHeight: 24, maxHeight: 25, minWidth: 24, maxWidth: 25),
                  suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                  suffixIconColor: White,
                  filled: true,
                  fillColor: greenish,
                  hintText: hint,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  // contentPadding: const EdgeInsets.only(
                  //     left: 17, right: 12, top: 12, bottom: 14),
                  hintStyle: TextStyle(color: hintColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: greenish),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: greenish),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                cursorColor: Colors.black,
                maxLines: maxlines == true ? null : 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
