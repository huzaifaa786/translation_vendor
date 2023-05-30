import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/order.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:translation_vendor/values/string.dart';

class StatusController extends GetxController {
  static StatusController instance = Get.find();
  orderaccept(Order order) async {
    LoadingHelper.show();
    var url = BASE_URL + 'order/accept';
    GetStorage box = GetStorage();

    String api_token = box.read('api_token');
    var data = {
      'id': order.id,
      'api_token': api_token,
    };
    print(data);
    var response = await Api.execute(url: url, data: data);

    if (!response['error']) {
      LoadingHelper.dismiss();
      order.status = "1";
      historyController.refresh();
      update();
    } else {
      LoadingHelper.dismiss();
    }
  }
   orderreject(Order order) async {
    LoadingHelper.show();
    var url = BASE_URL + 'order/reject';
    GetStorage box = GetStorage();

    String api_token = box.read('api_token');
    var data = {
      'id': order.id,
      'api_token': api_token,
    };
    print(data);
    var response = await Api.execute(url: url, data: data);

    if (!response['error']) {
      LoadingHelper.dismiss();
      order.status = "2";
      historyController.refresh();
      update();
    } else {
      LoadingHelper.dismiss();
    }
  }
     ordercomplete(Order order) async {
    LoadingHelper.show();
    var url = BASE_URL + 'order/reject';
    GetStorage box = GetStorage();

    String api_token = box.read('api_token');
    var data = {
      'id': order.id,
      'api_token': api_token,
    };
    print(data);
    var response = await Api.execute(url: url, data: data);

    if (!response['error']) {
      LoadingHelper.dismiss();
      order.status = "3";
      historyController.refresh();
      update();
    } else {
      LoadingHelper.dismiss();
    }
  }
}
