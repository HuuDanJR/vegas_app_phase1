import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/models/response/membership_point_response.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';

enum TypeReservation {
  car,
  food,
  machineSlot,
}

Widget informationPoint(
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
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen(context) ? 14 : 16),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          "$text",
          style: TextStyle(
              fontSize: isSmallScreen(context) ? 18 : 22.0,
              color: ColorName.primary2,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget itemInformationMembership(
    {String? title, dynamic value, bool? showBottomBorder = true}) {
  dynamic text = 0;
  if (value != null) {
    if (value is int || value is double) {
      text = value.toString();
    } else {
      text = value;
    }
  }
  return Container(
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: showBottomBorder == true
                    ? Colors.black12
                    : Colors.transparent))),
    height: 50.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        (text is int)
            ? TextCountNumber(
                numberPoint: text,
                style: const TextStyle(color: Colors.black),
              )
            : Text(
                text,
                style: const TextStyle(color: Colors.black),
              ),
      ],
    ),
  );
}

Widget totalInformationMembership(
    BuildContext context,
    CustomerResponse? customerResponse,
    MemberShipPointResponse memberShipPointResponse) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(1, 2), // changes position of shadow
        ),
      ],
      borderRadius: BorderRadius.circular(6.0),
      // border: Border.all(width: 1, color: Colors.black26),
    ),
    child: Column(
      children: [
        itemInformationMembership(
            title: "Wallet", value: memberShipPointResponse.wallet),
        itemInformationMembership(
            title: "Fortune Credit",
            value: memberShipPointResponse.fortuneCredit!.toDecimal()),
        itemInformationMembership(
            title: "Membership Period",
            value: customerResponse?.getMemberShipPeriod()),
        itemInformationMembership(
            title: "Membership Point",
            value: customerResponse?.getMembershipPoint()),
        itemInformationMembership(
            title: "Credit Point",
            value: memberShipPointResponse.creditPoint?.toDecimal()),
        itemInformationMembership(title: "Caravell", value: "25092"),
        itemInformationMembership(
            title: "Point Pyramid Point",
            value: memberShipPointResponse.loyaltyPointWeekly?.toDecimal(),
            showBottomBorder: false),
      ],
    ),
  );
}

class MBSPoint extends StatelessWidget {
  const MBSPoint({Key? key, this.point}) : super(key: key);
  final int? point;
  @override
  Widget build(BuildContext context) {
    return _pointReviewWidget(point!);
  }

  Widget _pointReviewWidget(int point) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Lottie.asset(Assets.lottie_circle, fit: BoxFit.fitHeight),
          Positioned(
            child: Container(
              height: 100,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(65)),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: 80,
                    child: Center(
                      child: FittedBox(
                        child: TextCountNumber(
                          numberPoint: point,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    'MBS point',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
