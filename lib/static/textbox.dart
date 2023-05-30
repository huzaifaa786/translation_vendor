// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';

class TextBox extends StatelessWidget {
  const TextBox(
      {Key? key,
      @required this.title,
      this.textcolor,
      this.icon,
      this.screenRatio = 0.9,
      this.rounded = false,
      this.color})
      : super(key: key);

  final title;

  final screenRatio;
  final color;
  final textcolor;
  final icon;
  final rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      width: MediaQuery.of(context).size.width * 0.28,
      // height: 50,
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
        decoration: BoxDecoration(
            border: Border.all(
              color: hintColor,
            ),
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: null,
              style: TextStyle(
                color: textcolor,
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
