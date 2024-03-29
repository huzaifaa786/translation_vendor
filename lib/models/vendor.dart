import 'dart:convert';

import 'package:translation_vendor/models/service.dart';

class Vendor {
  String? id;
  String? name;
  String? username;
  String? apiToken;
  String? dob;
  String? passport;
  String? number;
  String? profilepic;
  String? certificate;
  String? certifcate_name;
  String? status;
  String? aboutEng;
  String? profile;
  String? aboutArabic;
  int? online;
  List<dynamic>? language;
  VendorService? service;

  Vendor(vendor) {
    id = vendor['id'];
    name = vendor['name'];
    username = vendor['username'];
    apiToken = vendor['api_token'] ?? '';
    dob = vendor['DOB'];
    profile = vendor['profile'];
    passport = vendor['passport'];
    number = vendor['number'] ?? '';
    profilepic = vendor['profilepic'] ?? '';
    certificate = vendor['certificate'] ?? '';
    certifcate_name = vendor['certifcate_name'] ?? '';
    status = vendor['status'];
    aboutEng = vendor['about(Eng)'] ?? '';
    aboutArabic = vendor['about(arabic)'] ?? '';
    online = vendor['online'];
    language = jsonDecode(vendor['language']);
    service =
        vendor['service'] != null ? VendorService(vendor['service']) : null;
  }
}
