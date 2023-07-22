// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/models/order.dart';
import 'package:translation_vendor/screen/history/historycontroller.dart';
import 'package:translation_vendor/screen/order_status/statuscontroller.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/statustitle.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:intl/intl.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key, this.order});
  final Order? order;
  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  int status = 0;
  String? sformattedTime;
  String? eformattedTime; 
  String? docformattedTime; 
  @override
  void initState() {
    String stimeStr = widget.order!.starttime!;
    String etimeStr = widget.order!.endtime!;
    // String documenttime= widget.order!.created_at!;
    DateTime stime = DateFormat('H:m:s').parse(stimeStr);
    DateTime etime = DateFormat('H:m:s').parse(etimeStr);
    sformattedTime = DateFormat('HH:mm').format(stime);
    eformattedTime = DateFormat('HH:mm').format(etime);
    docformattedTime = DateFormat('HH:mm').format(widget.order!.created_at!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<HistoryController>(
        builder: (controller) => GetBuilder<StatusController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleTopbar(
                    text: 'Order Details',
                    ontap: () {
                      Get.back();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Order ID ' + widget.order!.id!.toString(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 19),
                    child: Container(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, bottom: 20),
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CheckOutTile(
                                title: 'Name :',
                                discription: '' + widget.order!.user!.username!,
                              ),
                              Text(
                                widget.order!.price!.toString() + ' AED',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: mainColor),
                              )
                            ],
                          ),
                          CheckOutTile(
                            title: 'Type of Service :',
                            discription: widget.order!.servicetype ==
                                        'instant' ? 'Instant video / audio meeting':widget.order!.servicetype ==
                                        'document' ? 'Documents translation': widget.order!.scheduletype == 'audio/video' ? 'Audio/Video': 'In person meeting' ,
                          ),
                          // CheckOutTile(
                          //   title: 'Phone number:',
                          //   discription: widget.order!.user!.number == null
                          //       ? ''
                          //       :' widget.order!.user!.number',
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: CheckOutTile(
                                  title: 'Date:',
                                  discription: widget.order!.date,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: CheckOutTile(
                                  title: 'Time:',
                                  discription:
                                 widget.order!.servicetype! ==
                                        'instant'
                                    ? widget.order!.duration.toString() + ' min'
                                    : widget.order!.servicetype == 'document'
                                          ? docformattedTime
                                          : sformattedTime! +
                                              ' - ' +
                                              eformattedTime!,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  widget.order!.servicetype! == "document"
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                children: [
                                  Text(
                                    'Document',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: mainColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(45),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/images/page.svg',
                                          color: mainColor,
                                          height: 12,
                                          width: 12,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Document',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      FileDownloader.downloadFile(
                                        url: widget.order!.document!.file!,
                                        name: 'File',
                                        onProgress: (fileName, progress) {
                                          Get.snackbar(
                                              'Downloading ' + fileName!,
                                              'Downloaded ' +
                                                  progress.toString() +
                                                  '%',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white);
                                        },
                                        onDownloadCompleted: (path) async {
                                          Get.snackbar(
                                              'File downloaded successfully.',
                                              '',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white);
                                        },
                                        onDownloadError: (errorMessage) {
                                          Get.snackbar('Error!', errorMessage,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white);
                                        },
                                      );
                                    },
                                    child: Text(
                                      "Download Document",
                                      style: TextStyle(
                                          color: mainColor,
                                          decoration: TextDecoration.underline,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            widget.order!.status! == "0"
                                ? Container()
                                : widget.order!.status! == "2"
                                    ? Container()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Message',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                                Text(widget.order!.document!
                                                    .discription!),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                          ],
                        )
                      : Container(),
                  widget.order!.status! == "0"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LargeButton(
                                title: 'Accept',
                                textcolor: White,
                                screenRatio: 0.4,
                                rounded: true,
                                onPressed: () {
                                  statusController.orderaccept(widget.order!);
                                },
                              ),
                              LargeButton(
                                onPressed: () {
                                  statusController.orderreject(widget.order!);
                                },
                                title: 'Reject',
                                textcolor: White,
                                screenRatio: 0.4,
                                rounded: true,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        )
                      : widget.order!.status! == "1"
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, bottom: 20),
                                  child: Text(
                                    'Order In Progress',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                                LargeButton(
                                    title: "Mark as Completed",
                                    textcolor: White,
                                    onPressed: () {
                                      completeorder(context, widget.order);
                                    })
                              ],
                            )
                          : widget.order!.status! == "2"
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 60),
                                  child: Text('Rejected',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins')),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 60),
                                  child: Text(
                                    'Completed',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins'),
                                  ),
                                )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  completeorder(context, Order) {
    Alert(
      style: AlertStyle(
        titleStyle: TextStyle(fontSize: 27),
      ),
      context: context,
      image: SvgPicture.asset(
        'assets/images/tick.svg',
      ),
      title: "Mark As Completed",
      buttons: [
        DialogButton(
          radius: BorderRadius.all(
            Radius.circular(15),
          ),
          height: 60,
          width: 60,
          child: Text(
            "yes",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          onPressed: () {
            setState(() {
              status = 3;
            });
            statusController.ordercomplete(widget.order!);
            Get.back();
          },
          color: Colors.green,
        ),
        DialogButton(
          height: 60,
          radius: BorderRadius.all(
            Radius.circular(15),
          ),
          child: Text(
            "No",
            style: TextStyle(color: White, fontSize: 25),
          ),
          onPressed: () => Get.back(),
          color: Colors.red,
        ),
      ],
    ).show();
  }
}
