import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/response/setting_menu_response.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/view/member-ship-screen/member_ship.widget.dart';
import 'package:vegas_club/ui/view/point-pyramid-screen/point_pyramid.screen.dart';
import 'package:vegas_club/view_model/application.viewmodel.dart';
import 'package:vegas_club/view_model/profile_screen.viewmodel.dart';

class MembershipScreen extends StateFullConsumer {
  const MembershipScreen({Key? key}) : super(key: key);
  static const String route = '/membership-screen';
  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends StateConsumer<MembershipScreen>
    with BaseFunction {
  final RefreshController _refreshController = RefreshController();
  // ProfileScreenViewModel? model;
  Timer? _timer;

  Future<void> _initData() async {
    Provider.of<ProfileViewModel>(context, listen: false).initData(context);

    Provider.of<ApplicationViewmodel>(context, listen: false).getSettingMenu();
  }

  @override
  void initStateWidget() {
    Provider.of<ProfileViewModel>(context, listen: false).clearData();
    _initData();
    _timer = Timer.periodic(const Duration(hours: 1), (time) {
      _initData();
    });
  }

  @override
  void disposeWidget() {
    if (_timer != null) {
      _timer!.cancel();
    }
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
          backgroundColor: ColorName.primary2,
          centerTitle: true,
          elevation: 0,
          title: const Text("Membership",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              )),
          // toolbarHeight: 80,
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, ProfileViewModel model, _) {
            // if (model.customerResponse == null) {
            //   return Center(
            //     child: loadingWidget(),
            //   );
            // }
            String pathImage = Assets.image_host_placeholder.path;
            if (model.customerResponse != null) {
              if (model.level == "ONE+") {
                pathImage = Assets.image_vegas_membership_one_plus_1.path;
              } else if (model.level == "I") {
                pathImage = Assets.image_vegas_membership_i_1.path;
              } else if (model.level == "ONE") {
                pathImage = Assets.image_vegas_membership_one_1.path;
              } else if (model.level == "V") {
                pathImage = Assets.image_vegas_membership_v_1.path;
              } else if (model.level == "P") {
                pathImage = Assets.image_vegas_membership_p_1.path;
              } else {
                pathImage = Assets.image_host_placeholder.path;
              }
            } else {
              pathImage = Assets.image_host_placeholder.path;
            }

            return BaseSmartRefress(
              refreshController: _refreshController,
              onRefresh: () {
                model.initData(context);
                _refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // height: 120.0,
                      width: width(context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(Assets.image_banner_jpg.path),
                      )),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${model.customerResponse?.title}. ${model.customerResponse != null ? model.customerResponse!.getUserName() : ''} ",
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ),
                              Text(
                                "${model.customerResponse?.number}",
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.0,
                                vertical: isSmallScreen(context) ? 10 : 16.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      1, 2), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Expanded(
                                //   child: MBSPoint(
                                //     point: mbsPoint,
                                //   ),
                                // ),
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        child: Image.asset(pathImage))),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Consumer<ApplicationViewmodel>(
                                            builder: (context, appModel, _) {
                                          List<SettingMenuResponse> settings =
                                              appModel.listSetting
                                                  .where((e) =>
                                                      e.name ==
                                                      "account_balance_membership")
                                                  .toList();
                                          if (settings.isNotEmpty &&
                                              settings.first.value == 0) {
                                            return const SizedBox();
                                          }
                                          return Column(
                                            children: [
                                              informationPointMemberShip(
                                                  context: context,
                                                  title: "Wallet",
                                                  value:
                                                      "\$${model.walletSum.toDecimal()}"),
                                              informationPointMemberShip(
                                                  context: context,
                                                  title: "Game Credits",
                                                  value:
                                                      "\$${model.voucherSum.toDecimal()}"
                                                          .replaceAll(
                                                              ".", ",")),
                                            ],
                                          );
                                        }),
                                        informationPointMemberShip(
                                            context: context,
                                            title: "Points",
                                            value:
                                                "${(model.memberShipPointResponse != null ? model.memberShipPointResponse?.loyaltyPointCurrent!.toDecimal().toString() : "0")!} pts"),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            buttonView2(
                                                context: context,
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const AlertDialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          content:
                                                              LevelRoadMap(),
                                                        );
                                                      });
                                                },
                                                text: "All Level Map"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 20.0,
                            // color: Colors.grey.shade300,
                          ),
                          // _buildCustomLabels(),
                          Stack(
                            children: [
                              // _buildTaskTracker(
                              //     context,
                              //     (model.memberShipPointResponse == null ||
                              //             model.memberShipPointResponse!
                              //                     .framePoint ==
                              //                 "N/A")
                              //         ? 0
                              //         : int.parse(model.memberShipPointResponse!
                              //             .framePoint!)),
                              buildProgressLine(
                                  itemWidth: width(context),
                                  pointFrame:
                                      (model.memberShipPointResponse == null ||
                                              model.memberShipPointResponse!
                                                      .framePoint ==
                                                  "N/A")
                                          ? 0
                                          : int.parse(model
                                              .memberShipPointResponse!
                                              .framePoint!)),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    "Frame point: ${(model.memberShipPointResponse != null && model.memberShipPointResponse!.framePoint != "N/A") ? '${double.parse(model.memberShipPointResponse!.framePoint!).toDecimal()} pts' : model.memberShipPointResponse != null ? model.memberShipPointResponse!.framePoint : 0}  ",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14.0),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${model.memberShipPointResponse != null ? model.memberShipPointResponse!.frameStartDate : ''}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                    const Text(" - "),
                                    Text(
                                      "${model.memberShipPointResponse != null ? model.memberShipPointResponse!.frameEndDate : ''}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          _listFunctionReservation(model),
                          // Padding(
                          //   padding:
                          //       EdgeInsets.symmetric(horizontal: 16.0),
                          //   child: totalInformationMembership(
                          //       context,
                          //       model.customerResponse,
                          //       model.memberShipPointResponse ??
                          //           MemberShipPointResponse()),
                          // ),
                          const SizedBox(
                            height: 20.0,
                          ),

                          Consumer<ApplicationViewmodel>(
                              builder: (context, model, _) {
                            List<SettingMenuResponse> settings = model
                                .listSetting
                                .where((e) => e.name == "member_benefit")
                                .toList();
                            if (settings.isNotEmpty &&
                                settings.first.value == 0) {
                              return const SizedBox();
                            }
                            return Column(
                              children: [
                                Container(
                                  width: width(context),
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black26))),
                                  child: const Text(
                                    "Member Benefit",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18.0),
                                  ),
                                ),
                                Column(
                                  children: [
                                    memberShipWidget(),
                                  ],
                                ),
                              ],
                            );
                          }),
                          // Html(
                          //   data: model.fileHtmlContents,
                          //   style: {
                          //     "body": Style(
                          //         fontSize: FontSize(12.0),
                          //         fontWeight: FontWeight.normal,
                          //         color: Colors.black),
                          //   },
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget informationPointMemberShip(
      {required BuildContext context, String? title, dynamic value}) {
    dynamic text = 0;

    if (value != null) {
      if (value is int) {
        text = value.toString();
      } else {
        text = value;
      }
    } else {
      text = "0";
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 66,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? '',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: isSmallScreen(context) ? 12 : 16),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            "$text",
            style: TextStyle(
                fontSize: isSmallScreen(context) ? 18 : 24.0,
                color: ColorName.primary2,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _listFunctionReservation(ProfileViewModel model) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: isSmallScreen(context) ? 3 : 3.5,
      crossAxisCount: 2,
      children: [
        _itemReservation(
            imageName: Assets.icons_ic_poker_card.path,
            title: "Daily Point",
            value:
                "${(model.memberShipPointResponse?.loyaltyPointToday ?? 0).toDecimal()} pts",
            onTap: () {
              // pushNamed(MachineRequestScreen.routeName);
            }),
        _itemMultiReservation(
            imageName: Assets.icons_ic_drink_food.path,
            title1: "Daily Slot",
            title2: "Daily RL-TB",
            value1:
                "${model.memberShipPointResponse?.loyaltyPointTodaySlot!.toDecimal()} pts",
            value2:
                "${model.memberShipPointResponse?.loyaltyPointTodayRltb!.toDecimal()} pts",
            onTap: () {
              // pushNamed(FoodReservationScreen.route);
            }),
        _itemReservation(
            imageName: Assets.icons_ic_weekly_point_png.path,
            title: "Weekly Point",
            value:
                "${model.memberShipPointResponse?.loyaltyPointWeekly!.toDecimal()} pts",
            onTap: () {
              pushNamed(PointPyramidScreen.route);
            }),
        _itemReservation(
            imageName: Assets.icons_ic_weekly_point_png.path,
            title: "Monthly Point",
            value:
                "${model.memberShipPointResponse != null ? model.memberShipPointResponse!.loyaltyPointMonth!.toDecimal() : 0} pts",
            onTap: () {
              // pushNamed(HostScreen.route);
            }),
      ],
    );
  }

  Widget _itemMultiReservation(
      {String? imageName,
      String? title1,
      String? title2,
      String? value1,
      String? value2,
      TextStyle? titleStyle,
      TextStyle? valueStyle,
      void Function()? onTap}) {
    return Container(
      height: 52.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Container(
        // height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: 90.0,
        height: 52.0,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title1 ?? '',
                    style: titleStyle ??
                        const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    title2 ?? '',
                    style: valueStyle ??
                        const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value1 ?? '',
                    style: titleStyle ??
                        const TextStyle(
                          fontSize: 14.0,
                          color: ColorName.primary2,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    value2 ?? '',
                    style: valueStyle ??
                        const TextStyle(
                          fontSize: 14.0,
                          color: ColorName.primary2,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemReservation(
      {String? imageName,
      String? title,
      String? value,
      TextStyle? titleStyle,
      TextStyle? valueStyle,
      void Function()? onTap}) {
    // if (typeReservation == TypeReservation.food) {
    //   asset = Assets.image.icFood.path;
    // } else if (typeReservation == TypeReservation.machineSlot) {
    //   asset = Assets.image.slotMachine.path;
    // }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          // height: 70.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          width: 90.0,
          height: 52.0,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      style: titleStyle ??
                          const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      value ?? '',
                      style: valueStyle ??
                          const TextStyle(
                            fontSize: 14.0,
                            color: ColorName.yellowBrown,
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        imageName ?? '',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
