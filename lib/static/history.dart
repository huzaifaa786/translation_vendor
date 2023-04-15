// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/static/badge.dart';
import 'package:translation_vendor/values/colors.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    this.image,
    this.title,
    this.day,
    this.type,
    this.onPressed,
    this.name,
  });
  final type;
  final name;
  final image;
  final title;
  final day;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      child:
                          Image(image: AssetImage('assets/images/history.png')),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                      maxLines: 2,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'),
                      maxLines: 2,
                    ),
                    Text(
                      type,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'),
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 14,
                        ),
                        Text(
                          "08:00-16:00 | 03.12.2022 ",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'AED  50',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    ),
                    Badgee(
                      title: 'inprocess',
                      color: mainColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6,bottom: 6),
                      child: Text(
                        "View Document",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 9),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/msg.svg',
                      height: 17,
                      width: 17,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Divider(
                color: Colors.grey, //color of divider
                height: 5, //height spacing of divider
                thickness: 1, //thickness of divier line
                indent: 25, //spacing at the start of divider
                endIndent: 25, //spacing at the end of divider
              ),
            ),
          ],
        ),
      ),
    );
  }
}
