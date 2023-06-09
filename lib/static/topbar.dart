// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translation_vendor/screen/notification/notification.dart';
import 'package:translation_vendor/screen/profile/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key, this.image, this.checkNewNoti = false});
  final image;
  final checkNewNoti;

  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  bool? checkNoti = false;

  checkNotifications() async {
    GetStorage box = GetStorage();

    String authCheck = box.read('api_token');
    print(authCheck);
    if (authCheck != null) {
      var mcheckNotification = await mainController.CheckNotications();
      setState(() {
        checkNoti = mcheckNotification;
        print(checkNoti);
      });
    } else {}
  }

  refreshData() {
    checkNotifications();
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('object');
      checkNotifications();
    });
  }

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
              new Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Get.to(() => NotificationScreen());
                    },
                    child: SvgPicture.asset('assets/images/bell.svg'),
                  ),
                  widget.checkNewNoti != false
                      ? new Positioned(
                          right: 1,
                          top: 1,
                          child: new Container(
                            padding: EdgeInsets.all(5),
                            decoration: new BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      : new Container()
                ],
              ),
              // InkWell(
              //   onTap: () {
              //     Get.to(() => Profile());
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 12),
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(20),
              //       child: image == ''
              //           ? Image(
              //               image: AssetImage('assets/images/5907.jpg'),
              //               height: 28,
              //               width: 28,
              //             )
              //           : CachedNetworkImage(
              //               imageUrl: image,
              //               height: 28,
              //               width: 28,
              //             ),
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
