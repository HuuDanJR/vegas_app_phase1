import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/config/mixpanel_config.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/response/setting_menu_response.dart';
import 'package:vegas_club/models/response/slide_level_response.dart';
import 'package:vegas_club/ui/share_widget/base_list.widget.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/ui/view/booking-status-screen/list_car_booking.screen.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/food_reservation.screen.dart';
import 'package:vegas_club/ui/view/host-screen/host.screen.dart';
import 'package:vegas_club/ui/view/machine-reservation-screen/machine_reservation.screen.dart';
import 'package:vegas_club/ui/view/member-ship-screen/member_ship.screen.dart';
import 'package:vegas_club/ui/view/member-ship-screen/member_ship.widget.dart';
import 'package:vegas_club/ui/view/notification-screen/notification.screen.dart';
import 'package:vegas_club/ui/view/profile-screen/profile.widget.dart';
import 'package:vegas_club/view_model/application.viewmodel.dart';
import 'package:vegas_club/view_model/notification_screen.viewmodel.dart';
import 'package:vegas_club/view_model/profile_screen.viewmodel.dart';

class ProfileScreen extends StateFullConsumer {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String route = '/profile-screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateConsumer<ProfileScreen>
    with BaseFunction {
  final RefreshController _refreshController = RefreshController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  final CarouselController _controller = CarouselController();

  Future<void> _initData() async {
    log("call api....");
    Provider.of<ProfileViewModel>(context, listen: false).initData(context);
    Provider.of<NotificationScreenViewModel>(context, listen: false)
        .getSumNotificationIsNotRead();
    Provider.of<ApplicationViewmodel>(context, listen: false).getSettingMenu();
    log("profile screen");
  }

  Future<void> _getData() async {
    log("----Đăng nhập----");
    Provider.of<ProfileViewModel>(context, listen: false).initData(context,
        onCallBack: (val) {
      locator
          .get<MixPanelTrackingService>()
          .trackData(name: "Đăng nhập");
    });
    Provider.of<NotificationScreenViewModel>(context, listen: false)
        .getSumNotificationIsNotRead();
    Provider.of<ApplicationViewmodel>(context, listen: false).getSettingMenu();
  }

  @override
  void initStateWidget() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _getData();
        _timer = Timer.periodic(const Duration(hours: 1), (time) {
          _initData();
        });
      },
    );

  }

  @override
  void disposeWidget() {
    log("timer is dispose.....");

    if (_timer != null) {
      log("timer is closed......");
      _timer!.cancel();
    }
  }


  @override
  Widget buildWidget(BuildContext context) {
    log("screen size: ${MediaQuery.of(context).size.width}");
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(

            leading: const SizedBox(),
            backgroundColor: ColorName.primary2,
            centerTitle: true,
            elevation: 0,
            title: Padding(
              padding: EdgeInsets.only(top: isSmallScreen(context) ? 20 : 38.0),
              child: const Text("Vegas E-gaming Club",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  )),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    top: (isSmallScreen(context) ? 20 : 38.0), right: 10.0),
                child: GestureDetector(
                    onTap: () {
                      pushNamed(NotificationScreen.route);
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: 50,
                      height: 30,
                      child: Center(
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Container(
                                  color: Colors.transparent,
                                  child: const Icon(Icons.notifications)),
                              Consumer<NotificationScreenViewModel>(
                                  builder: (context, model, _) {
                                if (model.sumNotification == 0) {
                                  return const SizedBox();
                                }
                                return Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 13,
                                    height: 13,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: FittedBox(
                                          child: Text(
                                        model.sumNotification.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                    )),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                    )),
              )
            ],
            toolbarHeight: isSmallScreen(context) ? 80 : 90,
          ),
          body: Consumer<ProfileViewModel>(
            builder: (context, ProfileViewModel model, _) {
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
              }
              if (model.customerResponse == null) {
                return Center(child: loadingWidget());
              }
              return BaseSmartRefress(
                refreshController: _refreshController,
                onRefresh: () {
                  Provider.of<NotificationScreenViewModel>(context,
                          listen: false)
                      .getSumNotificationIsNotRead();
                  model.initData(context);
                  _refreshController.refreshCompleted();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (model.listSlideLevel.isNotEmpty)
                        SizedBox(
                          height: isSmallScreen(context) ? 90 : 150.0,
                          width: width(context),
                          child: Stack(
                            children: [
                              _itemCardLevel(model.listSlideLevel),
                              Positioned(
                                bottom: 0,
                                right: 10,
                                // left: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: model.listSlideLevel
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 6.0,
                                        height: 6.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.black87),
                                            shape: BoxShape.circle,
                                            color:
                                                model.currentIndex == entry.key
                                                    ? Colors.black87
                                                    : Colors.white),
                                      ),
                                    );
                                  }).toList(),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "Welcome, ${model.customerResponse?.title}. ${model.customerResponse != null ? model.customerResponse!.getUserName() : ""}  (${model.customerResponse?.number})",
                            //   style: TextStyle(
                            //       fontSize: isSmallScreen(context) ? 12 : 16.0,
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.w600),
                            // ),
                            Text.rich(
                              TextSpan(
                                  text: "Welcome,",
                                  style: TextStyle(
                                      fontSize:
                                          isSmallScreen(context) ? 12 : 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                        text:
                                            " ${model.customerResponse?.title}. ${model.customerResponse != null ? model.customerResponse!.getUserName() : ""}  (${model.customerResponse?.number})",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal))
                                  ]),
                            ),
                            Consumer<ApplicationViewmodel>(
                                builder: (context, appModel, _) {
                              List<SettingMenuResponse> settings = appModel
                                  .listSetting
                                  .where((e) => e.name == "card_info")
                                  .toList();
                              if (settings.isNotEmpty &&
                                  settings.first.value == 0) {
                                return const SizedBox();
                              }
                              return Column(
                                children: [
                                  SizedBox(
                                    height: isSmallScreen(context) ? 10.0 : 15,
                                  ),
                                  Container(
                                    height: 300,
                                    width: width(context),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical:
                                            isSmallScreen(context) ? 10 : 20.0),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(1,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: SizedBox(
                                          child: ClipRRect(
                                              clipBehavior: Clip.hardEdge,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: Image.asset(
                                                  pathImage,
                                                  fit: BoxFit.fill,
                                                  height: isSmallScreen(context)
                                                      ? 250
                                                      : null,
                                                ),
                                              )),
                                        )),
                                        const SizedBox(
                                          width: 16.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Consumer<ApplicationViewmodel>(
                                                  builder: (context, ref, _) {
                                                List<SettingMenuResponse>
                                                    settings = appModel
                                                        .listSetting
                                                        .where((e) =>
                                                            e.name ==
                                                            "account_balance")
                                                        .toList();
                                                if (settings.isNotEmpty &&
                                                    settings.first.value == 0) {
                                                  return const SizedBox();
                                                }
                                                return informationPoint(
                                                    context: context,
                                                    title: "Wallet",
                                                    value:
                                                        "\$${model.walletSum.toDecimal()}");
                                              }),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              informationPoint(
                                                context: context,
                                                title: "Points",
                                                value:
                                                    "${(model.memberShipPointResponse != null ? model.memberShipPointResponse!.loyaltyPointCurrent!.toDecimal().toString() : "0")} pts",
                                              ),
                                              SizedBox(
                                                height: isSmallScreen(context)
                                                    ? 10.0
                                                    : 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  buttonView2(
                                                      context: context,
                                                      onPressed: () {
                                                        pushNamed(
                                                            MembershipScreen
                                                                .route);
                                                      },
                                                      text: "View Detail"),
                                                ],
                                              ),
                                              if (isSmallScreen(context))
                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                            Consumer<ApplicationViewmodel>(
                                builder: (context, appModel, _) {
                              List<SettingMenuResponse> settings = appModel
                                  .listSetting
                                  .where((e) => e.name == "card_info")
                                  .toList();
                              if (settings.isNotEmpty &&
                                  settings.first.value == 0) {
                                return const SizedBox();
                              }
                              return Column(
                                children: [
                                  Container(
                                    height: isSmallScreen(context) ? 10 : 15.0,
                                    // color: Colors.grey.shade300,
                                  ),
                                  buildProgressLine(
                                      itemWidth: width(context),
                                      pointFrame:
                                          (model.memberShipPointResponse ==
                                                      null ||
                                                  model.memberShipPointResponse!
                                                          .framePoint ==
                                                      "N/A")
                                              ? 0
                                              : int.parse(model
                                                  .memberShipPointResponse!
                                                  .framePoint!)),
                                ],
                              );
                            }),
                            Container(
                              height: 10.0,
                              // color: Colors.grey.shade300,
                            ),
                            _listFunctionReservation(),
                            const SizedBox(
                              height: 20.0,
                            ),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _itemCardLevel(List<SlideLevelResponse> list) {
    if (list.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
      height: 375,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        carouselController: _controller,
        itemCount: list.length,
        options: CarouselOptions(
          height: 375,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 7),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          // onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            Provider.of<ProfileViewModel>(context, listen: false)
                .setIndexSlide(index);
          },
        ),
        itemBuilder: (context, index, realIndex) {
          return Image.network(
            Utils.getImageFromId(list[index].attachmentId!),
            fit: BoxFit.cover,
            // width: MediaQuery.of(context).size.width,
            // height: 400.0,
          );
        },
      ),
    );
  }

  Widget _listFunctionReservation() {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: isSmallScreen(context) ? 10 : 15,
      mainAxisSpacing: isSmallScreen(context) ? 10 : 15,
      childAspectRatio: 2.8,
      crossAxisCount: 2,
      children: [
        _itemReservation(
            imageName: Assets.icons_ic_machine_reservation.path,
            title: "Machine\nReservation\nInformation",
            onTap: () {
              pushNamed(MachineReservationScreen.routeName);
            }),
        _itemReservation(
            imageName: Assets.icons_ic_drink_food.path,
            title: "Food\nDrink",
            onTap: () {
              pushNamed(FoodReservationScreen.route);
            }),
        _itemReservation(
            imageName: Assets.icons_ic_car_booking_png.path,
            title: "Car\nBooking",
            onTap: () {
              pushNamed(ListCarBookingScreen.routeName);
            }),
        _itemReservation(
            imageName: Assets.icons_ic_host_hot_line.path,
            title: "Host\nHotLine",
            onTap: () {
              pushNamed(HostScreen.route, arguments: true);
            }),
      ],
    );
  }

  Widget _itemReservation(
      {String? imageName, String? title, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: width(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          // height: 70.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          width: 90.0,
          height: 90.0,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallScreen(context) ? 10 : 14),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: isSmallScreen(context) ? 30 : 35.0,
                  width: isSmallScreen(context) ? 30 : 35.0,
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
