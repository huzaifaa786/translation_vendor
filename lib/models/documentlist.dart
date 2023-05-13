class Documentlist {
  String day;
  String? price;
  String? page;
   String? perpage;

  Documentlist({
    required this.day,
    required this.price,
    required this.page,
     required this.perpage,
   
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'price': price,
      'page': page,
      'perpage': perpage,
    };
  }
}