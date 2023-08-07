import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/ui/view/coupon-list-screen/coupon_list.widget.dart';

class CouponListScreen extends StateFullConsumer {
  const CouponListScreen({Key? key}) : super(key: key);
  static const String route = '/coupon-list-screen';
  @override
  _CouponListScreenState createState() => _CouponListScreenState();
}

class _CouponListScreenState extends StateConsumer<CouponListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            title: const Text("Coupon"),
            backgroundColor: ColorName.yellowBrown,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  itemCoupon(context),
                  itemCoupon(context),
                  itemCoupon(context),
                  itemCoupon(context),
                  itemCoupon(context),
                ],
              ),
            ),
          )),
    );
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
