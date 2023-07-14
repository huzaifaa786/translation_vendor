import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:translation_vendor/screen/chat/chatdetails.dart';
import 'package:translation_vendor/screen/history/historycontroller.dart';
import 'package:translation_vendor/screen/order_status/order_status.dart';
import 'package:translation_vendor/static/history.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/values/controllers.dart';

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
                                type: controller.orders[index].servicetype,
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
                                time: sformattedTime+
                                            controller
                                                .orders[index].servicetype! ==
                                        'document'
                                    ? Text('')
                                    : '-' +
                                                controller.orders[index]
                                                    .servicetype! ==
                                            'document'
                                        ? Text('')
                                        : eformattedTime,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("No Order Found!"),
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
