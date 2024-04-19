// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';

class PagePrice extends StatelessWidget {
  const PagePrice(
      {super.key,
      this.days,
      this.maxpage,
      this.minpage,
      this.number,
      this.discription,
      this.image,
      this.extra = false,
      this.services});
  final days;
  final String? number;
  final discription;
  final maxpage;
  final minpage;
  final image;
  final bool extra;
  final Widget? services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                minpage == null ? '' : minpage,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: mainColor),
              ),
              Text('-'),
              Text(
                maxpage == null ? '' : maxpage,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: mainColor),
              ),
              Text(
                '  Pages:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              // Text(
              //   'In ',
              //   style: TextStyle(
              //       fontFamily: 'Poppins',
              //       fontSize: 12,
              //       fontWeight: FontWeight.w400,
              //       color: Colors.black),
              // ),
              Text(
                days.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: mainColor),
              ),
              Text(
                '  days',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              )
            ],
          ),
        ],
      ),
    );
  }
}
