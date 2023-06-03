class Documentlist {
  String day;
  String? minpage;
  String? maxpage;
   String? price;

  Documentlist({
    required this.day,
    required this.minpage,
    required this.maxpage,
   
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'minpage': minpage,
      'maxpage': maxpage,
    };
  }
}