import 'dart:convert';
import 'package:translation_vendor/models/documentlist.dart';
import 'package:translation_vendor/models/workinghour.dart';

class VendorService {
  int? id;
  String? vendor_id;
  List<Documentlist>? urgent;
  List<Documentlist>? unurgent;
  List<WorkingHour>? schedule;
  String? inperson;
  String? audiovideo;
  String? onlineaudiovideoPrice;
  String? urgentprice;
  String? unurgentprice;
  double? radius;
  double? lat;
  double? lng;
  bool? isInperson;
  bool? isAudioVideo;
  bool? isdocument;

  VendorService(service) {
    id = service['id'];
    vendor_id = service['vendor_id'];
    inperson = service['inperson'];
    audiovideo = service['audiovideo'];
    onlineaudiovideoPrice = service['onlineaudiovideo'];
    urgentprice = service['urgentprice'];
    unurgentprice = service['unurgentprice'];
    radius = service['radius'] != null
        ? double.parse(service['radius'].toString())
        : 0.0;
    lat = service['latitude'] != null
        ? double.parse(service['latitude'].toString())
        : 0;
    lng = service['longitude'] != null
        ? double.parse(service['longitude'].toString())
        : 0;
    urgent = service['urgent'] != []
        ? documentlist(jsonDecode(service['urgent']))
        : [];
    unurgent = service['unurgent'] != []
        ? undocumentlist(jsonDecode(service['unurgent']))
        : [];
    schedule = schedulelist(jsonDecode(service['schedual']));
  }

  List<WorkingHour> schedulelist(List<dynamic> scheduleData) {
    final List<WorkingHour> scheduleList = []; // Updated variable name

    for (var i = 0; i < scheduleData.length; i++) {
      scheduleList.add(WorkingHour(
        day: scheduleData[i]['day'],
        startTime: scheduleData[i]['startTime'],
        endTime: scheduleData[i]['endTime'],
        isFrozen: scheduleData[i]['isFrozen'],
      ));
    }
    return scheduleList; // Updated variable name
  }

  List<Documentlist> documentlist(List<dynamic> urgentData) {
    final List<Documentlist> documentlist = [];

    for (var i = 0; i < urgentData.length; i++) {
      final Map<String, dynamic> jsonData = urgentData[i];
      final Documentlist document = Documentlist(
        day: jsonData['day'],
        minpage: jsonData['minpage'],
        maxpage: jsonData['maxpage'],
      );
      documentlist.add(document);
    }
    return documentlist;
  }

  List<Documentlist> undocumentlist(List<dynamic> unurgentData) {
    final List<Documentlist> undocumentlist = [];

    for (var i = 0; i < unurgentData.length; i++) {
      final Map<String, dynamic> jsonData = unurgentData[i];
      final Documentlist document = Documentlist(
        day: jsonData['day'],
        minpage: jsonData['minpage'],
        maxpage: jsonData['maxpage'],
      );
      undocumentlist.add(document);
    }
    return undocumentlist;
  }
}
