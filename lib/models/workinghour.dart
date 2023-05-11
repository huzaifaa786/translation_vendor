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

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'isFrozen': isFrozen,
    };
  }
}