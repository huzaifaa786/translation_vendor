import 'package:get/get_connect/http/src/utils/utils.dart';

class OrderDocument {
  int? id;
  String? documenttype;
  String? discription;
  String? file;
 

  OrderDocument(orderdocument) {
    id = orderdocument['id'];
    documenttype = orderdocument['documenttype'];
    file = orderdocument['file']; 
    discription = orderdocument['description']?? '';

  }
}
