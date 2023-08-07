import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/response/setting_menu_response.dart';
import 'package:vegas_club/ui/view/booking-status-screen/list_car_booking.screen.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/food_reservation.screen.dart';
import 'package:vegas_club/ui/view/host-screen/host.screen.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';
import 'package:vegas_club/ui/view/machine-reservation-screen/machine_reservation.screen.dart';
import 'package:vegas_club/ui/view/member-ship-screen/member_ship.screen.dart';
import 'package:vegas_club/ui/view/point-pyramid-screen/point_pyramid.screen.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/jackpot_page.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/promo.screen.dart';
import 'package:vegas_club/ui/view/roulette-screen/roulette.screen.dart';
import 'package:vegas_club/ui/view/user-screen/user.screen.dart';
import 'package:vegas_club/ui/view/voucher-list-screen/voucher_list.screen.dart';
import 'package:vegas_club/view_model/application.viewmodel.dart';
import 'package:vegas_club/view_model/login_screen.viewmodel.dart';

class ModalCustomBottomSheet extends StatefulWidget {
  const ModalCustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<ModalCustomBottomSheet> createState() => _ModalCustomBottomSheetState();
}

class _ModalCustomBottomSheetState extends State<ModalCustomBottomSheet>
    with AutomaticKeepAliveClientMixin, BaseFunction {
  @override
  void initState() {
    Provider.of<LoginScreenViewModel>(context, listen: false).getProfile();
    Provider.of<ApplicationViewmodel>(context, listen: false).getSettingMenu();
    super.initState();
  }

  Widget profileWidget(LoginScreenViewModel model) {
    return Container(
      height: 110,
      color: ColorName.primary,
      child: Row(children: [
        const SizedBox(
          width: 16.0,
        ),
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: isSmallScreen(context) ? 70 : 90,
            height: isSmallScreen(context) ? 70 : 90,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: Utils.getImageFromId(
                  model.customerResponse?.attachmentId ?? -1),
              placeholder: (context, url) => CircularProgressIndicator(
                color: Colors.grey.shade300,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.customerResponse == null
                  ? ""
                  : model.customerResponse!.getUserName(),
              style: TextStyle(
                  fontSize: isSmallScreen(context) ? 18 : 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            GestureDetector(
              onTap: () {
                pushNamed(UserScreen.routeName);
              },
              child: Row(
                children: [
                  Text(
                    "Account Information",
                    style: TextStyle(
                      fontSize: isSmallScreen(context) ? 16 : 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      // height: height(context) * 0.87,
      width: width(context),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Consumer<ApplicationViewmodel>(builder: (context, appModel, _) {
        List<SettingMenuResponse> settingsPromotion =
            appModel.listSetting.where((e) => e.name == "promotion").toList();
        List<SettingMenuResponse> settingsVoucher =
            appModel.listSetting.where((e) => e.name == "voucher").toList();
        List<SettingMenuResponse> settingsJackpot =
            appModel.listSetting.where((e) => e.name == "Jackpot").toList();
        List<SettingMenuResponse> settingsPyramid = appModel.listSetting
            .where((e) => e.name == "point_pyramid")
            .toList();
        List<SettingMenuResponse> settingsStreaming =
            appModel.listSetting.where((e) => e.name == "streaming").toList();
        List<SettingMenuResponse> settingsMembership =
            appModel.listSetting.where((e) => e.name == "member_ship").toList();
        return Consumer<LoginScreenViewModel>(
          builder: (context, model, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pop();
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                profileWidget(model),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Vegas Service",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: isSmallScreen(context) ? 14 : 16.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      // crossAxisSpacing: 5,
                      // mainAxisSpacing: 5,
                      childAspectRatio: 1,
                      crossAxisCount: 3,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pushNamed(ListCarBookingScreen.routeName);
                          },
                          child: _iconService(
                              Assets.icons_ic_car_booking_png.path,
                              "Car Booking",
                              100),
                        ),
                        GestureDetector(
                          onTap: () {
                            pushNamed(MachineReservationScreen.routeName);
                          },
                          child: _iconService(
                              Assets.icons_ic_machine_reservation.path,
                              "Machine Reservation Information",
                              100),
                        ),
                        GestureDetector(
                          onTap: () {
                            pushNamed(FoodReservationScreen.route);
                          },
                          child: _iconService(Assets.icons_ic_drink_food.path,
                              "Food & Drink", 100),
                        ),
                        if (settingsPromotion.isNotEmpty &&
                            settingsPromotion.first.value == 1)
                          GestureDetector(
                              onTap: () {
                                pushNamed(PromoScreen.routeName);
                              },
                              child: _iconService(
                                  Assets.icons_ic_promotion.path,
                                  "Promotions",
                                  20)),
                        if (settingsVoucher.isNotEmpty &&
                            settingsVoucher.first.value == 1)
                          GestureDetector(
                              onTap: () {
                                pushNamed(VoucherListScreen.route);
                              },
                              child: _iconService(Assets.icons_ic_voucher.path,
                                  "Vouchers", 20)),
                        // GestureDetector(
                        //     onTap: () {
                        //       pushNamed(CouponListScreen.route);
                        //     },
                        //     child: _iconService(
                        //         Assets.icons.icCoupon.path, "Coupons", 20)),
                        if (settingsJackpot.isNotEmpty &&
                            settingsJackpot.first.value == 1)
                          GestureDetector(
                              onTap: () {
                                pushNamed(Jackpotpage.route);
                              },
                              child: _iconService(
                                  Assets.icons_ic_jackpot.path, "Jackpot", 20)),
                        if (settingsPyramid.isNotEmpty &&
                            settingsPyramid.first.value == 1)
                          GestureDetector(
                            onTap: () {
                              pushNamed(PointPyramidScreen.route);
                            },
                            child: _iconService(
                                Assets.icons_ic_point_pyramid.path,
                                "Point Pyramid",
                                20),
                          ),
                        if (settingsStreaming.isNotEmpty &&
                            settingsStreaming.first.value == 1)
                          GestureDetector(
                            onTap: () {
                              pushNamed(RouletteScreen.routeName);
                            },
                            child: _iconService(
                                Assets.icons_ic_routlet_streaming.path,
                                "Routelle Streaming",
                                20),
                          ),
                        GestureDetector(
                          onTap: () {
                            pushNamed(HostScreen.route, arguments: true);
                          },
                          child: _iconService(
                              Assets.icons_ic_host_hot_line.path,
                              "Host Hotline",
                              20),
                        ),
                        if (settingsMembership.isNotEmpty &&
                            settingsMembership.first.value == 1)
                          GestureDetector(
                              onTap: () {
                                pushNamed(MembershipScreen.route);
                              },
                              child: _iconService(
                                  Assets.icons_ic_membership.path,
                                  "Membership",
                                  20)),
                        GestureDetector(
                            onTap: () {
                              model.logout(onSucess: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LoginScreen()),
                                    ModalRoute.withName('/'));
                              });
                            },
                            child: _iconService(
                                Assets.icons_ic_logout_png.path, "Logout", 20)),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }

  Widget _iconService(String pathIcon, String title, double radius) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: isSmallScreen(context) ? 55 : 70,
          width: isSmallScreen(context) ? 55 : 70,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: const Color.fromARGB(73, 121, 85, 72)),
              borderRadius: BorderRadius.circular(radius)),
          child: Center(
              child: Image.asset(
            pathIcon,
            // width: 40,
          )),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: isSmallScreen(context) ? 10 : 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
