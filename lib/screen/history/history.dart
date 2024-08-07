import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:translation_vendor/screen/chat/chatdetails.dart';
import 'package:translation_vendor/screen/history/historycontroller.dart';
import 'package:translation_vendor/screen/order_status/order_status.dart';
import 'package:translation_vendor/static/history.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  fetchOrder() async {
    await historyController.getOrder();
    setState(() {});
  }

  @override
  void initState() {
    fetchOrder();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: greenish,
      //   title: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 20),
      //       child: Text(
      //         "Order History",
      //         style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.w400,
      //             fontFamily: "Poppins",
      //             color: White),
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
          child: GetBuilder<HistoryController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
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
                            "Order History",
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
              //   text: 'History',
              //   ontap: () {
              //     Get.back();
              //   },
              // ),
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                height: Get.height * 0.85,
                // margin: EdgeInsets.only(top:90,left: 12,right: 12),
                child: controller.orders.isNotEmpty
                    ? ListView.builder(
                        // shrinkWrap: true,
                        // physics: BouncingScrollPhysics(),
                        itemCount: controller.orders.length,
                        itemBuilder: (context, index) {
                          String stimeStr = controller.orders[index].starttime!;
                          String etimeStr = controller.orders[index].endtime!;
                          DateTime stime = DateFormat('H:m:s').parse(stimeStr);
                          DateTime etime = DateFormat('H:m:s').parse(etimeStr);
                          String sformattedTime =
                              DateFormat('HH:mm').format(stime);
                          String eformattedTime =
                              DateFormat('HH:mm').format(etime);
                          print(controller.orders[index].servicetype);
                          return HistoryCard(
                            ontap: () {
                              Get.to(() => OrderStatus(
                                    order: controller.orders[index],
                                  ));
                            },
                            id: controller.orders[index].id,
                            page: controller.orders[index].servicetype ==
                                    'document'
                                ? controller.orders[index].document!.pages
                                : '',
                            name: controller.orders[index].user!.username,
                            image: controller.orders[index].user!.profilePic,
                            price: controller.orders[index].convertedPrice,
                            type: controller.orders[index].servicetype,
                            status: controller.orders[index].status,
                            
                            onmsgtap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Chatdetails_screen(
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
                                ? controller.orders[index].duration.toString() +
                                    ' min'
                                : controller.orders[index].servicetype! ==
                                        'document'
                                    ? sformattedTime
                                    : sformattedTime + '-' + eformattedTime,
                            date: controller.orders[index].date,
                            servicetype: controller.orders[index].servicetype,
                          );
                        })
                    : Container(
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
              ),
            ],
          ),
        ),
      )),
    );
  }
}
