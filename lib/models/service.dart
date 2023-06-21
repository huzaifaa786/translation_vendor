import 'dart:convert';

import 'package:translation_vendor/models/documentlist.dart';
import 'package:translation_vendor/models/schedual.dart';

class VendorService {
  int? id;
  String? vendor_id;
  List<Documentlist>? urgent;
  List<Documentlist>? unurgent;
  List<Schedual>? schedual;
  String? inperson;
  String? audiovideo;
  String? onlineaudiovideoPrice;
  String? urgentprice;
  String? unurgentprice;
  String? radius;
  String? lat;
  String? lng;

  VendorService(service) {
    id = service['id'];
    vendor_id = service['vendor_id'];
    inperson = service['inperson'];
    audiovideo = service['audiovideo'];
    onlineaudiovideoPrice = service['onlineaudiovideo'];
    urgentprice = service['urgentprice'];
    unurgentprice = service['unurgentprice'];
    radius = service['radius'];
    lat = service['latitude'];
    lng = service['longitude'];
    urgent = documentlist(jsonDecode(service['urgent']));
    unurgent = undocumentlist(jsonDecode(service['unurgent']));
    schedual = schedulelist(jsonDecode(service['schedual']));
  }

  List<Schedual> schedulelist(List<dynamic> scheduleData) {
    final List<Schedual> schedualList = [];

    for (var i = 0; i < scheduleData.length; i++) {
      schedualList.add(Schedual(scheduleData[i]));
    }
    return schedualList;
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
