import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/order.dart';
import 'package:translation_vendor/values/string.dart';

class HistoryController extends GetxController {
  static HistoryController instance = Get.find();

  List<Order> orders = [];
  getorder() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendor/order';
    GetStorage box = GetStorage();

    String api_token = box.read('api_token');
    var data = {
      'api_token': api_token,
   
    };
   print(data);
    var response = await Api.execute(url: url, data: data);
    print(response.toString());
    if (!response['error']) {
      List<Order> order = <Order>[];
      for (var van in response['order']) {
        order.add(Order(van));
      }
      orders = order;
      LoadingHelper.dismiss();
      print(orders);
      update();
    } else {
      print(response['error']);
       LoadingHelper.dismiss();
    }
  }

}