import 'package:translation_vendor/models/document.dart';
import 'package:translation_vendor/models/user.dart';
import 'package:translation_vendor/models/vendor.dart';

class Order {
  int? id;
  int? user_id;
  int? price;
  int? duration;
  String? vendor_id;
  String? starttime;
  String? endtime;
  String? date;
  String? servicetype;
  String? scheduletype;
  String? status;
  String? lat;
  String? lng;
  DateTime? created_at;
  User? user;
  Vendor? vendor;
  OrderDocument? document;

  Order(order) {
    id = order['id'];
    price = order['price'];
    servicetype = order['servicetype'];
    scheduletype = order['scheduletype'];
    duration = order['duration'];
    starttime = order['starttime'];
    endtime = order['endtime'];
    date = order['date'];
    lat = order['latitude'] ?? '0';
    lng = order['longitude'] ?? '0';
    status = order['status'];
    vendor_id = order['vendor_id'];
    user_id = order['user_id'];
    order['servicetype'] == 'document'
        ? document = OrderDocument(order['document'])
        : '';
    created_at = DateTime.parse(order['created_at']).toLocal();
    user = User(order['user']);
    vendor = Vendor(order['vendor']);
  }
}
