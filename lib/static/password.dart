// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword(
      {super.key,
      this.title,
      this.ontap,
      this.onPressed,
      this.discription,
      this.image,
      this.extra = false,
      this.services});
  final title;
  final ontap;
  final onPressed;
  final discription;
  final image;
  final bool extra;
  final Widget? services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top: 25,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 19, color:Colors.black),
          ),
       GestureDetector(
              onTap: onPressed,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                 border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                ),
                child: Icon(
                  
                  Icons.keyboard_arrow_right_outlined,
                  
                ),
              ),
            ),
        ],
      ),
    );
  }
}
