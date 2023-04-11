// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class CheckOutTile extends StatelessWidget {
  const CheckOutTile(
      {super.key,
      this.title,
      this.discription,
      this.image,
      this.extra = false,
      this.services});
  final title;
  final discription;
  final image;
  final bool extra;
  final Widget? services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,top: 20),
      child: Row(
     
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  discription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: mainColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
