import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';

class ErrorScreen extends StateFullConsumer {
  const ErrorScreen({Key? key, this.errorType = ErrorType.warning}) : super(key: key);
  final ErrorType errorType;
  static const String route = '/error-screen';
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends StateConsumer<ErrorScreen> {
  String pathLottie = Assets.lottie_error_404;

  @override
  void initStateWidget() {
    if (widget.errorType == ErrorType.notfound) {
      pathLottie = Assets.lottie_error_404;
    } else {
      pathLottie = Assets.lottie_error_404;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(child: Lottie.asset(pathLottie)),
          ),
          buttonView(
              onPressed: () {
                pushReplaceName(LoginScreen.route);
              },
              text: "Try again")
        ],
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
