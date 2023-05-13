class Documentlist {
  String day;
  String? minpage;
  String? maxpage;
   String? price;

  Documentlist({
    required this.day,
    required this.minpage,
    required this.maxpage,
     required this.price,
   
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'price': price,
      'minpage': minpage,
      'maxpage': maxpage,
    };
  }
}