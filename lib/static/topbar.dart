// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translation_vendor/screen/notification/notification.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key, this.image});
  final image;

  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  bool? checkNoti = false;

  checkNotifications() async {
    GetStorage box = GetStorage();
    String authCheck = box.read('api_token');
    if (authCheck.isNotEmpty) {
      var mcheckNotification = await mainController.CheckNotications();
      setState(() {
        checkNoti = mcheckNotification;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
              Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Get.to(() => NotificationScreen())!.then((value) {
                        checkNotifications();
                      });
                    },
                    child: SvgPicture.asset('assets/images/bell.svg'),
                  ),
                  checkNoti != false
                      ? Positioned(
                          right: 3,
                          top: 3,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
