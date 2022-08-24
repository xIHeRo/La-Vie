// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_prefrences.dart';
import '../../app/constants.dart';

class DioFactory {
  static const String APPLICATION_JSON = "application/json";
  static const String CONTENTTYPE = "content-type";
  static const String ACCEPT = "accept";
  static const String AUTHORITZATION = "authorization";
  static const String DEFAULT_LANGUAGE = "language";
//----------------------------------------------------------------
  final AppPrefrences _appPrefrences;
  DioFactory(this._appPrefrences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPrefrences.getAppLanguage();

    Map<String, String> headers = {
      CONTENTTYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORITZATION: Constants.token,
      DEFAULT_LANGUAGE: language,
    };
//----------------------------------------------------------------
    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout: Constants.apiTimeout,
        sendTimeout: Constants.apiTimeout);
//----------------------------------------------------------------
// logger is used to get the details of the response and the request for the api
// logger is in depug mode only (during the development)
    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
//----------------------------------------------------------------
    return dio;
  }
}
