import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/screen/login/login.dart';
import 'package:translation_vendor/screen/main/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:translation_vendor/screen/profile/profile.dart';
import 'package:translation_vendor/values/controllers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    LoadingHelper.init();
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  Future route() async {
    GetStorage box = GetStorage();
    final String? authCheck = await box.read('api_token');
    print(authCheck);
    if (authCheck == null) {
      Get.off(() => LoginScreen());
    } else {
        
      Get.off(() => MainScreen());
    }
  }
}

initScreen(BuildContext context) {
  return Scaffold(
    body: SizedBox(
      width: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Image(image: AssetImage("assets/images/splashLogo.png"))
        ],
      ),
    ),
  );
}
