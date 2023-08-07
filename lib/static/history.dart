// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/static/badge.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard(
      {super.key,
      this.image,
      this.page,
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
      this.onmsgtap});
  final type;
  final onmsgtap;
  final name;
  final image;
  final servicetype;
  final date;
  final time;
  final id;
  final day;
  final ontap;
  final price;
  final page;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Column(
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
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Mazzard'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              type,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Mazzard'),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          servicetype == 'document'
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    'Amount of pages: ' + page + ' pages',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Mazzard'),
                                  ),
                                )
                              : Container(),
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
                              servicetype != 'document'
                                  ? Text(
                                      time + " | ",
                                      style: TextStyle(fontSize: 11),
                                    )
                                  : Text(''),
                              Text(
                                date,
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                    Column(
                      children: [
                        InkWell(
                          onTap: onmsgtap,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, left: 12, right: 12),
                            child: SvgPicture.asset(
                              'assets/images/msg.svg',
                              height: 17,
                              width: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Divider(
                color: Colors.grey,
                height: 5,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
