// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class PagePrice extends StatelessWidget {
  const PagePrice(
      {super.key,
      this.days,
      this.number,
      this.discription,
      this.image,
      this.extra = false,
      this.services});
  final days;
  final String? number;
  final discription;
  final image;
  final bool extra;
  final Widget? services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                number!,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: mainColor),
              ),
              Text(
                '  Pages.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'In ',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: Colors.black),
              ),
              Text(
                days.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: mainColor),
              ),
              Text(
                '  days',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.black),
              )
            ],
          ),
        ],
      ),
    );
  }
}
