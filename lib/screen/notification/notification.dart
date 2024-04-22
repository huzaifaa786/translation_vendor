import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/screen/notification/noticontroller.dart';
import 'package:translation_vendor/screen/order_status/order_status.dart';
import 'package:translation_vendor/static/notification.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/values/colors.dart';
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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: greenish,
      //   title:
      // ),
      body: SafeArea(
          child: GetBuilder<NotificationController>(
        builder: (controller) => Column(
          children: [
            Container(
              height: Get.height * 0.1 / 0.8,
              color: greenish,
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 14),
                          decoration: BoxDecoration(
                            color: White,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            ),
                          ),
                          child: Icon(
                            size: 28,
                            Icons.keyboard_arrow_left_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          "Notifications",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                            color: White,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // TitleTopbar(
            //   text: 'Notifications',
            //   ontap: () {
            //     Get.back();
            //   },
            // ),
            SizedBox(
              height: 8,
            ),
            controller.notifications.length != 0
                ? Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: controller.notifications.length,
                          itemBuilder: (context, index) => NotificationTile(
                                ontap: () {
                                  controller.notifications[index].orderr != null
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
                                price: controller.notifications[index].orderr !=
                                        null
                                    ? controller
                                        .notifications[index].orderr!.price
                                        .toString()
                                    : '',
                                scheduletype:
                                    controller.notifications[index].orderr !=
                                            null
                                        ? controller
                                            .notifications[index].orderr!.servicetype == 'schedule'?
                                            controller
                                            .notifications[index].orderr!.scheduletype:controller
                                            .notifications[index].orderr!.document!.documenttype
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
                      // width: MediaQuery.of(context).size.width * 0.1 / 2,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
      )),
    );
  }
}
