import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';

class SplashScreen extends StateFullConsumer {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = "./splash_screen";
  @override
  StateConsumer<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends StateConsumer<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 2), () {
      pushReplaceName(LoginScreen.route);
    });
    super.initState();
  }
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(218, 210, 199, 1),
      backgroundColor: Colors.white,
      body: _bodyLoading(),
    );
  }


  Widget _bodyLoading() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          color: Colors.transparent,
          height: 130,
          width: 140,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    color: Colors.transparent,
                    width: 150,
                    height: 50,
                    child: Lottie.asset(Assets.lottie_loading_dot,
                        fit: BoxFit.fitWidth)),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Image.asset(
                  Assets.logo_vegas_logo_png.path,
                  width: 100,
                  height: 100,
                ),
              ),

              // Text('Loading...', style: TextStyle(color: Colors.black),),

            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Lottie.asset('assets/lottie/flashscreen.json',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            repeat: false, onLoaded: (compotion) async {
          await Future.delayed(const Duration(seconds: 3), () {
            pushReplaceName(LoginScreen.route);
          });
        }),
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  void initStateWidget() {
    // TODO: implement initStateWidget
  }
}
