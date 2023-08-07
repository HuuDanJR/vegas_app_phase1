import 'dart:async';
import 'dart:developer';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:odometer/odometer.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';
import 'package:vegas_club/models/response/jackpot_reatime_response.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/view_model/jackpot_history.viewmodel.dart';

class JacpotRealtimePage extends StateFullConsumer {
  const JacpotRealtimePage({super.key});

  @override
  StateConsumer<JacpotRealtimePage> createState() => _JacpotRealtimePageState();
}

class _JacpotRealtimePageState extends StateConsumer<JacpotRealtimePage>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  AnimationController? animationController;
  late Animation<OdometerNumber> animation;
  @override
  void initStateWidget() {
    Provider.of<JackpotHistoryViewmodel>(context, listen: false)
        .getJackpotRealtime();
    _timer = Timer.periodic(const Duration(seconds: 60), (time) {
      Provider.of<JackpotHistoryViewmodel>(context, listen: false)
          .getJackpotRealtime();
    });
  }

  @override
  void disposeWidget() {
    log("jackpot realtime is dispose....");
    if (_timer != null) {
      _timer!.cancel();
      log("jackpot realtime is close....");
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      child: Consumer<JackpotHistoryViewmodel>(builder: (context, model, _) {
        if (model.isLoadingJackpotRealtime == null) {
          return const SizedBox();
        }
        if (model.jackpotRealtime == null) {
          return const SizedBox();
        }

        if (model.listJackpotRealtime.isEmpty) {
          return const SizedBox();
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 17.0, top: 2.5),
              child: Container(
                height: 30,
                color: Colors.white,
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Center(
                            child: Text(
                      "Jackpot",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ))),
                    Expanded(
                        child: Center(
                            child: Text(
                      "Current",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ))),
                    Expanded(
                        child: Center(
                            child: Text(
                      "Max",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: BaseSmartRefress(
                      refreshController: _refreshController,
                      onRefresh: () {
                        Provider.of<JackpotHistoryViewmodel>(context,
                                listen: false)
                            .getJackpotRealtime();
                        _refreshController.refreshCompleted();
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.listJackpotRealtime.length,
                        itemBuilder: (context, index) {
                          return _itemJackpotRealtimeBasic(
                              model.listJackpotRealtime[index], index);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10.0,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Last update: ${model.jackpotRealtime!.lastUpdate!.toDateString()}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        );
      }),
    );
  }

  Widget _itemJackpotRealtime(ListDatumModel response, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (response.name ?? '').toUpperCase(),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                // Text("${response.getPercentageOfValueInMax()}"),
                Text(
                  "MAX: ${response.max ?? ''}".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 60.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      Assets.image_image_background_jp.path,
                    ),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedFlipCounter(
                          textStyle: TextStyle(
                              color: response.isNearMax()
                                  ? const Color.fromRGBO(255, 0, 0, 1)
                                  : const Color.fromRGBO(73, 72, 72, 1),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontFamily.poppins),
                          duration: const Duration(milliseconds: 3000),
                          value: double.tryParse(
                              (response.value!.first.toString() ??
                                  '0'))!, // pass in
                          prefix: "\$",
                          fractionDigits: 2,
                          thousandSeparator: ',', // a value like 2014
                        ),
                      ],
                    ),
                  ),
                ),

                // Expanded(
                //   child: Center(
                //     child: DefaultTextStyle(
                //       style: TextStyle(
                //           color: response.isNearMax()
                //               ? Color.fromRGBO(255, 0, 0, 1)
                //               : Color.fromRGBO(73, 72, 72, 1),
                //           fontSize: 32,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: FontFamily.poppins),
                //       child: AnimatedTextKit(
                //         pause: Duration(milliseconds: 500),
                //         isRepeatingAnimation: false,
                //         repeatForever: false,
                //         totalRepeatCount: 1,
                //         animatedTexts: [
                //           // RotateAnimatedText('AWESOME'),
                //           RotateAnimatedText(
                //
                //             "\$${double.tryParse((response.value!.first.toString() ?? "0"))!.toDecimal() ?? ''}",
                //             rotateOut: false
                //           )
                //         ],
                //         onTap: () {
                //           print("Tap Event");
                //         },
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemJackpotRealtimeBasic(ListDatumModel response, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: ColorName.primary)),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      (response.name ?? ''),
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: AnimatedFlipCounter(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          duration: const Duration(milliseconds: 3000),
                          value: double.tryParse(
                              (response.value!.first.toString() ??
                                  "0"))!, // pass in
                          prefix: "\$",
                          fractionDigits: 2,
                          thousandSeparator: ',', // a value like 2014
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      (response.max ?? '').toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
