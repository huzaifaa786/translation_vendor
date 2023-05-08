import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/screen/services/schedule.dart';
import 'package:translation_vendor/screen/services/servicecontroller.dart';
import 'package:translation_vendor/static/addpage.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/schedule.dart';
import 'package:translation_vendor/static/star.button.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/static/page_p_day.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  List<WorkingHour> workingHours = [];
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  save() {
    // print(workingHours);
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
                    Text(
                      ' Online Auid/Viedo',
                      style: TextStyle(
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
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
                    Text(
                      ' Schedule',
                      style: TextStyle(
                        fontFamily: 'Mazzard',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
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
                        ' Auid/Viedo',
                        style: TextStyle(
                          color: hintColor,
                          fontFamily: 'Mazzard',
                          fontSize: 18,
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
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' In Persion',
                      style: TextStyle(
                        color: hintColor,
                        fontFamily: 'Mazzard',
                        fontSize: 18,
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
                Row(
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.922,
                      child: GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Schedule(day: 'Monday'),
                Schedule(day:'Tuesday'),
                Schedule(day:'Wednesday'),
                Schedule(day:'Thursday'),
                Schedule(day:'Friday'),
                Schedule(day:'Saturday'),
                Schedule(day:'Sunday'),
                // Row(
                //   children: [
                //     Text(
                //       'Saturday Working hour',
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Scheduleinput(
                //       hint: '9: 00',
                //       fontSize: 20.0,
                //     ),
                //     Text(
                //       "To",
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Scheduleinput(
                //       hint: '09: 00',
                //       fontSize: 20.0,
                //     ),
                //     StarButton(onPressed: () {
                //       freezeday(context);
                //     })
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text(
                //       'Saturday Working hour',
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Scheduleinput(
                //       hint: '9: 00',
                //       fontSize: 20.0,
                //     ),
                //     Text(
                //       "To",
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Scheduleinput(
                //       hint: '09: 00',
                //       fontSize: 20.0,
                //     ),
                //     StarButton(onPressed: () {
                //       freezeday(context);
                //     })
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text(
                //       'Saturday Working hour',
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Scheduleinput(
                //       hint: '9: 00',
                //       fontSize: 20.0,
                //     ),
                //     Text(
                //       "To",
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Scheduleinput(
                //       hint: '09: 00',
                //       fontSize: 20.0,
                //     ),
                //     StarButton(onPressed: () {
                //       freezeday(context);
                //     })
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text(
                //       'Saturday Working hour',
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Scheduleinput(
                //       hint: '9: 00',
                //       fontSize: 20.0,
                //     ),
                //     Text(
                //       "To",
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Scheduleinput(
                //       hint: '09: 00',
                //       fontSize: 20.0,
                //     ),
                //     StarButton(onPressed: () {
                //       freezeday(context);
                //     })
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text(
                //       'Saturday Working hour',
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Scheduleinput(
                //       hint: '9: 00',
                //       fontSize: 20.0,
                //     ),
                //     Text(
                //       "To",
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Scheduleinput(
                //       hint: '09: 00',
                //       fontSize: 20.0,
                //     ),
                //     StarButton(onPressed: () {
                //       freezeday(context);
                //     })
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text(
                //       'Saturday Working hour',
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Scheduleinput(
                //       hint: '9: 00',
                //       fontSize: 20.0,
                //     ),
                //     Text(
                //       "To",
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Scheduleinput(
                //       hint: '09: 00',
                //       fontSize: 20.0,
                //     ),
                //     StarButton(onPressed: () {
                //       freezeday(context);
                //     })
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text(
                //       'Saturday Working hour',
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Scheduleinput(
                //       hint: '9: 00',
                //       fontSize: 20.0,
                //     ),
                //     Text(
                //       "To",
                //       style: TextStyle(
                //         fontFamily: 'Mazzard',
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Scheduleinput(
                //       hint: '09: 00',
                //       fontSize: 20.0,
                //     ),
                //     StarButton(onPressed: () {
                //       freezeday(context);
                //     })
                //   ],
                // ),
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
                      serviceController.addservice(workingHours);
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
                labelText: 'Audio/video',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: inpersionController,
              decoration: InputDecoration(
                labelText: 'inpersion',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              await save();
            },
            child: Text(
              "save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
