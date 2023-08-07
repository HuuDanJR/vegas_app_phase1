import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/ui/view/booking-status-screen/list_car_booking.screen.dart';
import 'package:vegas_club/ui/view/food-reservation-screen/food_reservation.screen.dart';
import 'package:vegas_club/ui/view/host-screen/host.screen.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';
import 'package:vegas_club/ui/view/machine-reservation-screen/machine_reservation.screen.dart';
import 'package:vegas_club/ui/view/point-pyramid-screen/point_pyramid.screen.dart';
import 'package:vegas_club/ui/view/roulette-screen/roulette.screen.dart';
import 'package:vegas_club/ui/view/voucher-list-screen/voucher_list.screen.dart';
import 'package:vegas_club/view_model/login_screen.viewmodel.dart';

Widget buttonDrawer(
    GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
  return InkWell(
    onTap: () {
      // _scaffoldKey.currentState!.openDrawer();
      Scaffold.of(context).openDrawer();
    },
    child: const Icon(
      Icons.menu,
      color: Colors.white,
    ),
  );
}

class DrawableWidget extends StatefulWidget {
  const DrawableWidget({Key? key, this.onRouteToScreen}) : super(key: key);
  final Function(Widget)? onRouteToScreen;

  @override
  State<DrawableWidget> createState() => _DrawableWidgetState();
}

class _DrawableWidgetState extends State<DrawableWidget>
    with AutomaticKeepAliveClientMixin, BaseFunction {
  CustomerResponse? _customerResponse;
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  Future<void> getProfile() async {
    _customerResponse = await ProfileUser.getProfile();
    setState(() {});
    print(_customerResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: ColorName.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(40)),
                        child: avataCircle(_customerResponse != null
                            ? _customerResponse!.attachmentId ?? -1
                            : -1),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ('${_customerResponse?.surname ?? ''} ${_customerResponse?.forename ?? ''}')
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          // Text(
                          //   'Silver',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 18,
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            // itemDrawer('Membership information', () {
            //   widget.onRouteToScreen!(ProfileScreen());
            // }),
            itemDrawer('Car reservation', () {
              widget.onRouteToScreen!(const ListCarBookingScreen());
            }),
            itemDrawer('Machine reservation', () {
              widget.onRouteToScreen!(const MachineReservationScreen());
            }),
            itemDrawer('Food and Drink reservation', () {
              widget.onRouteToScreen!(const FoodReservationScreen());
            }),
            // itemDrawer('Coupon', () {
            //   widget.onRouteToScreen!(CouponListScreen());
            // }),
            itemDrawer('Host hotline', () {
              widget.onRouteToScreen!(const HostScreen());
            }),
            // itemDrawer('Message', () {
            //   widget.onRouteToScreen!(MessageScreen());
            // }),
            itemDrawer('My point Pyramid', () {
              widget.onRouteToScreen!(const PointPyramidScreen());
            }),
            itemDrawer('My voucher', () {
              widget.onRouteToScreen!(const VoucherListScreen());
            }),
            // itemDrawer('Voucher redemption', () {
            //   widget.onRouteToScreen!(VoucherRedemtionScreen());
            // }),
            // itemDrawer('Notification', () {
            //   widget.onRouteToScreen!(NotificationScreen());
            // }),
            itemDrawer('Routette', () {
              widget.onRouteToScreen!(const RouletteScreen());
            }),
            // itemDrawer('Setting', () {}),
            Consumer<LoginScreenViewModel>(
              builder: (BuildContext context, LoginScreenViewModel model,
                  Widget? child) {
                return itemDrawer('Logout', () {
                  model.logout(onSucess: () {
                    locator
                        .get<CommonService>()
                        .replaceToRoute(LoginScreen.route);
                    // pushNamed(MyWidget.routeName);
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget itemDrawer(String itemName, Function()? onTap) {
    return InkWell(
      focusColor: Colors.black12,
      onTap: onTap!,
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemName,
                  style: const TextStyle(color: Colors.black),
                ),
                const Icon(
                  Icons.arrow_right_outlined,
                  color: Colors.black54,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
