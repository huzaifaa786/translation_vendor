// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class Imageinput extends StatelessWidget {
  const Imageinput({
    Key? key,
    this.controller,
    this.labelText,
    this.text = '',
    this.maxlines = false,
    this.enabled = true,
    this.readOnly = false,
    this.rounded = false,
    this.onChange,
    this.imageIcon,
    this.simageIcon,
    this.hint,
    this.validator,
    this.autovalidateMode,
    this.validate,
    this.icon,
    this.height,
    this.type = TextInputType.text,
    this.optionalText = '',
    this.fontSize = 14.0,
    this.width = 0.98,
    this.onpressed,
  }) : super(key: key);

  final controller;
  final validator;
  final optionalText;
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
  final simageIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 10,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Image.asset(
                              imageIcon,
                              height: 17,
                              width: 17,
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(text.toString())),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Image.asset(
                              simageIcon,
                              height: 17,
                              width: 17,
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
                  child: Container(
                    margin: const EdgeInsets.only(left: 2, right: 4),
                    child: Row(
                      children: [
                        Text(
                          labelText + optionalText,
                          style: TextStyle(
                              backgroundColor: White,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
