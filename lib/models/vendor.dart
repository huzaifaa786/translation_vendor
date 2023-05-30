import 'dart:convert';

class Vendor {
  int? id;
  String? name;
  String? username;
  String? apiToken;
  String? dob;
  String? passport;
  String? number;
  String? profilepic;
  String? certificate;
  String? status;
  String? aboutEng;
  String? aboutArabic;
  int? online;
  List<dynamic>? language;

  Vendor(vendor) {
    id = vendor['id'];
    name = vendor['name'];
    username = vendor['username'];
    apiToken = vendor['api_token'] ?? '';
    dob = vendor['DOB'];
    passport = vendor['passport'];
    number = vendor['number'] ?? '';
    profilepic = vendor['profilepic'] ?? '';
    certificate = vendor['certificate'] ?? '';
    status = vendor['status'];
    aboutEng = vendor['about(Eng)'] ?? '';
    aboutArabic = vendor['about(arabic)'] ?? '';
    online = vendor['online'];
    language = jsonDecode(vendor['language']);
  }
}
