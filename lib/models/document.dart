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
