import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:translation_vendor/api/api.dart';
import 'package:translation_vendor/helper/loading.dart';
import 'package:translation_vendor/models/contact.dart';
import 'package:translation_vendor/models/msg.dart';
import 'package:translation_vendor/values/string.dart';

class ChatController extends GetxController {
  static ChatController instance = Get.find();
  RxList<Msg> massages = <Msg>[].obs;

  TextEditingController massagecontroller = TextEditingController();
  String? activeUserId;
  List<Contact> contacts = <Contact>[];
  List<Contact> scontacts = <Contact>[];
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  main() {
    var intValue = Random().nextInt(10);

    return intValue;
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    LoadingHelper.show();
    var url = BASE_URL + 'chat/auth';
    var data;
    GetStorage box = GetStorage();

    data = {
      'api_token': box.read('api_token')!,
      "socket_id": socketId,
      "channel_name": channelName,
    };

    var response = await Api.execute(url: url, data: data);
    LoadingHelper.dismiss();
    return response;
  }

  initPusher(String? id) async {
    try {
      await pusher.init(
          apiKey: "4341ec79756753dcfb7b",
          cluster: "ap2",
          onConnectionStateChange: onConnectionStateChange,
          onError: onError,
          onSubscriptionSucceeded: onSubscriptionSucceeded,
          onEvent: onEvent,
          onSubscriptionError: onSubscriptionError,
          onDecryptionFailure: onDecryptionFailure,
          onMemberAdded: onMemberAdded,
          onMemberRemoved: onMemberRemoved,
          onAuthorizer: onAuthorizer);
      GetStorage box = GetStorage();
      String user_id = box.read('user_id').toString();

      await pusher.subscribe(channelName: "private-chatify.${user_id}");
      await pusher.connect();
      activeUserId = id;
    } catch (e) {
      print("error in initialization: $e");
    }
    print(pusher.connectionState);
  }

  getContacts() async {
    print('0');
    LoadingHelper.show();
    var url = BASE_URL + 'getContacts';
    var data;
    GetStorage box = GetStorage();
    data = {
      'api_token': box.read('api_token')!,
    };
    var response = await Api.execute(url: url, data: data);
    contacts = <Contact>[];
    for (var contact in response['contacts']) {
      contacts.add(Contact(contact));
    }
    scontacts = contacts;

    update();
    LoadingHelper.dismiss();
  }

  void searchContact(String query) {
    if (query == '') {
      scontacts = contacts;
      update();
    } else {
      scontacts = contacts
          .where((o) => o.username!
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      update();
    }
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName member: $member");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName member: $member");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void onEvent(PusherEvent event) {
    var response = jsonDecode(event.data);
    response['message']['body'] = response['message']['message'];
    response['message']['created_at'] = response['message']['created_at'];

    massages.add(Msg(response['message']));
    update();
  }

  void onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  ClearVariable() {
    massagecontroller.clear();

    update();
  }

  File? file;
  Future<void> picksinglefile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'zip',
        'rar',
        'txt',
        'pdf',
        'png',
        'jpg',
        'jpeg',
        'gif'
      ],
    );
    if (result != null) {
      file = await File(result.files.single.path!);
      sendMassage();
    } else {
      // User canceled the picker
    }
  }

  sendMassage() async {
    var url = BASE_URL + 'sendMessage';
    var data;
    GetStorage box = GetStorage();

    String fileName =
        file?.path.split('/').last ?? ''; // Get the file name if it exists
    print(fileName);

    data = dio.FormData.fromMap({
      'api_token': box.read('api_token')!,
      'message': massagecontroller.text.toString(),
      'type': 'user',
      'temporaryMsgId': main(),
      'id': activeUserId,
    });

    if (file != null) {
      data.files.add(
        MapEntry(
          'file',
          await dio.MultipartFile.fromFile(file!.path, filename: fileName),
        ),
      );
    }

    var response = await Api.execute(url: url, data: data);

    response['message']['body'] = response['message']['message'];
    response['message']['created_at'] = response['message']['created_at'];

    massages.add(Msg(response['message']));

    update();
    ClearVariable();
  }

  fetchmassage(id) async {
    LoadingHelper.show();
    var url = BASE_URL + 'fetchMessages';
    var data;
    GetStorage box = GetStorage();
    print(box.read('api_token'));
    data = {
      'api_token': box.read('api_token')!,
      'id': id,
    };
    var response = await Api.execute(url: url, data: data);

    massages = <Msg>[].obs;
    for (var van in response['messages']) {
      print(van['attachment']);
      massages.add(Msg(van));
      print(massages.last.file_name);

      update();
    }
  }

  makeseen(id) async {
    LoadingHelper.show();
    var url = BASE_URL + 'makeSeen';
    var data;
    GetStorage box = GetStorage();
    print(box.read('api_token'));
    data = {
      'api_token': box.read('api_token'),
      'id': id,
    };
    var response = await Api.execute(url: url, data: data);
    print(response);
    LoadingHelper.dismiss();
  }

  String? unseen;
  unseenchat() async {
    LoadingHelper.show();
    var url = BASE_URL + 'unseen/all';
    var data;
    GetStorage box = GetStorage();
    data = {
      'api_token': box.read('api_token'),
    };
    var response = await Api.execute(url: url, data: data);
    unseen = response['unseen'].toString();
    update();
    LoadingHelper.dismiss();
  }
}
