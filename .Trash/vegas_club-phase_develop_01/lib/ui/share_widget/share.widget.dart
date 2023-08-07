import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/share_widget/drawable.widget.dart';
import 'package:vegas_club/ui/view/notification-screen/notification.screen.dart';
import 'package:vegas_club/view_model/notification_screen.viewmodel.dart';

Widget loadingWidget() {
  return const Center(
    child: Column(
      children: [
        Stack(
          children: [
            SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  // valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  color: Color.fromRGBO(255, 41, 92, 1),
                  backgroundColor: Color.fromRGBO(224, 224, 224, 1),
                )),
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   top: 0,
            //   bottom: 0,
            //   child: Center(
            //     child: Image.asset(
            //       Assets.logo_logo_renew.path,
            //       width: 60,
            //       height: 60,
            //     ),
            //   ),
            // )
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
          'Loading...',
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
      ],
    ),
  );
}

Widget animationItemWidget({required int? postion, required Widget? child}) {
  return AnimationLimiter(
    child: AnimationConfiguration.staggeredList(
      delay: const Duration(milliseconds: 250),
      position: postion!,
      child: SlideAnimation(
          horizontalOffset: 44, child: FadeInAnimation(child: child!)),
    ),
  );
}

class AppBarCustomer extends StatefulWidget {
  const AppBarCustomer({Key? key}) : super(key: key);

  @override
  State<AppBarCustomer> createState() => _AppBarCustomerState();
}

class _AppBarCustomerState extends State<AppBarCustomer> {
  @override
  void initState() {
    Provider.of<NotificationScreenViewModel>(context, listen: false)
        .getListNotification(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return appBarBottomBar(context: context);
  }

  AppBar appBarBottomBar(
      {required BuildContext context, String? title, List<Widget>? actions}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.clear,
          color: Colors.black45,
        ),
      ),
      title: TextWidget(
        text: title ?? "",
        style: const TextStyle(
          color: Colors.black38,
        ),
      ),
      actions: actions,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black26,
            height: 1.0,
          )),
    );
  }
}

Widget LoadingWidget() {
  return Lottie.asset(Assets.lottie_loading);
}

AppBar appBarBottomBar(GlobalKey<ScaffoldState> scaffoldKey,
    {required BuildContext context,
    String? title,
    List<Widget>? actions,
    bool? isOpenDrawer = false,
    void Function()? onClose}) {
  return AppBar(
    elevation: 0,
    // toolbarHeight: 80.0,
    backgroundColor: ColorName.primary2,
    // shadowColor: Colors.transparent,
    leading: isOpenDrawer!
        ? buttonDrawer(scaffoldKey, context)
        : onClose == null
            ? const SizedBox()
            : InkWell(
                onTap: onClose,
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
    title: TextWidget(
      text: title ?? "",
      style: const TextStyle(color: Colors.white, fontSize: 18.0),
    ),
    actions: actions ?? [notificationAction(context)],
    // bottom: PreferredSize(
    //     child: Container(
    //       color: Colors.black26,
    //       height: 1.0,
    //     ),
    //     preferredSize: Size.fromHeight(4.0)),
  );
}

Widget notificationAction(BuildContext context) {
  return Consumer<NotificationScreenViewModel>(
    builder: (BuildContext context, NotificationScreenViewModel model,
        Widget? child) {
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: buttonNotification(
            onTapNotification: () {
              locator.get<CommonService>().navigatoToRoute(
                  Utils.createRouteBottomToTop(const NotificationScreen()));
            },
            amount: model.listNotification!.length),
      );
    },
  );
}

Widget buttonNotification({Function()? onTapNotification, int? amount = 0}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          InkWell(
            onTap: onTapNotification,
            child: Icon(
              (amount != null && amount != 0)
                  ? Icons.notifications_active
                  : Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
          ),
          amount == 0
              ? const SizedBox()
              : Positioned(
                  right: 0,
                  child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: const SizedBox()
                      //  FittedBox(
                      //   child: Padding(
                      //     padding: EdgeInsets.all(2.0),
                      //     child: Text(
                      //       amount > 99 ? '+99' : amount.toString(),
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      ),
                )
        ],
      ),
    ],
  );
}

Widget userInformationBar(CustomerResponse? customerResponse) {
  return Container(
    padding: const EdgeInsets.only(top: 10.0),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black12),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Vegas'),
              Text('Vegas caravel saigon'),
            ],
          ),
        ),
        const Divider(),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customerResponse?.membershipTypeName ?? ''),
                  // Text("SIGNATURE"),
                ],
              ),
              const Divider(),
              Column(
                children: [
                  Text(customerResponse != null
                      ? customerResponse.number.toString()
                      : "0")
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget bannelRouletteWheel(BuildContext context) {
  return const SizedBox();
  // return SizedBox(
  //   width: MediaQuery.of(context).size.width,
  //   child: Stack(
  //     children: [
  //       Positioned(
  //         bottom: 0,
  //         child: Container(
  //           width: MediaQuery.of(context).size.width,
  //           padding: EdgeInsets.only(left: 170, bottom: 10.0),
  //           height: 60.0,
  //           decoration: BoxDecoration(color: Colors.grey),
  //           child: Row(
  //             children: [
  //               Text(
  //                 'Check real time\nRoulette winning number!',
  //                 style: TextStyle(color: Colors.white),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       Positioned(
  //         child: SizedBox(
  //             height: 85.0,
  //             width: 160,
  //             child: Image.asset(Assets.image.routelletWheel.path)),
  //       ),
  //     ],
  //   ),
  // );
}

Widget avataCircle(int id) {
  return ClipOval(
    child: CachedNetworkImage(
      imageUrl: Utils.getImageFromId(id) + "?version=medium",
      placeholder: (context, url) => CircularProgressIndicator(
        color: Colors.grey.shade300,
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          Assets.image_host_placeholder.path,
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        ),
      ),
      fit: BoxFit.cover,
    ),
  );
}

class TextCountNumber extends StatefulWidget {
  const TextCountNumber({Key? key, required this.numberPoint, this.style})
      : super(key: key);
  final int numberPoint;
  final TextStyle? style;
  @override
  State<TextCountNumber> createState() => _TextCountNumberState();
}

class _TextCountNumberState extends State<TextCountNumber> {
  int _point = 0;
  Timer? timer;
  @override
  void initState() {
    _point = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      if (_point < widget.numberPoint) {
        double count = widget.numberPoint / 50;
        timer = Timer.periodic(const Duration(milliseconds: 50), (time) {
          if (_point == widget.numberPoint) {
            timer!.cancel();
          }
          setState(() {
            _point = _point + count.toInt();
            if (_point > (widget.numberPoint / 3)) {
              _point = widget.numberPoint;
              timer!.cancel();
            }
          });
        });
      }
    }
    return Text(
      NumberFormat.decimalPattern().format(_point),
      style: widget.style,
    );
  }
}
