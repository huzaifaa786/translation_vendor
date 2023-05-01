import 'package:flutter/material.dart';
class WorkingHour {
  String day;
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool isFrozen;

  WorkingHour({
    required this.day,
    required this.startTime,
    required this.endTime,
    this.isFrozen = false,
  });
}