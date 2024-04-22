// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';

class StarButton extends StatelessWidget {
  const StarButton(
      {Key? key,
      @required this.onPressed,
      this.textcolor,
      this.icon,
      this.image,
      this.buttonWidth = 0.8,
      this.screenRatio = 0.9,
      this.rounded = false,
      this.isFrozen = false,
      this.color = mainColor})
      : super(key: key);

  final onPressed;
  final screenRatio;
  final color;
  final image;
  final textcolor;
  final icon;
  final rounded;
  final isFrozen;
  final buttonWidth;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          // padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              color: Color.fromARGB(255, 246, 237, 237)),
          child: Image.asset(
            'assets/images/star.png',
            height: 45,
            width: 45,
          )),
    );
  }
}
