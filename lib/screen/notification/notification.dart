import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/screen/main/main.dart';
import 'package:translation_vendor/screen/notification/noticontroller.dart';
import 'package:translation_vendor/screen/order_status/order_status.dart';
import 'package:translation_vendor/static/notification.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  fetchOrder() async {
    await notificationController.getnoti();
    setState(() {});
  }

  readnotification() async {
    await notificationController.readnotifications();
    setState(() {});
  }

  @override
  void initState() {
    fetchOrder();
    readnotification();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GetBuilder<NotificationController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              TitleTopbar(
                text: 'Notifications',
                ontap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: 8,
              ),
              controller.notifications.length != 0
                  ? Flexible(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: ListView.builder(
                            itemCount: controller.notifications.length,
                            itemBuilder: (context, index) => NotificationTile(
                                  ontap: () {
                                    controller.notifications[index].orderr !=
                                            null
                                        ? Get.to(OrderStatus(
                                            order: controller
                                                .notifications[index].orderr,
                                          ))
                                        : null;
                                  },
                                  name: controller
                                      .notifications[index].user!.username,
                                  image: controller
                                      .notifications[index].user!.profilePic,
                                  title: controller.notifications[index].title,
                                  price:
                                      controller.notifications[index].orderr !=
                                              null
                                          ? controller.notifications[index]
                                              .orderr!.price
                                              .toString()
                                          : '',
                                  day: notificationController.convertDateFormat(
                                      controller
                                          .notifications[index].created_at!),
                                )),
                      ),
                    )
                  : Flexible(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/images/smiley.svg"),
                                  SizedBox(height: 20),
                                  Text(
                                    'No Notification Found',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      )),
    );
  }
}
