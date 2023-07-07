import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_structure/bussiness_logic/http_service/http_service.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:flutter/services.dart';

class ResponseWrapper {
  int? status;
  String? message;
  dynamic response;

  ResponseWrapper({
    this.status,
    this.message,
    this.response,
  });

  ResponseWrapper.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    response = json["response"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    data["response"] = response;
    return data;
  }
}

abstract class RepoResponseStatus {
  static const int error = 500;
  static const int success = 200;
  static const int authentication = 401;
  static const int subscriptionExpire = 0;
  static const int platformException = 400;
  static const int notFoundException = 404;
  static const int serverIsTemporarilyUnable = 503;
}

dynamic responseChecker(Response<dynamic> response) {
  return (response.data.runtimeType == String)
      ? (jsonDecode(response.data))
      : (response.data);
}

ResponseWrapper getSuccessResponseWrapper(dynamic response) => ResponseWrapper(
      status: RepoResponseStatus.success,
      response: response,
    );

ResponseWrapper getFailedResponseWrapper(dynamic e, {dynamic response}) =>
    ResponseWrapper(
      status: RepoResponseStatus.error,
      message: e.toString(),
      response: response ?? false,
    );

String exceptionHandler({
  required Object e,
  required String functionName,
}) {
  printLog(e);
  if (e is AuthenticationException) {
    blocLog(
      msg: e.message ?? e.toString(),
      bloc: "AuthenticationException in =>$functionName",
    );
    return e.message ?? e.toString();
  } else if (e is PlatformException) {
    blocLog(
      msg: e.message ?? e.toString(),
      bloc: "PlatformException in ==>$functionName",
    );
    return e.message ?? e.toString();
  } else if (e is ConnectingTimedOut) {
    blocLog(
      msg: e.message ?? e.toString(),
      bloc: "ConnectingTimedOut in ==>$functionName",
    );
    return e.message ?? e.toString();
  } else if (e is SubscriptionException) {
    blocLog(
      msg: e.message ?? e.toString(),
      bloc: "SubscriptionException in ==>$functionName",
    );
    return e.message ?? e.toString();
  } else if (e is SocketException) {
    blocLog(
      msg: e.message,
      bloc: "SocketException in ==>$functionName",
    );
    return e.message;
  } else if (e.toString().toLowerCase().contains("SocketException".toLowerCase())) {
    blocLog(
      msg: "Connection Timeout, Please Try Again",
      bloc: "SocketException ==>$functionName",
    );
    return "Connection Timeout, Please Try Again";
  } else {
    printLog("Unknown Exception ");
    blocLog(
      msg: e.toString(),
      bloc: functionName,
    );
    return e.toString();
  }
}

class GeneralModel {
  String? message;
  bool? status;
  dynamic data;
  int? statusCode;

  GeneralModel(
      {this.message, this.status, this.data, this.statusCode});

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
        message: json['message'] as String?,
        statusCode: json['statusCode'] as int?,
        status: json['status'] as bool?,
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'status': status,
        'data': data,
        'statusCode': statusCode,
      };
}

String getHandleFirebaseError({
  required String error,
  required String functionName,
}) {
  functionLog(msg: error, fun: "getHandleFirebaseError");
  if (error == "invalid-phone-number") {
    functionLog(
      msg: "Invalid phone number please enter valid phone number",
      fun: functionName,
    );
    return "Invalid phone number please enter valid phone number";
  } else if (error == "invalid-verification-code") {
    functionLog(
      msg: "invalid code",
      fun: functionName,
    );
    return "invalid code";
  } else if (error == "too-many-requests") {
    functionLog(
      msg: "Too Many Requests.Please try another number",
      fun: functionName,
    );
    return "Too Many Requests.Please try after 24 hours";
  } else if (error == "ERROR_EMAIL_ALREADY_IN_USE" ||
      error == "account-exists-with-different-credential" ||
      error == "email-already-in-use") {
    functionLog(
      msg: "Email already used. Go to login page.",
      fun: functionName,
    );
    return "Email already used. Go to login page.";
  } else if (error == "ERROR_WRONG_PASSWORD" || error == "wrong-password") {
    functionLog(
      msg: "Wrong email/password combination.",
      fun: functionName,
    );
    return "Wrong email/password combination.";
  } else if (error == "ERROR_USER_NOT_FOUND" || error == "user-not-found") {
    functionLog(
      msg: "No user found with this email.",
      fun: functionName,
    );
    return "No user found with this email.";
  } else if (error == "ERROR_USER_DISABLED" || error == "user-disabled") {
    functionLog(
      msg: "User disabled.",
      fun: functionName,
    );
    return "User disabled.";
  } else if (error == "ERROR_TOO_MANY_REQUESTS" ||
      error == "operation-not-allowed") {
    functionLog(
      msg: "Too many requests to log into this account.",
      fun: functionName,
    );
    return "Too many requests to log into this account.";
  } else if (error == "ERROR_OPERATION_NOT_ALLOWED" ||
      error == "operation-not-allowed") {
    functionLog(
      msg: "Server error, please try again later.",
      fun: functionName,
    );
    return "Server error, please try again later.";
  } else if (error == "ERROR_INVALID_EMAIL" || error == "invalid-email") {
    functionLog(
      msg: "Email address is invalid.",
      fun: functionName,
    );
    return "Email address is invalid.";
  } else {
    functionLog(
      msg: "Login failed. Please try again.",
      fun: functionName,
    );
    return "Login failed. Please try again.";
  }
}

// cKNFRzQlQ6CxWimfiKQgPS:APA91bH1ie-DemmnleTwYJ-ELvCEOHQ0LvHxCv9GCUsOmA60oIGMJdgGoqUpEaDz1L2u4yiAn-nrxWgr4rTRk73q3eRP8K4bDCBcACtOm_tAR0rX0_gcVtF-053nIkeW28OhIk_dPD1X
// cKNFRzQlQ6CxWimfiKQgPS:APA91bH1ie-DemmnleTwYJ-ELvCEOHQ0LvHxCv9GCUsOmA60oIGMJdgGoqUpEaDz1L2u4yiAn-nrxWgr4rTRk73q3eRP8K4bDCBcACtOm_tAR0rX0_gcVtF-053nIkeW28OhIk_dPD1X
// cKNFRzQlQ6CxWimfiKQgPS:APA91bH1ie-DemmnleTwYJ-ELvCEOHQ0LvHxCv9GCUsOmA60oIGMJdgGoqUpEaDz1L2u4yiAn-nrxWgr4rTRk73q3eRP8K4bDCBcACtOm_tAR0rX0_gcVtF-053nIkeW28OhIk_dPD1X
// cKNFRzQlQ6CxWimfiKQgPS:APA91bFow8zjGSFfMDJVC8bo3sHcpZpB5lKtTs-m2lY5u-vSqXsLGiC0CCLk5t0Rp2N_9zmosWyvqc5uwb-uy6ViK2tVwBF5xZh3gb9OP3wQAVSBBZm3wPEEkUYIbcFNKvqVCf44mpiT