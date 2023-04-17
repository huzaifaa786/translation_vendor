// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/screen/notification/notification.dart';
import 'package:translation_vendor/screen/profile/profile.dart';

class Topbar extends StatelessWidget {
  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5,top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 32,
            width: 30,
            child: SvgPicture.asset('assets/images/logo.svg')),
          Row(
            children: [
              InkWell(
                onTap: (){ Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>NotificationScreen() ,
                    ));},
                child: SvgPicture.asset('assets/images/notifcation.svg'),
                
              ),
               InkWell(
                onTap:  (){ Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>Profile() ,
                    ));},
                 child: Padding(
                   padding: const EdgeInsets.only(left: 12),
                   child: Image(image: AssetImage('assets/images/noti.png')),
                 ),
               ),
            ],
          )
        ],
      ),
    );
  }
}
