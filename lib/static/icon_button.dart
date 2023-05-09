// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconsButton extends StatelessWidget {
  const IconsButton(
      {Key? key,
      @required this.title,
      @required this.onPressed,
      this.textcolor,
      this.icon,
      this.imgicon,
      this.iconTrue = true,
      this.screenRatio = 0.9,
      this.rounded = false,
      this.color = mainColor})
      : super(key: key);

  final title;
  final imgicon;
  final iconTrue;
  final onPressed;
  final screenRatio;
  final color;
  final textcolor;
  final icon;
  final rounded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * screenRatio,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: color,
            shadowColor: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: rounded == true
                  ? BorderRadius.all(Radius.circular(45))
                  : BorderRadius.all(Radius.circular(15)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    imgicon,
                    height: 27,
                    width: 27,
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: textcolor,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.black,
                  // ),
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
