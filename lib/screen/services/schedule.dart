import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/static/schedule.dart';
import 'package:translation_vendor/static/star.button.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key, this.day});
  final String? day;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<WorkingHour> workingHours = [];
  void initState() {
        WorkingHour workingHour =
        WorkingHour(day: widget.day!, startTime: startTime, endTime: endTime);
    int index = workingHours.indexWhere((hour) => hour.day == widget.day!);
    if (index != 0) {
      // if (workingHours[index].startTime != '') {
      //   startTimeController.text = workingHours[index].startTime!;
      // }
      // if (workingHours[index].endTime != ''
      //) {
      //   endTimeController.text = workingHours[index].endTime!;
      // }
    }
    if (index < 7) {
      workingHours.add(workingHour);
    }
    super.initState();
 
  }

  save() {
  }

      String startTime = '';
    String endTime = '';
    bool isFrozen = false;
    final TextEditingController startTimeController = TextEditingController();
    final TextEditingController endTimeController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children: [
            Text(
              '$widget.day! Working Hours',
              style: TextStyle(
                fontFamily: 'Mazzard',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Scheduleinput(
              onpressed: () {
                DatePicker.showTimePicker(context, showTitleActions: true,
                    onChanged: (date) {
                  var time = DateFormat.Hm().format(date);
                  startTimeController.text = time.toString();
                  startTime = time.toString();
                  int index = workingHours
                      .indexWhere((hour) => hour.day == widget.day!);
                  workingHours[index].startTime = startTime;
                }, currentTime: DateTime.now());
              },
              hint: '9:00',
              controller: startTimeController,
              fontSize: 20.0,
            ),
            Text(
              'To',
              style: TextStyle(
                fontFamily: 'Mazzard',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Scheduleinput(
              onpressed: () {
                DatePicker.showTimePicker(context, showTitleActions: true,
                    onChanged: (date) {
                  var time = DateFormat.Hm().format(date);
                  endTimeController.text = time.toString();
                  endTime = time.toString();

                  int index = workingHours
                      .indexWhere((hour) => hour.day == widget.day!);
                  workingHours[index].endTime = endTime;
                }, 
                currentTime: DateTime.now());
              },
              hint: '17:00',
              fontSize: 20.0,
              controller: endTimeController,
            ),
            StarButton(
              isFrozen: isFrozen,
              onPressed: () {
                int index =
                    workingHours.indexWhere((hour) => hour.day == widget.day!);
                setState(() {
                  bool toggle = workingHours[index].isFrozen;
                  workingHours[index].isFrozen = !toggle;
                  
                });
              },
            )
          ],
        ),
        workingHours.any((hour) => hour.day == widget.day! && hour.isFrozen)
            ? Text('This day is frozen')
            : Text('This day is unfrozen'),
      ],
    );
  }
}
