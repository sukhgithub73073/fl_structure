import 'dart:async';

import 'package:fl_structure/bussiness_logic/http_service/http_service.dart';
import 'package:fl_structure/bussiness_logic/local_storage/local_storage.dart';
import 'package:fl_structure/bussiness_logic/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


typedef AppRunner = FutureOr<void> Function();

class AppInjector {
  static Future<void> init({
    required AppRunner appRunner,
  }) async {
    await _initDependencies();
    appRunner();
  }

  static Future<void> _initDependencies() async {
    await GetIt.I.allReady();
    final storage = await HiveStorageImp.init();
    GetIt.I.registerLazySingleton<LocalStorage>(() => storage);
    GetIt.I.registerSingleton<HttpService>(HttpService());
    GetIt.I.registerSingleton<AuthRepo>(AuthRepoImp());
    GetIt.I.registerSingleton<GlobalKey<NavigatorState>>(GlobalKey<NavigatorState>());

  }
}
