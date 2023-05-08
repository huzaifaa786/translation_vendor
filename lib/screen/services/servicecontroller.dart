import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/workinghour.dart';
import 'package:translation_vendor/values/string.dart';

class ServiceController extends GetxController {
  static ServiceController instance = Get.find();
  void addservice(List<WorkingHour>? workingHours) async {

print(workingHours!.length);
    for (var element in workingHours) {
      print(element.day);
      print(element.startTime);
      print(element.endTime);
      print(element.isFrozen);
      print('?????????');
    }
    LoadingHelper.show();
    var url = BASE_URL + 'service/store';
    GetStorage box = GetStorage();
    int id = box.read('vender_id');
   
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
