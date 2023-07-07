import 'dart:convert';
import 'dart:io';
import 'package:fl_structure/bussiness_logic/models/response_wrapper.dart';
import 'package:fl_structure/utils/all_getter.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:get/get.dart' as g;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

part 'api_endpoints.dart';

part 'exceptions.dart';

abstract class HttpServiceConst {
  static const int post = 0;
  static const int get = 1;
  static const int delete = 2;
  static const int put = 3;
}

class HttpService {
  late Dio _dio;

  HttpService() {
    _dio = Dio();
  }

  Future<Response> request({
    required String url,
    int requestType = HttpServiceConst.post,
    Map<String, dynamic>? body,
    Map<String, String>? customHeaders,
    bool useBaseUrl = true,
    bool useTokenInBody = true,
  }) async {
    Response response;
    try {
      Map<String, dynamic> map = body ?? {};
      Map<String, String> headers = customHeaders ?? getHeaders();
      String fullUrl = useBaseUrl ? "${ApisEndpoints.baseUrl}$url" : url;
      printLog("Hit Api Url 😛 ==> $fullUrl");
      printLog("Hit Api Body 😛 ==> $map");
      printLog("Api Headers ==> $headers");
      response = await _checkRequest(
        fullUrl: fullUrl,
        requestType: requestType,
        body: map,
        headers: headers,
      );
      printLog("Dio Response : $url ${response.data}");
      if (url == ApisEndpoints.fcmSendNotification) {
        return Response(
          requestOptions: RequestOptions(path: url,),
          statusCode: RepoResponseStatus.success,
          data: response,
        );
      }
      if (response.statusCode == RepoResponseStatus.success) {
        final result = responseChecker(response);
        if ((result as Map<String, dynamic>).containsKey('statusCode') &&
            result['statusCode'] == RepoResponseStatus.authentication) {
          gotoLoginPage();
          throw AuthenticationException("Authentication Failed");
        } else if ((result).containsKey('statusCode') &&
            result['statusCode'] == RepoResponseStatus.subscriptionExpire) {
          throw SubscriptionException("Subscription Expire");
        } else {
          return Response(
            requestOptions: response.requestOptions,
            data: result,
            statusCode: result['status']
                ? RepoResponseStatus.success
                : RepoResponseStatus.error,
            statusMessage: response.statusMessage,
          );
        }
      }
    } on SocketException catch (e) {
      blocLog(bloc: "Error message for", msg: "$url: ${e.message}");
      blocLog(bloc: "Error Status Code ", msg: "SocketException");
      throw SocketException(e.message);
    } on DioError catch (e) {
      blocLog(bloc: "Error message for", msg: "$url: ${e.message}");
      blocLog(bloc: "Error response for $url ", msg: "${e.response?.data}");
      blocLog(bloc: "Error Status Code ", msg: "${e.response?.statusCode}");
      throw throwException(e, url: url);
    }
    return response;
  }

  Future<Response> _checkRequest({
    required String fullUrl,
    required int requestType,
    required Map<String, dynamic> body,
    required Map<String, dynamic> headers,
  }) async {
    if (requestType == HttpServiceConst.get) {
      printLog("Hit Request Type 😛 ==> get");
      return await _dio.get(
        fullUrl,
        options: Options(headers: headers),
        queryParameters: body,
      );
    } else if (requestType == HttpServiceConst.post) {
      printLog("Hit Request Type 😛 ==> post");
      return await _dio.post(fullUrl,
          data: body, options: Options(headers: headers));
    } else if (requestType == HttpServiceConst.delete) {
      printLog("Hit Request Type 😛 ==> delete");
      return await _dio.delete(fullUrl,
          data: body, options: Options(headers: headers));
    } else {
      printLog("Hit Request Type 😛 ==> patch");
      return await _dio.patch(fullUrl,
          data: body, options: Options(headers: headers));
    }
  }

  Map<String, String> getHeaders() {
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    return headers;
  }

