// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class LanguageAdd extends StatelessWidget {
  const LanguageAdd(
      {Key? key,
      this.controller,
      this.labelText,
      this.text,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.rounded = false,
      this.onChange,
      this.imageIcon,
      this.hint,
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
  final bool? validate;
  final labelText;
  final width;
  final hint;
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
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:4.0),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 10,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onpressed,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SvgPicture.asset(
                            imageIcon,
                            height: 29,
                            width: 29,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -2,
              left: 16,
              child: Text(
                labelText,
                style: TextStyle(
                              backgroundColor: White,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
