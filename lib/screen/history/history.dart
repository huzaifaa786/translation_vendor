import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
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
        builder: (controller) => Column(
          children: [
            TitleTopbar(
              text: 'History',
              ontap: () {
                Get.back();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  controller.orders.length != 0
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: ListView.builder(
                              itemCount: controller.orders.length,
                              itemBuilder: (context, index) => HistoryCard(
                                ontap: (){  Get.to(OrderStatus(order: controller.orders[index],));},
                                    id: controller.orders[index].id,
                                    name: controller.orders[index].vendor!.name,
                                    image: controller
                                        .orders[index].vendor!.profilepic,
                                    price: controller.orders[index].price,
                                    type: controller.orders[index].servicetype,
                                    status: controller.orders[index].status,
                                    time: controller.orders[index].starttime! + '-' + controller.orders[index].endtime!,
                                    date: controller.orders[index].date,
                                    servicetype: controller.orders[index].servicetype,
                                  )),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("No Order Found!"),
                            ],
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
