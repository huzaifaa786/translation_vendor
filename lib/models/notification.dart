import 'package:translation_vendor/models/notiorder.dart';
import 'package:translation_vendor/models/order.dart';
import 'package:translation_vendor/models/user.dart';
import 'package:translation_vendor/models/vendor.dart';
import 'package:translation_vendor/models/document.dart';

class Notificationn {
  int? id;
  int? user_id;
  String? vendor_id;
  String? title;
  Order? orderr;
  User? user;
  String? created_at;

  Notificationn(notification) {
    id = notification['id'];
    title = notification['title'];
    orderr = notification['order'] != null ? Order(notification['order']) : null;
    user = User(notification['user']);
    created_at = notification['created_at'];
  }
}
