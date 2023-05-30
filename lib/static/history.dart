// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/static/badge.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    this.image,
    this.id,
    this.servicetype,
    this.day,
    this.type,
    this.ontap,
    this.date,
    this.time,
    this.name,
    this.price,
    this.status,
  });
  final type;
  final name;
  final image;
  final servicetype;
  final date;
  final time;
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
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: image == ''
                          ? Image(
                              image: AssetImage('assets/images/5907.jpg'),
                              height: 80,
                              width: 80,
                            )
                          : CachedNetworkImage(
                              imageUrl: image,
                              height: 80,
                              width: 80,
                            ),
                    ),
                  ],
                ),
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
                          time + " | ",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          date,
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
                      'AED ' + price.toString(),
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
                    SizedBox(height: 6),
                     servicetype == "documentType"
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 6, bottom: 6),
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
                        : Container(),
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
