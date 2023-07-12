import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:translation_vendor/screen/chat/chats.dart';
import 'package:translation_vendor/screen/history/history.dart';
import 'package:translation_vendor/screen/main/maincontroller.dart';
import 'package:translation_vendor/screen/profile/profile.dart';
import 'package:translation_vendor/screen/sale/sales.dart';
import 'package:translation_vendor/screen/services/service.dart';
import 'package:translation_vendor/static/icon_button.dart';
import 'package:translation_vendor/static/topbar.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 1;
  getindex(id) async {
    setState(() {
      index = id;
    });
  }
 

  String? greeting = '';
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var hour = DateTime.now().hour;
      setState(() {
        if ((hour >= 5) && (hour < 12)) {
          greeting = 'Good Morning';
        } else if ((hour >= 12) && (hour <= 16)) {
          greeting = 'Good Afternoon';
        } else if ((hour > 16) && (hour < 20)) {
          greeting = 'Good Evening';
        } else {
          greeting = 'Good Night';
        }
      });
      print(greeting);
      mainController.getVendor();
    });
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<MainController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Topbar(),
              greeting != ''
                  ? mainController.vendor != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Text(
                                'Hello' +
                                    ', \n' +
                                    mainController.vendor!.name!,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: mainColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Text(
                                greeting! + ', \n',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: mainColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: IconsButton(
                  title: 'Profile',
                  onPressed: () {
                    profileController.clearVariables();
                    Get.to(() => Profile());
                  },
                  imgicon: 'assets/images/person.svg',
                ),
              ),
              IconsButton(
                title: 'Services',
                onPressed: () {
                  serviceController.clearServiceScreen();
                  Get.to(() => ServiceScreen());
                },
                imgicon: 'assets/images/headphone.svg',
              ),
              IconsButton(
                title: 'Order History',
                onPressed: () {
                  Get.to(() => HistoryScreen());
                },
                imgicon: 'assets/images/page.svg',
              ),
              IconsButton(
                title: 'Sales',
                onPressed: () {
                  saleController.clearVariable();
                  Get.to(() => SalesScreen(
                        id: mainController.vendor!.id.toString(),
                      ));
                },
                imgicon: 'assets/images/sale.svg',
              ),
                 IconsButton(
                title: 'Chat',
                onPressed: () {
                  saleController.clearVariable();
                  Get.to(() => Chats_screen(
                      ));
                },
                imgicon: 'assets/images/sale.svg',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ToggleSwitch(
                  cornerRadius: 20,
                  inactiveBgColor: Colors.white,
                  borderWidth: 9,
                  radiusStyle: true,
                  fontSize: 15,
                  minWidth: 130,
                  minHeight: 40,
                  changeOnTap: true,
                  activeBgColor: [mainColor],
                  activeBorders: [
                    Border.all(
                      color: mainColor,
                      width: 3.0,
                    ),
                    Border.all(
                      color: mainColor,
                      width: 3.0,
                    ),
                  ],
                  initialLabelIndex: mainController.i,
                  totalSwitches: 2,
                  labels: ['Online', 'Offline'],
                  onToggle: (index) {
                    // setState(() {});
                    mainController.toggleonline(index);
                  },
                  customIcons: [
                    Icon(Icons.radio_button_on_outlined,
                        color: Colors.green, size: 12),
                    Icon(Icons.radio_button_on_outlined, size: 12),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () async {
                    authController.logout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Poppins',
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Image(image: AssetImage('assets/images/Arrow 1.png')),
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
