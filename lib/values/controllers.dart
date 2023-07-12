import 'package:translation_vendor/screen/chat/chatcontroller.dart';
import 'package:translation_vendor/screen/history/historycontroller.dart';
import 'package:translation_vendor/screen/login/authcontroller.dart';
import 'package:translation_vendor/screen/main/maincontroller.dart';
import 'package:translation_vendor/screen/notification/noticontroller.dart';
import 'package:translation_vendor/screen/order_status/statuscontroller.dart';
import 'package:translation_vendor/screen/profile/profilecontroller.dart';
import 'package:translation_vendor/screen/sale/salecontroller.dart';
import 'package:translation_vendor/screen/services/servicecontroller.dart';

AuthController authController = AuthController.instance;
MainController mainController = MainController.instance;
ServiceController serviceController = ServiceController.instance;
ProfileController profileController = ProfileController.instance;
HistoryController historyController = HistoryController.instance;
StatusController statusController = StatusController.instance;
SaleController saleController = SaleController.instance;
NotificationController notificationController = NotificationController.instance;
ChatController chatController = ChatController.instance;