import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/models/notification.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/values/string.dart';

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();

  List<Notificationn> notifications = [];
  getnoti() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendor/notification';
    GetStorage box = GetStorage();

    String api_token = box.read('api_token');
    String vendor_id = box.read('vendor_id');
    var data = {
      'api_token': api_token,
      'id': vendor_id,
    };
    print(data);
    var response = await Api.execute(url: url, data: data);

    if (!response['error']) {
      notifications = [];
      for (var van in response['notifications']) {
        notifications.add(
          Notificationn(van),
        );
      }
      print(response);
       LoadingHelper.dismiss();
    } else {
      print(response['error']);
     LoadingHelper.dismiss();
    }
  }

  readnotifications() async {
    LoadingHelper.show();
    print('object');
    var url = BASE_URL + 'notification/read';
    GetStorage box = GetStorage();

    String api_token = box.read('api_token');
    var data;
    data = {'api_token': api_token};

    await Api.execute(url: url, data: data);
    LoadingHelper.dismiss();
  }

  String convertDateFormat(String inputDate) {
    List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = weekdays[dateTime.weekday - 1] +
        ', ' +
        DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
