import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/static/schedule.dart';
import 'package:translation_vendor/static/star.button.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class Schedule extends StatefulWidget {
 Schedule({super.key, this.day, this.startTime = '09:00',this.endTime = '17:00'});
  final String? day;
  String? startTime;
  String? endTime;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  void initState() {
    WorkingHour workingHour =
        WorkingHour(day: widget.day!, startTime:widget.startTime, endTime: widget.endTime);
    int index = serviceController.workingHours
        .indexWhere((hour) => hour.day == widget.day!);
    if (index != 0) {}
    if (index < 7) {
      serviceController.workingHours.add(workingHour);
    }
    startTimeController.text = widget.startTime!;
    endTimeController.text = widget.endTime!;
    super.initState();
  }

  save() {}

  // String startTime = '09:00';
  // String endTime = '17:00';
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
              widget.day! + ' Working Hours',
              style: TextStyle(
                fontFamily: 'Poppins',
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
                DatePicker.showTimePicker(context,
                    showTitleActions: true,
                    showSecondsColumn: false, onChanged: (date) {
                  var time = DateFormat.Hm().format(date);
                  startTimeController.text = time.toString();
                  widget.startTime = time.toString();
                  int index = serviceController.workingHours
                      .indexWhere((hour) => hour.day == widget.day!);
                  serviceController.workingHours[index].startTime = widget.startTime;
                }, currentTime: DateTime.now());
              },
              hint: '9:00',
              controller: startTimeController,
              fontSize: 18.0,
            ),
            Text(
              'To',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Scheduleinput(
              onpressed: () {
                DatePicker.showTimePicker(context,
                    showTitleActions: true,
                    showSecondsColumn: false, onChanged: (date) {
                  var time = DateFormat.Hm().format(date);
                  endTimeController.text = time.toString();
                  widget.endTime = time.toString();

                  int index = serviceController.workingHours
                      .indexWhere((hour) => hour.day == widget.day!);
                  serviceController.workingHours[index].endTime = widget.endTime;
                }, currentTime: DateTime.now());
              },
              hint: '17:00',
              fontSize: 18.0,
              controller: endTimeController,
            ),
            StarButton(
              isFrozen: isFrozen,
              onPressed: () {
                int i = serviceController.workingHours
                    .indexWhere((hour) => hour.day == widget.day!);
                Alert(
                  style: AlertStyle(
                    titleStyle: TextStyle(fontSize: 25),
                  ),
                  context: context,
                  title: serviceController.workingHours[i].isFrozen
                      ? "Are you sure to unfreeze this day"
                      : "Are you sure to freeze this day",
                  buttons: [
                    DialogButton(
                      height: 60,
                      radius: BorderRadius.circular(12),
                      child: Text(
                        "yes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          bool toggle =
                              serviceController.workingHours[i].isFrozen;
                          serviceController.workingHours[i].isFrozen = !toggle;
                        });
                        Get.back();
                      },
                      color: mainColor,
                    ),
                    DialogButton(
                      height: 60,
                      radius: BorderRadius.circular(12),
                      border: Border.all(
                        color: mainColor,
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(color: mainColor, fontSize: 20),
                      ),
                      onPressed: () => Get.back(),
                      color: White,
                    ),
                  ],
                ).show();
              },
            )
          ],
        ),
        serviceController.workingHours
                .any((hour) => hour.day == widget.day! && hour.isFrozen)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text('This day is frozen'),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text('This day is unfrozen'),
              ),
      ],
    );
  }
}