  /// /*
  /// * Multipart Files Request
  /// */
  Future<dynamic> multiPartFiles({
    Map<String, String>? body,
    List<File>? files,
    required String endPoint,
    File? profile,
    String? filesField,
    bool? useCustomHeader,
  }) async {
    try {
      final headers =  getHeaders() ;
      final uri = Uri.parse('${ApisEndpoints.baseUrl}$endPoint');
      final request = http.MultipartRequest('POST', uri);
      request.fields.addAll(body ?? {});
      request.headers.addAll(headers);
      printLog("Hit For MultiMedia Api Url 😛 ==> $endPoint");
      printLog("Hit For MultiMedia Api Body 😛 ==> $body");
      printLog("Api For MultiMedia Headers 😛 ==> $headers");
      if (profile != null) {
        final mimeType = lookupMimeType(profile.path);
        request.files.add(
          await http.MultipartFile.fromPath('profileImage', profile.path,
              contentType: MediaType.parse(mimeType!)),
        );
      }

      if ((files?.isNotEmpty ?? false) && (files != null)) {
        for (int i = 0; i < files.length; i++) {
          if (files.isNotEmpty) {
            final mimeType = lookupMimeType(files[i].path);
            request.files.add(
              await http.MultipartFile.fromPath(
                  filesField ?? "idProof", files[i].path,
                  contentType: MediaType.parse(mimeType!)),
            );
          }
        }
      }
      printLog("files ==========>${request.files.length}");
      http.StreamedResponse response = await request.send();
      final res = await response.stream.bytesToString();
      printLog("Dio Response For MultiMedia : $endPoint $res");
      return res;
    } on DioError catch (e) {
      printLog("Error Message For MultiMedia : ${e.message}");
      printLog("Error Response For MultiMedia : ${e.response?.data}");
      printLog("Error Status Code For MultiMedia : ${e.response?.statusCode}");
      throw throwException(e);
    } on SocketException catch (e) {
      blocLog(bloc: "Error message for", msg: "$endPoint: ${e.message}");
      blocLog(bloc: "Error Status Code ", msg: "SocketException");
      throw SocketException(e.message);
    } catch (e) {
      if (e is SocketException) {
        throw const SocketException('Please Check Your Internet Connection');
      } else {
        throw Exception(e.toString());
      }
    }
  }

  Future<void> gotoLoginPage() async {
    await getLocalStorage.clearAllBox();
    // g.Get.offAll(LoginScreen());
  }



  dynamic throwException(DioError e, {String? url}) {
    if (e.response?.statusCode ==
        RepoResponseStatus.serverIsTemporarilyUnable) {
      //TODO change here
       gotoLoginPage() ;
      // if (getLoginUser != null) {
      //   gotoLoginPage();
      // }
      throw AuthenticationException(
          "The server is temporarily unable to service please try again latter");
    } else if (url == ApisEndpoints.getProfileData &&
        e.response?.statusCode == RepoResponseStatus.platformException) {
      gotoLoginPage();
      throw AuthenticationException("Authentication Failed");
    } else if (e.type == DioErrorType.connectTimeout) {
      throw ConnectingTimedOut("Connecting timed out please try again latter ");
    } else if (e.response != null &&
        (e.response?.statusCode == RepoResponseStatus.authentication)) {
      gotoLoginPage();
      throw AuthenticationException("Authentication Failed");
    } else if (e.response != null &&
        (e.response?.statusCode == RepoResponseStatus.subscriptionExpire)) {
      throw SubscriptionException("Please selected subscription plan");
    } else if (e.response != null &&
        (e.response?.statusCode == RepoResponseStatus.platformException ||
            e.response?.statusCode == RepoResponseStatus.notFoundException)) {
      throw PlatformException(
        details: e.response?.data['message'].toString(),
        message: e.response?.data['message'].toString(),
        code: "${e.response?.statusCode.toString()}",
        stacktrace: "",
      );
    } else {
      throw Exception(e.message);
    }
  }
}
