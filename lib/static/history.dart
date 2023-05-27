// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/static/badge.dart';
import 'package:translation_vendor/values/colors.dart';


class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    this.image,
    this.id,
    this.day,
    this.type,
    this.ontap,
    this.name,
    this.price,
    this.status,
  });
  final type;
  final name;
  final image;
  final id;
  final day;
  final ontap;
  final price;
  final status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Column(
                //   children: [
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(45),
                //       child: image == ''
                //           ? Image(
                //               image: AssetImage('assets/images/5907.jpg'),
                //               height: 80,
                //               width: 80,
                //             )
                //           : CachedNetworkImage(
                //               imageUrl: image,
                //               height: 80,
                //               width: 80,
                //             ),
                //     ),
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order id # ' + id.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Mazzard'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Mazzard'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      type,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Mazzard'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 14,
                        ),
                        SizedBox(
                          width: 4,
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
                     'AED '+price,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Mazzard'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Badgee(
                      title: status == "3"
                          ? 'Completed'
                          : status == "2"
                              ? "Rejected"
                              : "In progress",
                      color: status == "3"
                          ? Colors.green
                          : status == "2"
                              ? Colors.red
                              : mainColor,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
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
