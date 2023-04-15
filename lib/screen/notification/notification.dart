import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:translation_vendor/static/notification.dart';
import 'package:translation_vendor/static/titletopbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: Column(
                  children: [
            TitleTopbar(
              text: 'Notifications',
              ontap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 23,),
            Container(
              padding: const EdgeInsets.only(left: 1, right: 1,top: 12),
              height: 100,
              child: NotificationTile(
                   title: 'your order recevied form',
                  name: 'Fira Jonce',
                      ontap: () {
                      
                      },
                    )
                  
            ),
              Container(
              padding: const EdgeInsets.only(left: 1, right: 1,top: 12),
              height: 100,
              child: NotificationTile(
                   title: 'your order recevied form',
                  name: 'Fira Jonce',
                      ontap: () {
                      
                      },
                    )
                  
            ),
              Container(
              padding: const EdgeInsets.only(left: 1, right: 1,top: 12),
              height: 100,
              child: NotificationTile(
                   title: 'your order recevied form',
                  name: 'Fira Jonce',
                      ontap: () {
                      
                      },
                    )
                  
            ),
              Container(
              padding: const EdgeInsets.only(left: 1, right: 1,top: 12),
              height: 100,
              child: NotificationTile(
                   title: 'your order recevied form',
                  name: 'Fira Jonce',
                      ontap: () {
                      
                      },
                    )
                  
            ),
                  ],
                ),
          )),
    );
  }
}