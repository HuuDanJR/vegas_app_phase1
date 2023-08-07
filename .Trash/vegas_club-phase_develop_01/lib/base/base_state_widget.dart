import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';

abstract class StateFullConsumer extends ConsumerStatefulWidget {
  const StateFullConsumer({Key? key}) : super(key: key);
}

abstract class StateConsumer<Page extends StateFullConsumer>
    extends ConsumerState<Page>
    with AutomaticKeepAliveClientMixin, BaseFunction {
  bool isPaused = false;
  Stopwatch? _stopwatch;
  Timer? _timer;
  String _formattedTime = '00:00:00';
  void initStateWidget();
  void disposeWidget();
  Widget buildWidget(BuildContext context);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    _stopwatch!.start();
    initStateWidget();
  }

  void _updateTimer(Timer timer) {
    if (_stopwatch != null) {
      if (_stopwatch!.isRunning) {
        setState(() {
          _formattedTime = _formatTime(_stopwatch!.elapsed.inSeconds);
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    if (_stopwatch != null) {
      _stopwatch!.stop();
    }
    disposeWidget();
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                // Container(
                //   width: width(context),
                //   height: 50.0,
                //   decoration: BoxDecoration(color: ColorName.primary2),
                // ),
                Expanded(
                  child: Container(
                    width: width(context),
                    height: height(context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Assets.image_background_jpg.path),
                    )),
                  ),
                ),
                // Expanded(
                //   flex: 6,
                //   child: Container(
                //     width: width(context),
                //     color: Colors.white,
                //   ),
                // )
              ],
            ),
            SizedBox(
                width: width(context),
                height: height(context),
                child: buildWidget(context)),
          ],
        ),
      ),
    );
  }

  // @override
  // void didUpdateWidget(covariant Page oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     if (!isPaused) {
  //       onPause();
  //     }
  //   } else if (state == AppLifecycleState.resumed) {
  //     if (!isPaused) {
  //       onResume();
  //     }
  //   }
  // }

  @override
  bool get wantKeepAlive => true;
}

abstract class StateLessConsumer extends StatelessWidget with BaseFunction {
  StateLessConsumer({Key? key}) : super(key: key);
  bool isPaused = false;
  Widget buildWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: width(context),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromARGB(225, 255, 179, 0),
                        ColorName.primary,
                        Colors.white
                      ])),
                ),
              ),
              // Expanded(
              //   flex: 6,
              //   child: Container(
              //     width: width(context),
              //     color: Colors.white,
              //   ),
              // )
            ],
          ),
          SizedBox(
              width: width(context),
              height: height(context),
              child: buildWidget(context)),
        ],
      );
    });
  }
}
