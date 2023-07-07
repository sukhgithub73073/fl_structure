import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_structure/bussiness_logic/http_service/http_service.dart';
import 'package:fl_structure/bussiness_logic/local_storage/local_storage.dart';
import 'package:fl_structure/bussiness_logic/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';
/// general getter
/// ///
/// ///

DateTime get now => DateTime.now();

String get someWentWrong => "Some Went Wrong";

String get exitMsg => "Are you sure you want to exit ?";

String get noDataFound => "No Data Found";

String get doneToast => "Successfully";

String get communityWatcherDoc =>
    "http://communitywatcher.csdevhub.com/public/uploads/lagal.html";

LocalStorage get getLocalStorage => GetIt.I.get<LocalStorage>();

HttpService get getHttpService => GetIt.I.get<HttpService>();


AuthRepo get getAuthRepo => GetIt.I.get<AuthRepo>();




String get getToken => GetIt.I.get<LocalStorage>().getToken();

String get getDeviceId => GetIt.I.get<LocalStorage>().getDeviceId();


Future<String> getFcmToken() async {
   return "${await FirebaseMessaging.instance.getToken()}";
}
