import 'dart:convert';

import 'package:fl_structure/utils/helpers.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveConst {
  static const String contact = 'contact';
  static const String selectedContact = 'selectedContact';
  static const String userData = 'userData';
  static const String profileData = 'profileData';
  static const String token = 'token';
  static const String deviceId = 'deviceId';
  static const String deviceInfoBox = 'deviceInfoBox';
}

abstract class LocalStorage {
  Future<bool> saveToken(String token);
  Future<bool> saveDeviceId(String token);
  String getToken();
  String getDeviceId();
  Future<void> clearAllBox();
}

class HiveStorageImp extends LocalStorage {
  final Box contactBox;
  final Box selectedContactBox;
  final Box userBox;
  final Box tokenBox;
  final Box deviceInfoBox;

  HiveStorageImp({
    required this.deviceInfoBox,
    required this.contactBox,
    required this.selectedContactBox,
    required this.tokenBox,
    required this.userBox,
  });

  static Future<LocalStorage> init() async => HiveStorageImp(
        contactBox: await Hive.openBox(HiveConst.contact),
    selectedContactBox: await Hive.openBox(HiveConst.selectedContact),
        userBox: await Hive.openBox(HiveConst.userData),
        deviceInfoBox: await Hive.openBox(HiveConst.deviceInfoBox),
        tokenBox: await Hive.openBox(HiveConst.token),
      );

  @override
  Future<bool> saveToken(String token) async {
    await tokenBox.put(HiveConst.token, token);
    printLog("==============saveToken==========$token");

    return true;
  }

  @override
  Future<bool> saveDeviceId(String token) async {
    await deviceInfoBox.put(HiveConst.deviceId, token);
    printLog("==============saveDeviceId========== $token");

    return true;
  }

  @override
  String getToken() {
    final token = tokenBox.get(HiveConst.token);
    printLog("=======getToken=========>");
    return token ?? "";
  }

  @override
  String getDeviceId() {
    final token = deviceInfoBox.get(HiveConst.deviceId);
    printLog("==============getDeviceId==========");
    return token ?? "";
  }




  @override
  Future<void> clearAllBox() async {
    await userBox.clear();
    await contactBox.clear();
    await selectedContactBox.clear();
    await tokenBox.clear();
    // await
  }
}
