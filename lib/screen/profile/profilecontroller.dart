import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/values/string.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  XFile? profileimage = XFile('');

  Future<void> profileImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileimage = image;
      update();
    }
  }

  void editprofile() async {
    LoadingHelper.show();

    var url = BASE_URL + 'vendor/update';
    GetStorage box = GetStorage();
    int id = box.read('vender_id');
    String? api_token = box.read('api_token');
    print('objectdfdgfdg');

    var data = {
      'vendor_id': id,
      'api_token': api_token,
      'profilepic': profileimage
    };
    var response = await Api.execute(url: url, data: data);
    print(response);
    LoadingHelper.dismiss();
    return response;
  }
}
