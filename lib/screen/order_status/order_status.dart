// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/static/badge.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/statustitle.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            TitleTopbar(
              text: 'Client',
              ontap: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Order ID #534646454',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 19),
              child: Container(
                height: 360,
                padding: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckOutTile(
                          title: 'Name :',
                          discription: 'William Jone',
                        ),
                        Text(
                          '250 AED',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: mainColor),
                        )
                      ],
                    ),
                    CheckOutTile(
                      title: 'Type of Service :',
                      discription: 'In Persion',
                    ),
                    CheckOutTile(
                      title: 'Phone number:',
                      discription: '+53464565tr',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckOutTile(
                          title: 'Date:',
                          discription: '12/14/2022',
                        ),
                        CheckOutTile(
                          title: 'Time:',
                          discription: '6 :12 PM',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Text(
                    'Document',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: mainColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(45),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/page.svg',
                          color: Colors.black,
                          height: 12,
                          width: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          'File Document 2',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "View Document",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 19),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LargeButton(
                    title: 'Accept',
                    textcolor: White,
                    screenRatio: 0.4,
                    rounded: true,
                    onPressed: () {
                      completeorder(context);
                    },
                    // color: mainColor,
                  ),
                  LargeButton(
                    title: 'Reject',
                    textcolor: White,
                    screenRatio: 0.4,
                    rounded: true,
                    color: Colors.red,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  completeorder(context) {
    Alert(
      style: AlertStyle(titleStyle: TextStyle(fontSize: 27),),
      context: context,
      image: SvgPicture.asset('assets/images/tick.svg',),
      
      title: "Mark As Completed",
      buttons: [
        DialogButton(
            radius: BorderRadius.all(
                      Radius.circular(15),
                    ),
          height: 60,
          width: 60,
          child: Text(
            "yes",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.green,
        ),
        DialogButton(
          height: 60,
           radius: BorderRadius.all(
                      Radius.circular(15),
                    ),
          child: Text(
            "No",
            style: TextStyle(color: White, fontSize: 25),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red,
        ),
      ],
    ).show();
  }
}
