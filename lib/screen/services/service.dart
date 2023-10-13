// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/models/documentlist.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:translation_vendor/screen/services/map.dart';
import 'package:translation_vendor/screen/services/schedule.dart';
import 'package:translation_vendor/screen/services/servicecontroller.dart';
import 'package:translation_vendor/static/LocationButton.dart';
import 'package:translation_vendor/static/addpage.dart';
import 'package:translation_vendor/static/button.dart';
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

  fetchservice() async {
    await serviceController.getservice();
    setState(() {});
  }

  void initState() {
    super.initState();
    fetchservice();
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
      if (mainController.vendor!.service != null) {
        setState(() {});
        serviceController.onlineAudioORvideo =
            mainController.vendor!.service!.onlineaudiovideoPrice;
        serviceController.audioORvideo =
            mainController.vendor!.service!.audiovideo;
        serviceController.InPersonPrice =
            mainController.vendor!.service!.inperson;
        serviceController.urgentPrice =
            mainController.vendor!.service!.urgentprice;
        serviceController.UnurgentPrice =
            mainController.vendor!.service!.unurgentprice;
        serviceController.urgentdocument =
            mainController.vendor!.service!.urgent!;
        serviceController.unurgentdocument =
            mainController.vendor!.service!.unurgent!;
        serviceController.chnagePoint = LatLng(
            mainController.vendor!.service!.lat == 0
                ? serviceController.locationData!.latitude!
                : mainController.vendor!.service!.lat!,
            mainController.vendor!.service!.lng! == 0
                ? serviceController.locationData!.longitude!
                : mainController.vendor!.service!.lng!);
        serviceController.radius = mainController.vendor!.service!.radius!;
        serviceController.workingHours =
            mainController.vendor!.service!.schedule!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: White,
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: mainColor,
                        value: serviceController.iAudioOrVideo,
                        onChanged: (bool? value) {
                          setState(() {
                            serviceController.iAudioOrVideo = value!;
                          });
                        },
                      ),
                      Text('Audio / Video Interpretaion')
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: mainColor,
                        value: serviceController.isInperson,
                        onChanged: (bool? value) {
                          setState(() {
                            serviceController.isInperson = value!;
                          });
                        },
                      ),
                      Text('Inperson Interpretaion')
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: mainColor,
                        value: serviceController.isDocument,
                        onChanged: (bool? value) {
                          setState(() {
                            serviceController.isDocument = value!;
                          });
                        },
                      ),
                      Text('Document Translation')
                    ],
                  ),
                ),
                serviceController.iAudioOrVideo != false
                    ? Column(
                        children: [
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
                            focusColor: White,
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
                                serviceController
                                            .showOnlineAudioORvideoPriceField ==
                                        false.obs
                                    ? Text(
                                        serviceController.onlineAudioORvideo ==
                                                null
                                            ? '0' + ' AED'
                                            : serviceController
                                                    .onlineAudioORvideo! +
                                                " AED",
                                        style: TextStyle(
                                          color: mainColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : AutoSizeTextField(
                                        controller: serviceController
                                            .onlineAudiovideoController,
                                        fullwidth: false,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        style: TextStyle(fontSize: 18),
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              serviceController
                                                  .EditOnlineAudioORvideoPrice();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Icon(Icons.check,
                                                  color: mainColor, size: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 23,
                ),
                serviceController.isDocument != false
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/document1.svg',
                                color: mainColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
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
                            focusColor: White,
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
                                serviceController.showurgentPriceField ==
                                        false.obs
                                    ? Text(
                                        serviceController.urgentPrice == null
                                            ? '0 AED'
                                            : serviceController.urgentPrice! +
                                                '  AED',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : AutoSizeTextField(
                                        controller:
                                            serviceController.urgentController,
                                        fullwidth: false,
                                        style: TextStyle(fontSize: 18),
                                        // maxLines: null,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              serviceController
                                                  .EditurgentPrice();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
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
                            InkWell(
                              onTap: () {
                                editurgentdoc(context, document.minpage,
                                    document.maxpage, document.day);
                              },
                              child: PagePrice(
                                minpage: document.minpage,
                                maxpage: document.maxpage,
                                days: document.day,
                              ),
                            ),
                          AddPage(
                            title: 'Un Urgent Doucment :',
                            onPressed: () {
                              addpage(context);
                            },
                          ),
                          InkWell(
                            focusColor: White,
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
                                serviceController.showUnurgentPriceField ==
                                        false.obs
                                    ? Text(
                                        serviceController.UnurgentPrice == null
                                            ? '0 AED'
                                            : serviceController.UnurgentPrice! +
                                                '  AED',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : AutoSizeTextField(
                                        controller: serviceController
                                            .UnurgentController,
                                        fullwidth: false,
                                        style: TextStyle(fontSize: 18),
                                        // maxLines: null,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              serviceController
                                                  .EditUnurgentPrice();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Icon(Icons.check,
                                                  color: mainColor, size: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          for (var document
                              in serviceController.unurgentdocument)
                            InkWell(
                              onTap: () {
                                editunurgentdoc(context, document.minpage,
                                    document.maxpage, document.day);
                              },
                              child: PagePrice(
                                minpage: document.minpage,
                                maxpage: document.maxpage,
                                days: document.day,
                              ),
                            ),
                          SizedBox(height: 20)
                        ],
                      )
                    : Container(),
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
                serviceController.iAudioOrVideo != false
                    ? InkWell(
                        focusColor: White,
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
                            serviceController.showaudioORvideoPriceField ==
                                    false.obs
                                ? Text(
                                    serviceController.audioORvideo == null
                                        ? '0' + ' AED'
                                        : serviceController.audioORvideo! +
                                            " AED",
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
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          serviceController
                                              .EditaudioORvideoPrice();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Icon(Icons.check,
                                              color: mainColor, size: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    : Container(),
                serviceController.iAudioOrVideo != false
                    ? SizedBox(
                        height: 12,
                      )
                    : Container(),
                serviceController.isInperson != false
                    ? InkWell(
                        focusColor: White,
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
                            serviceController.showInPersonPriceField ==
                                    false.obs
                                ? Text(
                                    serviceController.InPersonPrice == null
                                        ? '0' + ' AED'
                                        : serviceController.InPersonPrice! +
                                            " AED",
                                    style: TextStyle(
                                      color: mainColor,
                                      fontFamily: 'Mazzard',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : AutoSizeTextField(
                                    controller:
                                        serviceController.inpersionController,
                                    fullwidth: false,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    style: TextStyle(fontSize: 18),
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          serviceController.EditInPersonPrice();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Icon(Icons.check,
                                              color: mainColor, size: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    : Container(),
                serviceController.isInperson != false
                    ? SizedBox(height: 12)
                    : Container(),
                serviceController.isInperson != false
                    ? Column(children: [
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
                              Get.to(() => VendorMapScreen(
                                  service: mainController.vendor!.service));
                            }),
                      ])
                    : Container(),
                serviceController.isInperson != false
                    ? SizedBox(
                        height: 20,
                      )
                    : Container(),
                Schedule(
                    day: 'Monday',
                    startTime: mainController.vendor!.service == null
                        ? '09:00'
                        : mainController
                            .vendor!.service!.schedule![0].startTime,
                    endTime: mainController.vendor!.service == null
                        ? '17:00'
                        : mainController.vendor!.service!.schedule![0].endTime),
                Schedule(
                    day: 'Tuesday',
                    startTime: mainController.vendor!.service == null
                        ? '09:00'
                        : mainController
                            .vendor!.service!.schedule![1].startTime,
                    endTime: mainController.vendor!.service == null
                        ? '17:00'
                        : mainController.vendor!.service!.schedule![1].endTime),
                Schedule(
                    day: 'Wednesday',
                    startTime: mainController.vendor!.service == null
                        ? '09:00'
                        : mainController
                            .vendor!.service!.schedule![2].startTime,
                    endTime: mainController.vendor!.service == null
                        ? '17:00'
                        : mainController.vendor!.service!.schedule![2].endTime),
                Schedule(
                    day: 'Thursday',
                    startTime: mainController.vendor!.service == null
                        ? '09:00'
                        : mainController
                            .vendor!.service!.schedule![3].startTime,
                    endTime: mainController.vendor!.service == null
                        ? '17:00'
                        : mainController.vendor!.service!.schedule![3].endTime),
                Schedule(
                    day: 'Friday',
                    startTime: mainController.vendor!.service == null
                        ? '09:00'
                        : mainController
                            .vendor!.service!.schedule![4].startTime,
                    endTime: mainController.vendor!.service == null
                        ? '17:00'
                        : mainController.vendor!.service!.schedule![4].endTime),
                Schedule(
                    day: 'Saturday',
                    startTime: mainController.vendor!.service == null
                        ? '09:00'
                        : mainController
                            .vendor!.service!.schedule![5].startTime,
                    endTime: mainController.vendor!.service == null
                        ? '17:00'
                        : mainController.vendor!.service!.schedule![5].endTime),
                Schedule(
                    day: 'Sunday',
                    startTime: mainController.vendor!.service == null
                        ? '09:00'
                        : mainController
                            .vendor!.service!.schedule![6].startTime,
                    endTime: mainController.vendor!.service == null
                        ? '17:00'
                        : mainController.vendor!.service!.schedule![6].endTime),
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
              setState(() {});
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
                      maxpage: maxController.text,
                    ));
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
              setState(() {});
            },
            child: Text(
              "save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  editurgentdoc(context, minpage, maxpage, day) {
    TextEditingController minController =
        TextEditingController(text: minpage.toString());
    TextEditingController maxController =
        TextEditingController(text: maxpage.toString());
    TextEditingController totaldayController =
        TextEditingController(text: day.toString());
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
            // Retrieve the updated values from the text controllers
            String updatedMinPage = minController.text;
            String updatedMaxPage = maxController.text;
            String updatedDay = totaldayController.text;

            // Find the index of the item you want to update in the list
            int index = serviceController.urgentdocument.indexWhere(
                (document) =>
                    document.minpage == minpage &&
                    document.maxpage == maxpage &&
                    document.day == day);

            if (index != -1) {
              // Update the item at the found index
              serviceController.urgentdocument[index].minpage = updatedMinPage;
              serviceController.urgentdocument[index].maxpage = updatedMaxPage;
              serviceController.urgentdocument[index].day = updatedDay;
            }
            serviceController.addservice();
            setState(() {});
            // Close the dialog
            Get.back();
          },
          child: Text(
            "save",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  editunurgentdoc(context, minpage, maxpage, day) {
    TextEditingController minController =
        TextEditingController(text: minpage.toString());
    TextEditingController maxController =
        TextEditingController(text: maxpage.toString());
    TextEditingController totaldayController =
        TextEditingController(text: day.toString());
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
              // Retrieve the updated values from the text controllers
              String updatedMinPage = minController.text;
              String updatedMaxPage = maxController.text;
              String updatedDay = totaldayController.text;

              // Find the index of the item you want to update in the list
              int index = serviceController.unurgentdocument.indexWhere(
                  (document) =>
                      document.minpage == minpage &&
                      document.maxpage == maxpage &&
                      document.day == day);

              if (index != -1) {
                // Update the item at the found index
                serviceController.unurgentdocument[index].minpage =
                    updatedMinPage;
                serviceController.unurgentdocument[index].maxpage =
                    updatedMaxPage;
                serviceController.unurgentdocument[index].day = updatedDay;
              }
              serviceController.addservice();
              setState(() {});
              // Close the dialog
              Get.back();
            },
            child: Text(
              "save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
