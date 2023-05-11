// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/screen/services/schedule.dart';
import 'package:translation_vendor/screen/services/servicecontroller.dart';
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
                    Navigator.pop(context);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/dart.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 6, top: 2),
                      child: Text(
                        'Online Audio/Video',
                        style: TextStyle(
                          fontFamily: 'Mazzard',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rate Per 30 mintus:',
                      style: TextStyle(
                        color: hintColor,
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' 20AED',
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/shedule.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 6, top: 4),
                      child: Text(
                        'Schedule',
                        style: TextStyle(
                          fontFamily: 'Mazzard',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
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
                    addamount(context);
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
                      Text(
                        serviceController.audioORvideo == null
                            ? '0' + ' AED'
                            : serviceController.audioORvideo! + " AED",
                        style: TextStyle(
                          color: mainColor,
                          fontFamily: 'Mazzard',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
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
                    Text(
                      serviceController.InPersonPrice == null
                          ? '0' + ' AED'
                          : serviceController.InPersonPrice! + " AED",
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/location.svg'),
                    Text(
                      ' Determine range of service',
                      style: TextStyle(
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                serviceController.locationData == null
                    ? Container()
                    : Row(
                        children: [
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width * 0.922,
                            child: GoogleMap(
                              // circles: serviceController.setCircles(),
                              scrollGesturesEnabled: true,
                              mapType: MapType.hybrid,
                              initialCameraPosition:
                                  serviceController.locationData != null
                                      ? _kLake!
                                      : _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              markers: {
                                Marker(
                                  markerId: const MarkerId("marker1"),
                                  position: LatLng(
                                      serviceController.locationData!.latitude!,
                                      serviceController
                                          .locationData!.longitude!),
                                  draggable: true,
                                  onDragEnd: (value) {
                                    // value is the new position
                                  },
                                  // To do: custom marker icon
                                ),
                                Marker(
                                  markerId: const MarkerId("marker2"),
                                  position: const LatLng(
                                      37.415768808487435, -122.08440050482749),
                                ),
                              },
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 8,
                ),
                Schedule(day: 'Monday'),
                Schedule(day: 'Tuesday'),
                Schedule(day: 'Wednesday'),
                Schedule(day: 'Thursday'),
                Schedule(day: 'Friday'),
                Schedule(day: 'Saturday'),
                Schedule(day: 'Sunday'),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/document.svg'),
                    Text(
                      'Document',
                      style: TextStyle(
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                AddPage(
                  title: 'Urgent Doucment :',
                  onPressed: () {},
                ),
                Row(
                  children: [
                    Text(
                      'Rate Per Page:',
                      style: TextStyle(
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '  5 AED',
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: 'Mazzard',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                PagePrice(
                  number: '1 - 10',
                  days: 10,
                ),
                PagePrice(
                  number: '10 - 20',
                  days: 15,
                ),
                PagePrice(
                  number: '30 - 40',
                  days: 20,
                ),
                AddPage(
                  title: 'Un Urgent Doucment :',
                  onPressed: () {},
                ),
                Row(
                  children: [
                    Text(
                      'Rate Per Page:',
                      style: TextStyle(
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '  5 AED',
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: 'Mazzard',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                PagePrice(
                  number: '1 - 10',
                  days: 10,
                ),
                PagePrice(
                  number: '10 - 20',
                  days: 15,
                ),
                PagePrice(
                  number: '30 - 40',
                  days: 20,
                ),
                SizedBox(
                  height: 12,
                ),
                LargeButton(
                    title: 'Submit',
                    textcolor: White,
                    onPressed: () {
                      // save();
                      serviceController.addservice();
                    })
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
          onPressed: () => Navigator.pop(context),
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
          onPressed: () => Navigator.pop(context),
          color: White,
        ),
      ],
    ).show();
  }

  addamount(context) {
    TextEditingController audiovideoController = TextEditingController();
    TextEditingController inpersionController = TextEditingController();
    Alert(
        context: context,
        title: "Add Price",
        content: Column(
          children: <Widget>[
            TextField(
              controller: audiovideoController,
              decoration: InputDecoration(
                labelText: 'Audio/Video',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: inpersionController,
              decoration: InputDecoration(
                labelText: 'In Person',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: mainColor,
            onPressed: () async {
              await serviceController.save(
                  inpersionController.text, audiovideoController.text);
              Navigator.pop(context);
            },
            child: Text(
              "save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
