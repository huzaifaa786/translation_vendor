import 'package:flutter/material.dart';
class WorkingHour {
  String day;
  String? startTime;
   String? endTime;
  bool isFrozen;

  WorkingHour({
    required this.day,
    required this.startTime,
    required this.endTime,
    this.isFrozen = false,
  });
}