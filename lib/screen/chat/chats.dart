import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:translation_vendor/screen/chat/chatdetails.dart';
import 'package:translation_vendor/static/chart.dart';
import 'package:translation_vendor/values/colors.dart';

import 'package:translation_vendor/values/controllers.dart';

class Chats_screen extends StatefulWidget {
  const Chats_screen({super.key});

  @override
  State<Chats_screen> createState() => _Chats_screenState();
}

class _Chats_screenState extends State<Chats_screen> {
  getContact() async {
    await chatController.getContacts();
    setState(() {});
  }

  @override
  void initState() {
    getContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatController.scontacts.length != 0
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 115,
                  decoration: BoxDecoration(
                    color: greenish,
                    // borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Messages",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(31, 20, 28, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(
                    //   color: Color.fromRGBO(0, 0, 0, 0.49),
                    //   width: 1,
                    // ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: greenish)),
                        child: TextField(
                          onChanged: chatController.searchContact,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search ",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          style: TextStyle(
                            fontFamily: 'Sk-Modernist',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38.0),
                  child: Row(
                    children: [
                      Text(
                        "Messages",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: chatController.scontacts.length,
                      itemBuilder: (context, index) {
                        // DateTime currentTime = DateTime.now();
                        // String specificTimeString =
                        //     chatController.scontacts[index].lastmessageTime!;
                        // DateTime specificTime =
                        //     DateFormat('yyyy-MM-dd HH:mm:ss')
                        //         .parse(specificTimeString);
                        // Duration difference =
                        //     currentTime.difference(specificTime);
                        // String date =
                        //     DateFormat('yyyy-MM-dd').format(specificTime);
                        return ChartCards(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Chatdetails_screen(
                                      contactid:
                                          chatController.scontacts[index].id,
                                      contactname: chatController
                                          .scontacts[index].username,
                                      contactPic: chatController
                                          .scontacts[index].profilePic,
                                      screen: 'chat',
                                    ),
                                  ));
                            },
                            // duration: difference.inSeconds < 60
                            //     ? difference.inSeconds.toString() + ' sec ago'
                            //     : difference.inMinutes < 60
                            //         ? difference.inMinutes.toString() +
                            //             ' min ago'
                            //         : difference.inHours < 24
                            //             ? difference.inHours.toString() +
                            //                 ' hour ago'
                            //             : difference.inDays < 8
                            //                 ? difference.inDays.toString() +
                            //                     ' day ago'
                            //                 : date,
                            msg: 'Tap here to view messages',
                            name: chatController.scontacts[index].username,
                            imgicon:
                                chatController.scontacts[index].profilePic);
                      }),
                ),
              ],
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage('chat 1.png')),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "No Chat Found",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
