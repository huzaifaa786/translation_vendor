import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/screen/chat/chatcontroller.dart';
import 'package:translation_vendor/screen/chat/chats.dart';
import 'package:translation_vendor/screen/history/history.dart';
import 'package:translation_vendor/screen/main/maincontroller.dart';
import 'package:translation_vendor/screen/profile/profile.dart';
import 'package:translation_vendor/screen/sale/sales.dart';
import 'package:translation_vendor/screen/services/service.dart';
import 'package:translation_vendor/static/chatButton.dart';
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

  msg() async {
    await chatController.unseenchat();
  }

  // String? greeting = '';
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      msg();
      mainController.getVendor();
    });
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ChatController>(
        builder: (chatcontroller) => GetBuilder<MainController>(
          builder: (controller) => Container(
            // padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: Get.height * 0.2,
                            decoration: BoxDecoration(
                                color: greenish,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(14),
                                    bottomRight: Radius.circular(14))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Topbar(),
                                mainController.vendor != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0, left: 20, bottom: 25),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Text(
                                                    'Hello' + ', ',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: White,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Text(
                                                    mainController
                                                        .vendor!.name!,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: White,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          top: 0,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Hello' + '',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: White,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          
                        
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 120,
                            right: 18,
                            left: 18,
                          ),
                          height: Get.height * 0.8,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2))
                              ],
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(14)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: IconsButton(
                                  title: 'Profile',
                                  onPressed: () {
                                    profileController.clearVariables();
                                    Get.to(() => Profile());
                                  },
                                  imgicon: 'assets/images/userprofile.svg',
                                ),
                              ),
                              IconsButton(
                                title: 'Services',
                                onPressed: () async {
                                  var i = await serviceController.getlocation();
                                  if (i != null) {
                                    serviceController.clearServiceScreen();
                                    Get.to(() => ServiceScreen());
                                  } else {
                                    Get.snackbar(
                                        "Please Enable Location Permissions To Proceed",
                                        '',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white);
                                    LoadingHelper.dismiss();
                                  }
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
                              ChatButton(
                                title: 'Chat',
                                screen: 'Chat',
                                count: chatController.unseen,
                                onPressed: () {
                                  saleController.clearVariable();
                                  Get.to(() => Chats_screen());
                                },
                                imgicon: 'assets/images/chat.svg',
                              ),
                              SizedBox(height: 15),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 30),
                              //   child: ToggleSwitch(
                              //     cornerRadius: 20,
                              //     inactiveBgColor: Colors.white,
                              //     borderWidth: 9,
                              //     radiusStyle: true,
                              //     fontSize: 15,
                              //     minWidth: 130,
                              //     minHeight: 40,
                              //     changeOnTap: true,
                              //     activeBgColor: [mainColor],
                              //     activeBorders: [
                              //       Border.all(
                              //         color: mainColor,
                              //         width: 3.0,
                              //       ),
                              //       Border.all(
                              //         color: mainColor,
                              //         width: 3.0,
                              //       ),
                              //     ],
                              //     initialLabelIndex: mainController.i,
                              //     totalSwitches: 2,
                              //     labels: ['Online', 'Offline'],
                              //     onToggle: (index) async {
                              //       if (index == mainController.i) {
                              //       } else {
                              //         mainController.notoggle(mainController.i);
                              //         var i = await updateStatus(context);
                              //         print(i);
                              //         i == true ? mainController.toggleonline(index) : null;
                              //         print(index);
                              //         setState(() {});
                              //       }
                              //     },
                              //     customIcons: [
                              //       Icon(Icons.radio_button_on_outlined,
                              //           color: Colors.green, size: 12),
                              //       Icon(Icons.radio_button_on_outlined, size: 12),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: InkWell(
                                  onTap: () async {
                                    logout(context);
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
                                      Image(
                                          image: AssetImage(
                                              'assets/images/Arrow 1.png')),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future<bool> updateStatus(BuildContext context) async {
    bool? result = await Alert(
      style: AlertStyle(
        titleStyle: TextStyle(fontSize: 25),
      ),
      context: context,
      title: "Are you sure you want to update Online/Offline Status",
      buttons: [
        DialogButton(
          radius: BorderRadius.all(
            Radius.circular(12),
          ),
          height: 60,
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(true);
          },
          color: mainColor,
        ),
        DialogButton(
          radius: BorderRadius.all(
            Radius.circular(12),
          ),
          height: 60,
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(false);
          },
          color: mainColor,
        ),
      ],
    ).show();
    return result ?? false;
  }

  logout(context) {
    Alert(
      style: AlertStyle(
        titleStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
      ),
      context: context,
      image: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SvgPicture.asset('assets/images/logout.svg'),
      ),
      title: "Are you sure you want to logout?",
      buttons: [
        DialogButton(
          height: 55,
          radius: BorderRadius.circular(13),
          child: Text(
            "Yes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            authController.logout();
          },
          color: mainColor,
        ),
        DialogButton(
          height: 55,
          radius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.black54,
          ),
          child: Text(
            "No",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Get.back();
          },
          color: Colors.black,
        ),
      ],
    ).show();
  }
}
