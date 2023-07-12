import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/screen/chat/chatdetails.dart';
import 'package:translation_vendor/static/chart.dart';

import 'package:translation_vendor/values/controllers.dart';

class Chats_screen extends StatefulWidget {
  const Chats_screen({super.key});

  @override
  State<Chats_screen> createState() => _Chats_screenState();
}

class _Chats_screenState extends State<Chats_screen> {
  @override
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 141,
            decoration: BoxDecoration(
              color: Color(0xFF34607B),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(38, 68, 0, 0),
              child: Text(
                "Chats",
                style: TextStyle(
                  fontFamily: 'Mazzard',
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
              border: Border.all(
                color: Color.fromRGBO(0, 0, 0, 0.49),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search ",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatController.contacts.length,
              itemBuilder: (context, index) => ChartCards(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chatdetails_screen(
                              contacts: chatController.contacts[index]),
                        ));
                  },
                  msg: 'message',
                  name: chatController.contacts[index].username,
                  imgicon: "assets/images/splash_3.svg"),
            ),
          ),
        ],
      ),
    );
  }
}
