import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/static/addpage.dart';
import 'package:translation_vendor/static/schedule.dart';
import 'package:translation_vendor/static/star.button.dart';
import 'package:translation_vendor/static/statustitle.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/static/page_p_day.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
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
              Row(
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
              Row(
                children: [
                  Image.asset(
                    'assets/images/map.png',
                    width: 380,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Saturday Working hour',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Scheduleinput(
                    hint: '9: 00',
                    fontSize: 20.0,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Scheduleinput(
                    hint: '09: 00',
                    fontSize: 20.0,
                  ),
                  StarButton(onPressed: () {
                    freezeday(context);
                  })
                ],
              ),
              Row(
                children: [
                  Text(
                    'Saturday Working hour',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Scheduleinput(
                    hint: '9: 00',
                    fontSize: 20.0,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Scheduleinput(
                    hint: '09: 00',
                    fontSize: 20.0,
                  ),
                  StarButton(onPressed: () {
                    freezeday(context);
                  })
                ],
              ),
              Row(
                children: [
                  Text(
                    'Saturday Working hour',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Scheduleinput(
                    hint: '9: 00',
                    fontSize: 20.0,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Scheduleinput(
                    hint: '09: 00',
                    fontSize: 20.0,
                  ),
                  StarButton(onPressed: () {
                    freezeday(context);
                  })
                ],
              ),
              Row(
                children: [
                  Text(
                    'Saturday Working hour',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Scheduleinput(
                    hint: '9: 00',
                    fontSize: 20.0,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Scheduleinput(
                    hint: '09: 00',
                    fontSize: 20.0,
                  ),
                  StarButton(onPressed: () {
                    freezeday(context);
                  })
                ],
              ),
              Row(
                children: [
                  Text(
                    'Saturday Working hour',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Scheduleinput(
                    hint: '9: 00',
                    fontSize: 20.0,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Scheduleinput(
                    hint: '09: 00',
                    fontSize: 20.0,
                  ),
                  StarButton(onPressed: () {
                    freezeday(context);
                  })
                ],
              ),
              Row(
                children: [
                  Text(
                    'Saturday Working hour',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Scheduleinput(
                    hint: '9: 00',
                    fontSize: 20.0,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Scheduleinput(
                    hint: '09: 00',
                    fontSize: 20.0,
                  ),
                  StarButton(onPressed: () {
                    freezeday(context);
                  })
                ],
              ),
              Row(
                children: [
                  Text(
                    'Saturday Working hour',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Scheduleinput(
                    hint: '9: 00',
                    fontSize: 20.0,
                  ),
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Scheduleinput(
                    hint: '09: 00',
                    fontSize: 20.0,
                  ),
                  StarButton(onPressed: () {
                    freezeday(context);
                  })
                ],
              ),
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
            ],
          ),
        ),
      )),
    );
  }

  freezeday(context) {
    Alert(
       style: AlertStyle(titleStyle: TextStyle(fontSize: 25),),
      context: context,
      
    
    
      title: "Are you sure to want freeze this page",
      buttons: [
        DialogButton(
          height: 60,
          child: Text(
            "yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: mainColor,
        ),
        DialogButton(
          height: 60,
          border: Border.all(
            color: Colors.black,
          ),
          child: Text(
            "No",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: White,
        ),
      ],
    ).show();
  }
}
