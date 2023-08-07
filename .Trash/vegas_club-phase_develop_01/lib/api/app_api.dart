import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/service/authentication.service.dart';

class AppApi {
  AppApi._instance();
  static final instance = AppApi._instance();
  factory AppApi() => instance;

  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: baseUrl));

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 70000, // 15 seconds
      connectTimeout: 70000,
      sendTimeout: 70000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}

class AppInterceptors extends Interceptor with BaseFunction {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log("==========================================================================================================================");
    String? token = await ProfileUser.getAccessToken();
    // locator
    //     .get<CommonService>()
    //     .showAlertDialog(typeDialog: TypeDialog.loading);
    print("${options.method} : url: ${options.baseUrl}${options.path}");
    print("query parameter: ${json.encode(options.queryParameters)}");
    try {
      print("data: ${json.encode(options.data)}");
    } catch (e) {}
    print("token: $token");
    options.headers['authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // pop();
    print("response: ${json.encode(response.data)}");

    super.onResponse(response, handler);
  }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) async {
  // pop();
  // switch (err.type) {
  //   case DioErrorType.connectTimeout:
  //   case DioErrorType.sendTimeout:
  //   case DioErrorType.receiveTimeout:
  //     throw DeadlineExceededException(err.requestOptions);
  //   case DioErrorType.response:
  //     print(err.response?.data);
  //     switch (err.response?.statusCode) {
  //       case 400:
  //         // showAlertDialog(
  //         //     title: err.response?.data['exception'],
  //         //     typeDialog: TypeDialog.warning);
  //         // break;
  //         throw BadRequestException(err.requestOptions);
  //       case 401:
  //         throw UnauthorizedException(err.requestOptions);
  //       // pushReplaceName(LoginScreen.route);
  //       // break;
  //       case 404:
  //         // pushReplaceName(ErrorScreen.route);
  //         throw NotFoundException(err.requestOptions);
  //       // break;
  //       case 409:
  //         throw ConflictException(err.requestOptions);
  //       case 500:
  //         throw InternalServerErrorException(err.requestOptions);
  //     }
  //     break;
  //   case DioErrorType.cancel:
  //     break;
  //   case DioErrorType.other:
  //     throw NoInternetConnectionException(err.requestOptions);
  // }

  // return handler.next(err);
  // }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
