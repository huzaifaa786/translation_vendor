import 'package:forex_conversion/forex_conversion.dart';
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
  double price = 0.0;
  List<SaleModal> orders = [];
  List<SaleModal> searchedorders = [];

  void onFormatChanged(DateTime date) {
    today = date;
    Ourdate = date;
    daySale(today);
    update();
  }

  void onDaySelected(DateTime day, DateTime focusedDay) async {
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
      SaleBySelectingRange(start, end);
    }
    update();
  }

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
    print('dfdfdfdfdf3333');
    print(orders);
    update();
  }

  daySale(DateTime day) async {
    List<SaleModal> orderlist = searchedorders
        .where((i) =>
            i.date!.toLocal().toString().split(' ')[0] ==
            day.toLocal().toString().split(' ')[0])
        .toList();
    searchedorders = orders;
    print(orderlist);
    price = 0.0;
    for (var i = 0; i < orderlist.length; i++) {
      print(orderlist[i].price!);
      String convertedPrice = await changePrice(
          orderlist[i].price!.toString(), orderlist[i].currency!);
      price += double.parse(convertedPrice);
    }
    orderlist = [];
    print(orderlist);
    update();
  }

  SaleBySelectingRange(DateTime startDate, DateTime endDate) async {
    List<SaleModal> orderlist = searchedorders
        .where((i) =>
            i.date!.toLocal().isAfter(startDate.subtract(Duration(days: 1))) &&
            i.date!.toLocal().isBefore(endDate.add(Duration(days: 1))))
        .toList();

    searchedorders = orders;
    print(orderlist.length);

    price = 0.0;
    for (var i = 0; i < orderlist.length; i++) {
      print(orderlist[i].price!);
      String convertedPrice = await changePrice(
          orderlist[i].price!.toString(), orderlist[i].currency!);
      price += double.parse(convertedPrice);
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

  Future<String> changePrice(String price, String currency) async {
    final fx = Forex();
    double priceConverted = 0;
    await fx
        .getCurrencyConverted(
      sourceCurrency: currency,
      destinationCurrency: "USD",
      sourceAmount: double.parse(price),
    )
        .then((value) {
      priceConverted = value;
    });
    return priceConverted.toStringAsFixed(2);
  }
}
