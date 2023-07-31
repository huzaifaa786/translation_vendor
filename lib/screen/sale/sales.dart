import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/screen/sale/salecontroller.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/controllers.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key, required this.id});
  final String? id;

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  getSale() async {
    await saleController.getcompleteorder();
    saleController.daySale(saleController.today);
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getSale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<SaleController>(
        builder: (controller) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TitleTopbar(
                    text: 'Sale',
                    ontap: () {
                      Get.back();
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
                                    isSameDay(day, saleController.today),
                                firstDay: DateTime.utc(2023, 1, 1),
                                lastDay: DateTime.now(),
                                focusedDay: saleController.today,
                                rangeStartDay: saleController.rangeStart,
                                rangeEndDay: saleController.rangeEnd,
                                rangeSelectionMode: RangeSelectionMode.enforced,
                                // onDaySelected: saleController.onDaySelected,
                                onRangeSelected: saleController.onRangeSelected,
                                calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.5),
                                      shape: BoxShape.circle),
                                  selectedDecoration: BoxDecoration(
                                      color: mainColor, shape: BoxShape.circle),
                                  markerDecoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  rangeStartDecoration: BoxDecoration(
                                      color: mainColor, shape: BoxShape.circle),
                                  rangeEndDecoration: BoxDecoration(
                                      color: mainColor, shape: BoxShape.circle),
                                  rangeHighlightColor: mainColor.withOpacity(0.5),
                                  isTodayHighlighted: true,
                                  outsideDaysVisible: false,
                                ),
                                availableCalendarFormats: const {
                                  CalendarFormat.month: 'Month',
                                  // CalendarFormat.week: 'Week',
                                },
                                onPageChanged: saleController.onFormatChanged,
                                calendarFormat: saleController.format,
                                onFormatChanged: (CalendarFormat _format) {
                                  setState(() {
                                    // _format == CalendarFormat.week
                                    //     ? size = 0.59
                                    //     : size = 0.319;
                                    _format == CalendarFormat.week
                                        ? saleController.format1 = 'week'
                                        : saleController.format1 = 'month';
                                    saleController.format = _format;
                                    // saleController.getSlaes();
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
                          Text(saleController.price.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              Text(' AED',
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
        ),
      )),
    );
  }
}
