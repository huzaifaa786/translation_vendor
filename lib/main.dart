import 'package:flutter/material.dart';
import 'package:translation_vendor/screen/history/history.dart';
import 'package:translation_vendor/screen/login/login.dart';
import 'package:translation_vendor/screen/main/main.dart';
import 'package:translation_vendor/screen/notification/notification.dart';
import 'package:translation_vendor/screen/order_status/order_status.dart';
import 'package:translation_vendor/screen/profile/profile.dart';
import 'package:translation_vendor/screen/register/register.dart';
import 'package:translation_vendor/screen/sale/sales.dart';
import 'package:translation_vendor/screen/services/service.dart';
import 'package:translation_vendor/values/styles.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // builder: EasyLoading.init(),
      title: "Trans",
      theme: Styles.lightTheme,
      initialRoute: 'main',
      routes: {
        'login': (context) => const LoginScreen(),
        'notification': (context) => const NotificationScreen(),
        'Sale': (context) => const SalesScreen(),
        'history': (context) => const HistoryScreen(),
        'main': (context) => const MainScreen(),
        'orderstatus': (context) => const OrderStatus(),
        'register': (context) => const RegesterScreen(),
        'service': (context) => const ServiceScreen(),
        'profile': (context) => const Profile()
      },
    );
  }
}
