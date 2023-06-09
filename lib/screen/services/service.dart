// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:translation_vendor/models/documentlist.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:translation_vendor/screen/services/map.dart';
import 'package:translation_vendor/screen/services/schedule.dart';
import 'package:translation_vendor/screen/services/servicecontroller.dart';
import 'package:translation_vendor/static/LocationButton.dart';
import 'package:translation_vendor/static/addpage.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/icon_button.dart';
import 'package:translation_vendor/static/schedule.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/static/page_p_day.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:translation_vendor/values/controllers.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static CameraPosition? _kLake;

  List<WorkingHour> workingHours = [];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await serviceController.getlocation();
      setState(() {
        print(serviceController.locationData!.latitude);
        _kLake = CameraPosition(
            // bearing: 192.8334901395799,
            target: LatLng(serviceController.locationData!.latitude!,
                serviceController.locationData!.longitude!),
            tilt: 59.440717697143555,
            zoom: 19.151926040649414);
        print('object');
        print(_kLake);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ServiceController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TitleTopbar(
                  text: 'Service',
                  ontap: () {
                    Get.back();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/dart.svg'),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          'Online Audio/Video',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    serviceController.openOnlineAudioORvideoField();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rate Per 30 mintus: ',
                        style: TextStyle(
                          color: hintColor,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      serviceController.showOnlineAudioORvideoPriceField ==
                              false.obs
                          ? Text(
                              serviceController.onlineAudioORvideo == null
                                  ? '0' + ' AED'
                                  : serviceController.onlineAudioORvideo! +
                                      " AED",
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : AutoSizeTextField(
                              controller:
                                  serviceController.onlineAudiovideoController,
                              fullwidth: false,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              style: TextStyle(fontSize: 18),
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    serviceController
                                        .EditOnlineAudioORvideoAbout();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Icon(Icons.check,
                                        color: mainColor, size: 18),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: SvgPicture.asset('assets/images/shedule.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        'Schedule',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 23,
                ),
                InkWell(
                  onTap: () {
                    serviceController.openaudioORvideoField();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Audio/Video',
                        style: TextStyle(
                          color: hintColor,
                          fontFamily: 'Mazzard',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      serviceController.showaudioORvideoPriceField == false.obs
                          ? Text(
                              serviceController.audioORvideo == null
                                  ? '0' + ' AED'
                                  : serviceController.audioORvideo! + " AED",
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: 'Mazzard',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : AutoSizeTextField(
                              controller:
                                  serviceController.audiovideoController,
                              fullwidth: false,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              style: TextStyle(fontSize: 18),
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    serviceController.EditaudioORvideoAbout();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Icon(Icons.check,
                                        color: mainColor, size: 18),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    serviceController.openInPersonField();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'In Person',
                        style: TextStyle(
                          color: hintColor,
                          fontFamily: 'Mazzard',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      serviceController.showInPersonPriceField == false.obs
                          ? Text(
                              serviceController.InPersonPrice == null
                                  ? '0' + ' AED'
                                  : serviceController.InPersonPrice! + " AED",
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: 'Mazzard',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : AutoSizeTextField(
                              controller: serviceController.inpersionController,
                              fullwidth: false,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              style: TextStyle(fontSize: 18),
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    serviceController.EditInPersonPrice();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Icon(Icons.check,
                                        color: mainColor, size: 18),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/location.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        ' Determine range of service',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                LocationButton(
                    title: 'Choose location',
                    icon: Icons.my_location_rounded,
                    onPressed: () {
                      // controller.getlocation();
                      Get.to(() => VendorMapScreen());
                    }),
                // serviceController.locationData == null
                //     ? Container()
                //     : Row(
                //         children: [
                //           Container(
                //             height: 180,
                //             width: MediaQuery.of(context).size.width * 0.9,
                //             child: GoogleMap(
                //               // circles: serviceController.setCircles(),
                //               scrollGesturesEnabled: true,
                //               mapType: MapType.hybrid,
                //               initialCameraPosition:
                //                   serviceController.locationData != null
                //                       ? _kLake!
                //                       : _kGooglePlex,
                //               onMapCreated: (GoogleMapController controller) {
                //                 _controller.complete(controller);
                //               },
                //               markers: {
                //                 Marker(
                //                   markerId: const MarkerId("marker1"),
                //                   position: LatLng(
                //                       serviceController.locationData!.latitude!,
                //                       serviceController
                //                           .locationData!.longitude!),
                //                   draggable: true,
                //                   onDragEnd: (value) {
                //                     // value is the new position
                //                   },
                //                   // To do: custom marker icon
                //                 ),
                //                 Marker(
                //                   markerId: const MarkerId("marker2"),
                //                   position: const LatLng(
                //                       37.415768808487435, -122.08440050482749),
                //                 ),
                //               },
                //             ),
                //           ),
                //         ],
                //       ),
                SizedBox(
                  height: 20,
                ),
                Schedule(day: 'Monday'),
                Schedule(day: 'Tuesday'),
                Schedule(day: 'Wednesday'),
                Schedule(day: 'Thursday'),
                Schedule(day: 'Friday'),
                Schedule(day: 'Saturday'),
                Schedule(day: 'Sunday'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/document.svg'),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Document',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                AddPage(
                  title: 'Urgent Doucment :',
                  onPressed: () {
                    urgentdoc(context);
                  },
                ),
                InkWell(
                  onTap: () {
                    serviceController.openurgentField();
                  },
                  child: Row(
                    children: [
                      Text(
                        'Rate Per Page: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      serviceController.showurgentPriceField == false.obs
                          ? Text(
                              serviceController.urgentPrice == null
                                  ? '0 AED'
                                  : serviceController.urgentPrice! + '  AED',
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : AutoSizeTextField(
                              controller: serviceController.urgentController,
                              fullwidth: false,
                              style: TextStyle(fontSize: 18),
                              // maxLines: null,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    serviceController.EditurgentPrice();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Icon(Icons.check,
                                        color: mainColor, size: 18),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                for (var document in serviceController.urgentdocument)
                  PagePrice(
                    minpage: document.minpage,
                    maxpage: document.maxpage,
                    days: document.day,
                  ),
                AddPage(
                  title: 'Un Urgent Doucment :',
                  onPressed: () {
                    addpage(context);
                  },
                ),
                InkWell(
                  onTap: () {
                    serviceController.openUnurgentField();
                  },
                  child: Row(
                    children: [
                      Text(
                        'Rate Per Page: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      serviceController.showUnurgentPriceField == false.obs
                          ? Text(
                              serviceController.UnurgentPrice == null
                                  ? '0 AED'
                                  : serviceController.UnurgentPrice! + '  AED',
                              style: TextStyle(
                                color: mainColor,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : AutoSizeTextField(
                              controller: serviceController.UnurgentController,
                              fullwidth: false,
                              style: TextStyle(fontSize: 18),
                              // maxLines: null,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    serviceController.EditUnurgentPrice();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Icon(Icons.check,
                                        color: mainColor, size: 18),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                for (var document in serviceController.unurgentdocument)
                  PagePrice(
                    minpage: document.minpage,
                    maxpage: document.maxpage,
                    days: document.day,
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: LargeButton(
                      title: 'Submit',
                      textcolor: White,
                      onPressed: () {
                        serviceController.addservice();
                      }),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  freezeday(context) {
    Alert(
      style: AlertStyle(
        titleStyle: TextStyle(fontSize: 25),
      ),
      context: context,
      title: "Are you sure to freeze this day",
      buttons: [
        DialogButton(
          height: 60,
          radius: BorderRadius.circular(12),
          child: Text(
            "yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Get.back(),
          color: mainColor,
        ),
        DialogButton(
          height: 60,
          radius: BorderRadius.circular(12),
          border: Border.all(
            color: mainColor,
          ),
          child: Text(
            "No",
            style: TextStyle(color: mainColor, fontSize: 20),
          ),
          onPressed: () => Get.back(),
          color: White,
        ),
      ],
    ).show();
  }

  addpage(context) {
    TextEditingController minController = TextEditingController();
    TextEditingController maxController = TextEditingController();
    TextEditingController totaldayController = TextEditingController();
    Alert(
        context: context,
        title: "Document",
        content: Column(
          children: <Widget>[
            TextField(
              controller: minController,
              decoration: InputDecoration(
                labelText: 'Minimum page',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: maxController,
              decoration: InputDecoration(
                labelText: 'Maximum page',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: totaldayController,
              decoration: InputDecoration(
                labelText: 'Total days to complete',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: mainColor,
            onPressed: () {
              if (totaldayController.text != '') {
                if (minController.text != '') {
                  if (maxController.text != '') {
                    serviceController.unurgentdocument.add(Documentlist(
                        day: totaldayController.text,
                        minpage: minController.text,
                        maxpage: maxController.text));
                    Get.back();
                  } else {
                    Get.snackbar('Error!', 'Fillout All TextFields.',
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM);
                  }
                } else {
                  Get.snackbar('Error!', 'Fillout All TextFields.',
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM);
                }
              } else {
                Get.snackbar('Error!', 'Fillout All TextFields.',
                    colorText: Colors.white,
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Text(
              "save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  urgentdoc(context) {
    TextEditingController minController = TextEditingController();
    TextEditingController maxController = TextEditingController();
    TextEditingController totaldayController = TextEditingController();
    Alert(
        context: context,
        title: "Document",
        content: Column(
          children: <Widget>[
            TextField(
              controller: minController,
              decoration: InputDecoration(
                labelText: 'Minimum page',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: maxController,
              decoration: InputDecoration(
                labelText: 'Maximum page',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: totaldayController,
              decoration: InputDecoration(
                labelText: 'Total days to complete',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: mainColor,
            onPressed: () {
              if (totaldayController.text != '') {
                if (minController.text != '') {
                  if (maxController.text != '') {
                    serviceController.urgentdocument.add(Documentlist(
                        day: totaldayController.text,
                        minpage: minController.text,
                        maxpage: maxController.text));
                    print(serviceController.urgentdocument);
                    Get.back();
                  } else {
                    Get.snackbar('Error!', 'Fillout All TextFields.',
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM);
                  }
                } else {
                  Get.snackbar('Error!', 'Fillout All TextFields.',
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM);
                }
              } else {
                Get.snackbar('Error!', 'Fillout All TextFields.',
                    colorText: Colors.white,
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Text(
              "save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
