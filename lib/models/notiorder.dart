import 'package:translation_vendor/models/user.dart';
import 'package:translation_vendor/models/vendor.dart';

class Orderr {
  int? id;
  int? user_id;
  int? price;
  int? duration;
  int? vendor_id;
  String? starttime;
  String? endtime;
  String? date;
  String? servicetype;
  String? scheduletype;
  String? status;

  // OrderDocument? document;


  Orderr(orderr) {
    id = orderr['id'];
    price = orderr['price'];
    servicetype = orderr['servicetype'];
    scheduletype = orderr['scheduletype'];
    duration = orderr['duration'];
    starttime = orderr['starttime'];
    endtime = orderr['endtime'];
    date = orderr['date'];
    status = orderr['status'];
    vendor_id = orderr['vendor_id'];
    user_id = orderr['user_id'];

    // document = OrderDocument(order['orderdocument']);
  
  }
}
