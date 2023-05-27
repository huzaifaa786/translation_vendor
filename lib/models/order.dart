import 'package:translation_vendor/models/user.dart';
import 'package:translation_vendor/models/vendor.dart';

class Order {
  int? id;
  int? user_id;
  String? price;
  String? servicetype;
  String? documenttype;
  String? status;
  String? vendor_id;
  User? user;
  Vendor? vendor;
   //  Orderdoc? document;

  Order(order) {
    id = order['id'];
    price = order['price'];
    servicetype = order['servicetype'];
    documenttype = order['documenttype'];
    status = order['status'];
    vendor_id = order['vendor_id'];
    user_id = order['user_id'];
    user = User(order['user']);
    vendor = Vendor(order['vendor']);
    // document =  Orderdoc(order['document']) ;
  }
}
