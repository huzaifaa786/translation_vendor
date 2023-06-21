import 'dart:convert';
class Schedual {
  String? day;
  String? startTime;
  String? endTime;
  bool? isFrozen;

  Schedual(schedual){
    day = schedual['day'];
    startTime = schedual['startTime'];
    endTime = schedual['endTime'];
    isFrozen = schedual['isFrozen'];
  }
}