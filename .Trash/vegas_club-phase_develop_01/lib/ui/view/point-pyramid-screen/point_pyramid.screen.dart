import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/view/point-pyramid-screen/point_pyramid.widget.dart';
import 'package:vegas_club/view_model/point_pyramid_screen.viewmodel.dart';

var demoJson = [
  {
    "price": '\$20,000',
    "pts": ['206']
  },
  {
    "price": '\$20,000',
    "pts": ['206', '205']
  },
  {
    "price": '\$20,000',
    "pts": ['206', '205']
  },
  {
    "price": '\$20,000',
    "pts": ['206', '205', '206', '205']
  },
];

class PointPyramidScreen extends StateFullConsumer {
  const PointPyramidScreen({Key? key}) : super(key: key);
  static const String route = '/point-pyramid-screen';
  @override
  _PointPyramidScreenState createState() => _PointPyramidScreenState();
}

class _PointPyramidScreenState extends StateConsumer<PointPyramidScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initStateWidget() {
    Provider.of<PointPyramidScreenViewModel>(context, listen: false).initDate();
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorName.primary2,
            title: const Text(
              "Pyramid point",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          body: Consumer<PointPyramidScreenViewModel>(
            builder: (BuildContext context, PointPyramidScreenViewModel model,
                Widget? child) {
              return BaseSmartRefress(
                refreshController: _refreshController,
                onRefresh: () {
                  model.initDate();
                  _refreshController.refreshCompleted();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Column(
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       left: 10.0, right: 10.0, top: 10.0),
                            //   child: animationItemWidget(
                            //       postion: 1,
                            //       child:
                            //           userInformationBar(model.customerResponse)),
                            // ),
                            const SizedBox(
                              height: 20.0,
                            ),

                            // SizedBox(
                            //   height: 30.0,
                            // ),
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 139,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Center(
                                    child: Text(
                                      "${model.memberShipPointResponse != null ? model.memberShipPointResponse!.loyaltyPointWeekly!.toDecimal().toString() : 0}",
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: ColorName.primary2),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'Your Pyramid Point',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                              ],
                            ),
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          Assets.image_pyramid_png.path))),
                            ),
                            // informationPoint(
                            //     context: context,
                            //     title: 'Your Point Pyramid Point',
                            //     value: model
                            //         .memberShipPointResponse?.loyaltyPointWeekly!
                            //         .toDecimal()),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 139,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Center(
                                          child: Text(
                                            "${model.memberShipPointResponse != null ? model.memberShipPointResponse!.loyaltyPointWeeklyRange.toString() : 0}",
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: ColorName.primary2),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      const Text(
                                        'Your Range of this week',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 139,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Center(
                                          child: Text(
                                            "${model.memberShipPointResponse != null ? model.memberShipPointResponse!.loyaltyPointWeeklyNextDraw!.toDecimal() : 0}",
                                            style: const TextStyle(
                                                fontSize: 22,
                                                color: ColorName.primary2),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      const Text(
                                        'Point to be next draw',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Real-Time Point Pyramid List',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            // SizedBox(
                            //   height: 6.0,
                            // ),
                            // Text(
                            //   'Update: 2021.10.28 ~ 19:30',
                            //   style: TextStyle(color: Colors.green),
                            // ),
                            // SizedBox(
                            //   height: 6.0,
                            // ),
                            // Text(
                            //   'Next Update: 2021.10.28 ~ 20:30',
                            //   style: TextStyle(color: Colors.green),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        color: Colors.white,
                        child: TableCustomWidget(
                          listData: model.listPyramidPoint ?? [],
                          range: model.memberShipPointResponse != null
                              ? model
                                  .memberShipPointResponse!.loyaltyPointWeekly!
                              : 0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
