import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:translation_vendor/screen/chat/chatdetails.dart';
import 'package:translation_vendor/screen/history/historycontroller.dart';
import 'package:translation_vendor/screen/order_status/order_status.dart';
import 'package:translation_vendor/static/history.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  fetchOrder() async {
    await historyController.getorder();
    setState(() {});
  }

  @override
  void initState() {
    fetchOrder();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<HistoryController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              TitleTopbar(
                text: 'History',
                ontap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: 23,
              ),
              controller.orders.length != 0
                  ? Flexible(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: ListView.builder(
                            itemCount: controller.orders.length,
                            itemBuilder: (context, index) {
                              String stimeStr =
                                  controller.orders[index].starttime!;
                              String etimeStr =
                                  controller.orders[index].endtime!;
                              DateTime stime =
                                  DateFormat('H:m:s').parse(stimeStr);
                              DateTime etime =
                                  DateFormat('H:m:s').parse(etimeStr);
                              String sformattedTime =
                                  DateFormat('HH:mm').format(stime);
                              String eformattedTime =
                                  DateFormat('HH:mm').format(etime);
                              print(controller.orders[index].servicetype);
                              return HistoryCard(
                                ontap: () {
                                  Get.to(OrderStatus(
                                    order: controller.orders[index],
                                  ));
                                },
                                id: controller.orders[index].id,
                                name: controller.orders[index].user!.username,
                                image:
                                    controller.orders[index].user!.profilePic,
                                price: controller.orders[index].price,
                                type: controller.orders[index].servicetype ==
                                        'instant'
                                    ? 'Instant video / audio meeting'
                                    : controller.orders[index].servicetype ==
                                            'document'
                                        ? 'Documents translation'
                                        : controller.orders[index]
                                                    .scheduletype ==
                                                'audio/video'
                                            ? 'Audio/Video'
                                            : 'In person meeting',
                                status: controller.orders[index].status,
                                onmsgtap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Chatdetails_screen(
                                          contactid: controller
                                              .orders[index].user!.id
                                              .toString(),
                                          contactname: controller
                                              .orders[index].user!.username,
                                          contactPic: controller
                                              .orders[index].user!.profilePic,
                                          screen: 'order',
                                        ),
                                      ));
                                },
                                time: controller.orders[index].servicetype! ==
                                        'instant'
                                    ? controller.orders[index].duration
                                            .toString() +
                                        ' min'
                                    : controller.orders[index].servicetype! ==
                                            'document'
                                        ? sformattedTime
                                        : sformattedTime + '-' + eformattedTime,
                                date: controller.orders[index].date,
                                servicetype:
                                    controller.orders[index].servicetype,
                              );
                            }),
                      ),
                    )
                  : Flexible(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.85,
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
                                    'No Order history Found',
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
