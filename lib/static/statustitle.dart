// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class CheckOutTile extends StatelessWidget {
  const CheckOutTile(
      {super.key,
      this.title,
      this.discription,
      this.scheduletype,
      this.extra = false,
      this.services});
  final title;
  final discription;
  final scheduletype;
  final bool extra;
  final Widget? services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: discription != ''
          ? Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        discription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: mainColor),
                      ),
                    )
                  ],
                ),
              ],
            )
          : Container(),
    );
  }
}
