import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_structure/bussiness_logic/http_service/http_service.dart';
import 'package:fl_structure/bussiness_logic/models/response_wrapper.dart';
import 'package:fl_structure/utils/all_getter.dart';
import 'package:fl_structure/utils/helpers.dart';

abstract class AuthRepo {
  Future<void> getDeviceId();
}

class AuthRepoImp extends AuthRepo {
  @override
  Future<ResponseWrapper> sendMobileOtp({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await getHttpService.request(
        body: body,
        url: ApisEndpoints.sendMobileOtp,
      );
      if (response.statusCode == RepoResponseStatus.success) {
        final otp =  "";
        if (otp.isNotEmpty) {
          return getSuccessResponseWrapper(otp);
        } else {
          return getFailedResponseWrapper(someWentWrong);
        }
      } else {
        return getFailedResponseWrapper(response.statusMessage);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "sendMobileOtp",
      ));
    }
  }

  @override
  Future<void> getDeviceId() async {
    try {
      String deviceId="NO_IMPLEMENT" ;
      // String deviceId = await PlatformDeviceId.getDeviceId ?? "";
      await getLocalStorage.saveDeviceId(deviceId);
    } catch (e) {
      functionLog(msg: e.toString(), fun: 'getDeviceId');
    }
  }


}
