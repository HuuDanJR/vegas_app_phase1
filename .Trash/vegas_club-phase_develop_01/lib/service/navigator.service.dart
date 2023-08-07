import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/models/response/product_response.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';

enum ErrorType { success, warning, notfound, errorServer, loading, custom }

class CommonService with BaseFunction {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<dynamic> navigatoToNamedRoute(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigatoToRoute(Route route) async {
    return navigatorKey.currentState!.push(route);
  }

  Future<dynamic> replaceToRoute(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> pop<T extends Object?>([T? result]) async {
    return navigatorKey.currentState!.pop(result);
  }

  void showProductDialog(List<ProductResponse> listProductByQrCode) {}

  void showLoading() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loadingWidget(),
              ],
            ),
          );
        });
  }

  void showWarningDialog(
      {String? title = '',
      ErrorType errorType = ErrorType.warning,
      void Function()? onSuccess,
      void Function()? onClose,
      bool barrierDismissible = false,
      String? pathLottie}) {
    String typeError = pathLottie ?? Assets.lottie_warning;

    if (errorType == ErrorType.notfound) {
      typeError = Assets.lottie_error;
    } else if (errorType == ErrorType.errorServer) {
      typeError = Assets.lottie_error_404;
    } else if (errorType == ErrorType.success) {
      typeError = Assets.lottie_success;
    } else if (errorType == ErrorType.loading) {
      typeError = Assets.lottie_lottie_loading;
    }
    showDialog(
        barrierDismissible: barrierDismissible,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            backgroundColor: errorType == ErrorType.loading
                ? Colors.transparent
                : Colors.white,
            elevation: errorType == ErrorType.loading ? 0 : null,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 100.0,
                  child: Lottie.asset(typeError,
                      repeat: errorType != ErrorType.success),
                ),
                Text(
                  (title ?? '').translate(context).isEmpty
                      ? (title ?? '')
                      : title!,
                  style: const TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: onSuccess != null,
                        child: Expanded(
                            child:
                                buttonView(onPressed: onSuccess, text: "Ok"))),
                    Visibility(
                        visible: onClose != null,
                        child: Expanded(
                            child:
                                buttonView(onPressed: onClose, text: "Cancel")))
                  ],
                ),
              ],
            ),
          );
        });
  }
}
