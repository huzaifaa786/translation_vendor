import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:translation_vendor/values/colors.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  CalendarFormat format = CalendarFormat.month;
  var format1 = 'month';
  DateTime Ourdate = DateTime.now();
  // DateTime selectedDay = DateTime.now();
  // DateTime focusedDay = DateTime.now();
  DateTime today = DateTime.now();
  void onFormatChanged(DateTime date) {
    today = date;
    Ourdate = date;
  }

  void _onDaySelected(DateTime day, DateTime foucsedDay) async {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TitleTopbar(
                  text: 'Sale',
                  ontap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TableCalendar(
                              selectedDayPredicate: (day) =>
                                  isSameDay(day, today),
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.now(),
                              focusedDay: today,
                              onDaySelected: _onDaySelected,
                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.6),
                                    shape: BoxShape.circle),
                                selectedDecoration: BoxDecoration(
                                    color: mainColor, shape: BoxShape.circle),
                                markerDecoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                isTodayHighlighted: true,
                                outsideDaysVisible: false,
                              ),
                              availableCalendarFormats: const {
                                CalendarFormat.month: 'Month',
                                CalendarFormat.week: 'Week',
                              },
                              onPageChanged: onFormatChanged,
                              calendarFormat: format,
                              onFormatChanged: (CalendarFormat _format) {
                                setState(() {
                                  format = _format;
                                });
                              },
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              daysOfWeekVisible: true,
                            ),

                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * size,
                            //   child: ListView.builder(
                            //       itemCount: searchedorders.length,
                            //       itemBuilder: (BuildContext context, int index) {
                            //         return TodaySale(
                            //           name: searchedorders[index].user!,
                            //           type: searchedorders[index].cartype,
                            //           price: searchedorders[index].price,
                            //           imageicon: 'assets/images/car_order.svg',
                            //         );
                            //       }),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 23),
                  child: Text('Total Sales',
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10, left: 10, bottom: 23),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1500',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Text('AED',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
