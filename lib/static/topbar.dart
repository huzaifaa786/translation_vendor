// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/screen/notification/notification.dart';
import 'package:translation_vendor/screen/profile/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Topbar extends StatelessWidget {
  const Topbar({super.key, this.image});
  final image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, top: 24),
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
                onTap: () {
                  Get.to(() => NotificationScreen());
                },
                child: SvgPicture.asset('assets/images/notifcation.svg'),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => Profile());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image == ''
                        ? Image(
                            image: AssetImage('assets/images/5907.jpg'),
                            height: 28,
                            width: 28,
                          )
                        : CachedNetworkImage(
                            imageUrl: image,
                            height: 28,
                            width: 28,
                          ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
