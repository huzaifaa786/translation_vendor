// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class AddPage extends StatelessWidget {
  const AddPage(
      {super.key,
      this.title,
      this.onPressed,
      this.discription,
      this.image,
      this.extra = false,
      this.services});
  final title;
  final onPressed;
  final discription;
  final image;
  final bool extra;
  final Widget? services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                fontFamily: 'Poppins',
                color: mainColor),
          ),
          InkWell(
              onTap: onPressed,
              child: SvgPicture.asset(
                'assets/images/add.svg',
                height: 14,
                width: 14,
              ))
        ],
      ),
    );
  }
}
