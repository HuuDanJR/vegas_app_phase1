import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/roulette_response.model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class RouletteVideo extends StateFullConsumer {
  const RouletteVideo({Key? key, this.roulette}) : super(key: key);
  final RouletteResponse? roulette;
  @override
  StateConsumer<RouletteVideo> createState() => _RouletteVideoState();
}

class _RouletteVideoState extends StateConsumer<RouletteVideo>
    with BaseFunction {
  final _editNode = FocusNode();
  final _video = TextEditingController(
      text:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
  final ImageFormat _format = ImageFormat.JPEG;
  final int _quality = 50;
  final int _sizeH = 0;
  final int _sizeW = 0;
  final int _timeMs = 0;

  String? _fileName;

  @override
  void initStateWidget() {
    // initThumbnail(widget.roulette!.streamingUrl!);
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
  @override
  Widget buildWidget(BuildContext context) {
    return _itemVideo(widget.roulette!);
  }

  // Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  //   //WidgetsFlutterBinding.ensureInitialized();
  //   Uint8List? bytes;
  //   final Completer<ThumbnailResult> completer = Completer();
  //   if (r.thumbnailPath != null) {
  //     final thumbnailPath = await VideoThumbnail.thumbnailFile(
  //       video: r.video!,
  //       headers: {
  //         "USERHEADER1": "user defined header1",
  //         "USERHEADER2": "user defined header2",
  //       },
  //       thumbnailPath: r.thumbnailPath,
  //       imageFormat: ImageFormat.PNG,
  //       maxWidth: 500,
  //       quality: 10,
  //       maxHeight: 500,
  //       timeMs: r.timeMs!,
  //     );

  //     print("thumbnail file is located: $thumbnailPath");

  //     final file = File(thumbnailPath!);
  //     bytes = file.readAsBytesSync();
  //   } else {
  //     bytes = await VideoThumbnail.thumbnailData(
  //       video: r.video!,
  //       // headers: {
  //       //   "USERHEADER1": "user defined header1",
  //       //   "USERHEADER2": "user defined header2",
  //       // },
  //       imageFormat: ImageFormat.WEBP,
  //       maxWidth: 500,

  //       quality: 10,
  //       maxHeight: 500,

  //       timeMs: r.timeMs!,
  //     );
  //   }

  //   int _imageDataSize = bytes!.length;
  //   print("image size: $_imageDataSize");

  //   final _image = Image.memory(
  //     bytes,
  //     fit: BoxFit.cover,
  //   );
  //   _image.image
  //       .resolve(ImageConfiguration())
  //       .addListener(ImageStreamListener((ImageInfo info, bool _) {
  //     completer.complete(ThumbnailResult(
  //       image: _image,
  //       dataSize: _imageDataSize,
  //       height: info.image.height,
  //       width: info.image.width,
  //     ));
  //   }));
  //   return completer.future;
  // }

  // Future<void> initThumbnail(String url) async {
  //   _fileName = await VideoThumbnail.thumbnailFile(
  //     video: url,
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.JPEG,
  //     maxHeight:
  //         170, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //     quality: 75,
  //   );
  //   setState(() {});
  // }

  Widget _itemVideo(RouletteResponse roulette) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(
            //   width: 1,
            // ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: VideoStreamItem(
                    url: roulette.streamingUrl,
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   child: Container(
                //     height: height(context),
                //     width: width(context),
                //     decoration: BoxDecoration(
                //         gradient: LinearGradient(
                //             begin: Alignment.bottomCenter,
                //             end: Alignment.topCenter,
                //             colors: [
                //           Color.fromARGB(255, 0, 0, 0),
                //           Color.fromARGB(23, 0, 0, 0),
                //           Color.fromARGB(0, 0, 0, 0),
                //         ])),
                //   ),
                // ),
                // Positioned(
                //   left: 0,
                //   bottom: 0,
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       SizedBox(
                //           child: Image.asset(
                //         Assets.image.routelletWheel.path,
                //         // width: 100.0,
                //         height: 70.0,
                //       )),
                //     ],
                //   ),
                // ),
              ],
            ),
            Container(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                // height: 40.0,
                child: Text(
                  roulette.description.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class VideoStreamItem extends StateFullConsumer {
  const VideoStreamItem({Key? key, this.url}) : super(key: key);
  final String? url;
  @override
  StateConsumer<VideoStreamItem> createState() => _VideoStreamItemState();
}

class _VideoStreamItemState extends StateConsumer<VideoStreamItem> {
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
      await videoPlayerController.initialize();
      _chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: false,
          looping: false,
          showControls: false,
          materialProgressColors:
              ChewieProgressColors(handleColor: ColorName.primary),
          deviceOrientationsOnEnterFullScreen: [
            DeviceOrientation.landscapeLeft
          ],
          deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
          fullScreenByDefault: false,
          maxScale: 1 / 1);
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
    return Center(
      child: _chewieController != null
          ? Stack(
              children: [
                SizedBox(
                  height: 200,
                  child: Chewie(
                    controller: _chewieController!,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Center(
                      child:
                          Lottie.asset(Assets.lottie_play_lottie, width: 60.0)),
                ),
              ],
            )
          : const SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  "Error",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
    );
  }
}
