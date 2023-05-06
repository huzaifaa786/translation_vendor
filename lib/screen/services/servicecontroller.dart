import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/values/string.dart';

class ServiceController extends GetxController {
  static ServiceController instance = Get.find();
  void addservice(List<WorkingHour> workingHours) async {
    LoadingHelper.show();
    var url = BASE_URL + 'service/store';
    GetStorage box = GetStorage();
    int id = box.read('vender_id');
    print('object');
    print(id);
    print(workingHours.toString());
    var data = {
      'vendor_id': id,
      'schedual': workingHours,
    };
    var response = await Api.execute(url: url, data: data);
    print(response);
    LoadingHelper.dismiss();
    return response;
  }
}
