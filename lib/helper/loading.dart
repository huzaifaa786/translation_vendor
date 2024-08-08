import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:translation_vendor/values/colors.dart';

class LoadingHelper {
  static bool absorbClick = false;
  static var onChangeAbsorbClick;

  static show() {
    absorbClick = true;
    // EasyLoading.show();
  }

  static dismiss() {
    absorbClick = false;
    // EasyLoading.dismiss();
  }

  static Future<void> init() async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.transparent
      ..indicatorColor = greenish
      ..textColor = greenish
      ..maskColor = greenish.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[];
  }
}
