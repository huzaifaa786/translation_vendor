import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/sale_model.dart';
import 'package:translation_vendor/values/string.dart';
import 'package:get_storage/get_storage.dart';

class SaleController extends GetxController {
  static SaleController instance = Get.find();
  CalendarFormat format = CalendarFormat.month;
  var format1 = 'month';
  DateTime Ourdate = DateTime.now();
  DateTime today = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;
  int price = 0;
  List<SaleModal> orders = [];
  List<SaleModal> searchedorders = [];

  void onFormatChanged(DateTime date) {
    today = date;
    Ourdate = date;
    daySale(today);
    update();
  }

  void onDaySelected(DateTime day, DateTime foucsedDay) async {
    today = day;
    Ourdate = day;
    rangeStart = null;
    rangeEnd = null;
    daySale(today);
    update();
  }

  void onRangeSelected(start, end, focusedDay) {
    rangeStart = start;
    rangeEnd = end;
    today = focusedDay;
    Ourdate = focusedDay;
    if (end == null) {
      daySale(today);
    } else {
      SaleByselctingRange(start, end);
    }
    update();
  }

  // getSlaes() async {
  //   GetStorage box = GetStorage();
  //   String api_token = box.read('api_token');
  //   print(api_token);
  //   LoadingHelper.show();
  //   var url = BASE_URL + 'vendor/sale';
  //   var data;
  //   data = {api_token};
  //   (data);
  //   var response = await Api.execute(
  //     url: url,
  //     data: data,
  //   );
  //   LoadingHelper.dismiss();
  //   return response;
  // }

  getcompleteorder() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendor/sale';
    var data;
    GetStorage box = GetStorage();
    data = {'api_token': box.read('api_token')};
    var response = await Api.execute(
      url: url,
      data: data,
    );
    LoadingHelper.dismiss();
    for (var order in response['day']) {
      orders.add(SaleModal(order));
    }
    searchedorders = orders;
    print(orders);
    update();
    // return orders;
  }

  daySale(DateTime day) {
    List<SaleModal> orderlist = searchedorders
        .where((i) =>
            i.date!.toLocal().toString().split(' ')[0] ==
            day.toLocal().toString().split(' ')[0])
        .toList();
    searchedorders = orders;
    print(orderlist);
    price = 0;
    for (var i = 0; i < orderlist.length; i++) {
      print(orderlist[i].price!);
      price += orderlist[i].price!;
    }
    orderlist = [];
    print(orderlist);
    update();
  }

  SaleByselctingRange(DateTime startDate, DateTime endDate) {
    List<SaleModal> orderlist = searchedorders
        .where((i) =>
            i.date!.toLocal().isAfter(startDate.subtract(Duration(days: 1))) &&
            i.date!.toLocal().isBefore(endDate.add(Duration(days: 1))))
        .toList();

    searchedorders = orders;
    print(orderlist.length);
    print(orderlist[0].price);
    price = 0;
    for (var i = 0; i < orderlist.length; i++) {
      print(orderlist[i].price!);
      price += orderlist[i].price!;
    }
    orderlist = [];

    print(orderlist);
    update();
  }

  clearVariable() {
    today = DateTime.now();
    Ourdate = DateTime.now();
    rangeStart = null;
    rangeEnd = null;
    orders = [];
    searchedorders = [];
    update();
  }
}
