import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';

class IntroScreen extends StateFullConsumer {
  const IntroScreen({Key? key}) : super(key: key);
  static const String route = '/intro-screen';
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends StateConsumer<IntroScreen> {
  @override
  Widget buildWidget(BuildContext context) {
    return Container();
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
