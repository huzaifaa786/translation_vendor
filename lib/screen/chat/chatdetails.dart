import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' as io;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:translation_vendor/screen/chat/chatcontroller.dart';
import 'package:translation_vendor/static/chattopbar.dart';
import 'package:translation_vendor/static/rplycharcard.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class Chatdetails_screen extends StatefulWidget {
  const Chatdetails_screen(
      {super.key,
      required this.contactid,
      required this.contactname,
      required this.contactPic,
      required this.screen});
  final String? contactid;
  final String? contactname;
  final String? contactPic;
  final String? screen;

  @override
  State<Chatdetails_screen> createState() => _Chatdetails_screenState();
}

class _Chatdetails_screenState extends State<Chatdetails_screen> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  @override
  void initState() {
    chatController.massages = RxList([]);
    chatController.initPusher(widget.contactid!);
    chatController.fetchmassage(widget.contactid!);
    msg();
    super.initState();
  }

  msg() async {
    await chatController.makeseen(widget.contactid!);
    await chatController.unseenchat();
  }

  @override
  void dispose() {
    pusher.disconnect();
    pusher.unsubscribe(channelName: "private-chatify.${widget.contactid!}");
    super.dispose();
  }

  String getTime(DateTime? dateTime) {
    if (dateTime != null) {
      return TimeOfDay.fromDateTime(dateTime.toLocal()).format(context);
    } else {
      return '';
    }
  }

  Future<bool> checkFileExistance(int index) async {
    var fileExist = await io.File('/storage/emulated/0/Download/' +
            chatController.massages[chatController.massages.length - 1 - index]
                .file_title!)
        .exists();
    return fileExist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GetBuilder<ChatController>(
        builder: (controller) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 12),
          child: Column(
            children: [
              ChatTopBar(
                name: widget.contactname,
                image: widget.screen == 'order'
                    ? widget.contactPic
                    : 'https://translation.ezmoveportal.com/' +
                        widget.contactPic!,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   // child: Divider(
                    //   //   color: Colors.grey,
                    //   //   height: 1,
                    //   // ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   child: Text(
                    //     'Today',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Divider(
                    //     color: Colors.grey,
                    //     height: 1,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      reverse: true, // Set reverse to true
                      itemCount: controller.massages.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        bool fileExist = false;
                        checkFileExistance(index)
                            .then((value) => fileExist = value);
                        print(fileExist);
                        return ReplyMessageCard(
                          msg: controller
                              .massages[controller.massages.length - 1 - index]
                              .body
                              .toString(), // Reverse the index
                          Time: getTime(controller
                              .massages[controller.massages.length - 1 - index]
                              .dateTime), // Reverse the index
                          sender: controller
                                      .massages[controller.massages.length -
                                          1 -
                                          index]
                                      .to_id ==
                                  widget.contactid!
                              ? false
                              : true,
                          fileName: controller
                              .massages[controller.massages.length - 1 - index]
                              .file_name,
                          fileType: controller
                              .massages[controller.massages.length - 1 - index]
                              .file_type,
                          fileTitle: controller
                              .massages[controller.massages.length - 1 - index]
                              .file_title,
                          fileExist: fileExist,
                        );
                      })),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    // height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: greenish),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: TextField(
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          // Check if the value is not empty or only contains whitespace
                          chatController.sendMassage();
                        }
                        setState(() {});
                      },
                      controller: chatController.massagecontroller,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              controller.picksinglefile();
                            },
                            child: Icon(Icons.attach_file, color: greenish)),
                        hintText: 'You message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 8, top: 18),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromARGB(255, 51, 50, 50),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
