import 'package:translation_vendor/models/document.dart';
import 'package:translation_vendor/models/user.dart';
import 'package:translation_vendor/models/vendor.dart';
import 'package:forex_conversion/forex_conversion.dart';
import 'package:get_storage/get_storage.dart';

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
  String? currency;
  DateTime? created_at;
  User? user;
  Vendor? vendor;
  OrderDocument? document;
  String? convertedPrice;

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
    currency = order['currency'];

    user_id = order['user_id'];
    order['servicetype'] == 'document'
        ? document = OrderDocument(order['document'])
        : '';
    created_at = DateTime.parse(order['created_at']).toLocal();
    user = User(order['user']);
    vendor = Vendor(order['vendor']);
    convertedPrice = ''; 
  }
}
