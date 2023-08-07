import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:video_player/video_player.dart';

class VideoStream2Screeen extends StateFullConsumer {
  const VideoStream2Screeen({Key? key, this.url}) : super(key: key);
  final String? url;

  static const String routeName = "./VideoStream";
  @override
  _VideoStream2ScreeenState createState() => _VideoStream2ScreeenState();
}

class _VideoStream2ScreeenState extends StateConsumer<VideoStream2Screeen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late VideoPlayerController videoPlayerController;
  ChewieController? _chewieController;
  Chewie? _chewie;
  @override
  void initStateWidget() {
    init();
  }



  void init() async {
    try {
      videoPlayerController = VideoPlayerController.network(widget.url ?? '');
      // if(videoPlayerController.)
      await videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft],
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        fullScreenByDefault: true,
        allowFullScreen: true,
      );
      _chewie = Chewie(controller: _chewieController!);
    } catch (e) {
      log(e.toString());
    }
    setState(() {});
  }

  @override
  void disposeWidget() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarBottomBar(_scaffoldKey,
            context: context, title: "Routette", onClose: () {
          Navigator.of(context).pop();
        }),
        body: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: _chewieController != null
                  ? Hero(
                      tag: widget.url ?? '',
                      child: SizedBox(
                        height: 200,
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      child: Center(
                        child: Lottie.asset(Assets.lottie_lottie_loading),
                      ),
                    ),
            ),
          ],
        ));
  }
}
