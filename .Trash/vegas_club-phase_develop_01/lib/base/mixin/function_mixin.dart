import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:vegas_club/api/app_api.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/config/mixpanel_config.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/models/response/product_response.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';

enum TypeDialog { success, warning, error, loading, custom }

class BaseFunction {
  width(BuildContext context) => MediaQuery.of(context).size.width;
  height(BuildContext context) => MediaQuery.of(context).size.height;
  void onResume() {}

  void onReady() {}

  void onPause() {}
  Future<dynamic> pushNamed(String route, {dynamic arguments}) async {
    locator
        .get<CommonService>()
        .navigatoToNamedRoute(route, arguments: arguments)
        .then((value) {
      return value;
    });
  }

  pushNameRoute(Route route) {
    locator.get<CommonService>().navigatoToRoute(route);
  }

  pushReplaceName(String routeName, {Map<String, dynamic>? arguments}) {
    locator
        .get<CommonService>()
        .replaceToRoute(routeName, arguments: arguments);
  }

  pop<T extends Object?>([T? result]) {
    locator.get<CommonService>().pop(result);
  }

  showDialogProductDetail(List<ProductResponse> listProductByQrCode) {
    locator.get<CommonService>().showProductDialog(listProductByQrCode);
  }

  showSnackBar(BuildContext context, String title) {
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
        height: 60,
        child: CustomSnackBar.success(
          iconPositionLeft: 10,
          iconPositionTop: -20,
          iconRotationAngle: 0,
          icon: const SizedBox(),
          backgroundColor: const Color.fromRGBO(231, 197, 105, 1),
          message: title,
        ),
      ),
      padding: const EdgeInsets.all(6),
      displayDuration: const Duration(milliseconds: 500),
    );

//     final snackBar = SnackBar(
//       clipBehavior: Clip.antiAlias,
//       content: Text(title),
//       duration: Duration(milliseconds: 1500),
//     );

// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//     ScaffoldMessenger.of(
//             locator.get<CommonService>().navigatorKey.currentContext!)
//         .showSnackBar(snackBar);
  }

  Future<void> fetchData({Function? func}) async {
    locator.get<CommonService>().showLoading();
    func;
    locator.get<CommonService>().pop();
  }

  showAlertDialog(
      {TypeDialog typeDialog = TypeDialog.success,
      String title = '',
      bool barrierDismissible = false,
      String? lottiePath,
      void Function()? onSuccess,
      void Function()? onClose}) {
    switch (typeDialog) {
      case TypeDialog.success:
        locator.get<CommonService>().showWarningDialog(
            barrierDismissible: barrierDismissible,
            title: title,
            errorType: ErrorType.success,
            onSuccess: onSuccess,
            onClose: onClose);
        break;

      case TypeDialog.warning:
        locator.get<CommonService>().showWarningDialog(
            barrierDismissible: barrierDismissible,
            title: title,
            errorType: ErrorType.warning,
            onSuccess: onSuccess,
            onClose: () {
              locator.get<CommonService>().pop();
            });
        break;

      case TypeDialog.loading:
        locator.get<CommonService>().showLoading();
        break;

      case TypeDialog.custom:
        locator.get<CommonService>().showWarningDialog(
              barrierDismissible: true,
              errorType: ErrorType.custom,
              title: title,
              pathLottie: lottiePath,
            );
        break;
      case TypeDialog.error:
        break;
      default:
    }
  }

  String getNotificationTypeImage(int idType) {
    switch (idType) {
      case 1:
        return Assets.icons_ic_host_hot_line.path;
      case 2:
        return Assets.icons_ic_car_booking_png.path;
      case 3:
        return Assets.icons_ic_machine_reservation.path;
      default:
        return Assets.icons_ic_drink_food.path;
    }
  }

  String getNotificationTypeString(int idType) {
    switch (idType) {
      case 1:
        return 'Vegas Club';
      case 2:
        return "Booking reservation";

      case 3:
        return "Machine Reservation";
      default:
        return "Food and drink";
    }
  }

  Future<T?> request<T>(Future<T?> Function() func) async {
    try {
      // locator
      //     .get<CommonService>()
      //     .showAlertDialog(typeDialog: TypeDialog.loading);
      final T? result = await func();
      // pop();
      return Future.value(result);
    } catch (e) {
      // pop();
      rethrow;
    }
  }

  Future<T?> fetch<T>(Future<T?> Function() func) async {
    try {
      // final T? result = await request(func);
      // return Future.value(result);
      locator.get<CommonService>().showLoading();
      await func();
      locator.get<CommonService>().pop();
    } catch (e) {
      locator.get<CommonService>().pop();
      if (e is DioError) {
        catchError(e);
        // Future.error(catchError);
      }
    }
    return null;
  }

  void catchError(DioError err) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        print(err.response?.data);
        switch (err.response?.statusCode) {
          case 400:
            showAlertDialog(
                title: err.response?.data['exception'],
                typeDialog: TypeDialog.warning);
            break;
          // throw BadRequestException(err.requestOptions);
          case 401:
            locator.get<MixPanelTrackingService>().reset();
            pushReplaceName(LoginScreen.route);
            break;
          case 404:
            // pushReplaceName(ErrorScreen.route);
            throw NotFoundException(err.requestOptions);
          // break;
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            showAlertDialog(
                title: "Server error 500", typeDialog: TypeDialog.warning);
          // throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }
  }
}

class Debounce {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debounce({this.milliseconds = 400});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}

class SnackBarNotification extends StatelessWidget {
  const SnackBarNotification({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(title ?? ''),
    );
  }
}
