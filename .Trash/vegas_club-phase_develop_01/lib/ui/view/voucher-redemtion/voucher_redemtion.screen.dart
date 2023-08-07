import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/ui/share_widget/button_custom.widget.dart';
import 'package:vegas_club/ui/share_widget/input_field.widget.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/ui/view/voucher-redemtion/voucher_redemtion.widget.dart';

class VoucherRedemtionScreen extends StateFullConsumer {
  const VoucherRedemtionScreen({Key? key}) : super(key: key);

  @override
  _VoucherRedemtionScreenState createState() => _VoucherRedemtionScreenState();
}

class _VoucherRedemtionScreenState
    extends StateConsumer<VoucherRedemtionScreen> {
  late TextEditingController voucherEdittingController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initStateWidget() {
    voucherEdittingController = TextEditingController();
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
        appBar: appBarBottomBar(_scaffoldKey,
            context: context, title: "Voucher redemption", onClose: () {
          pop();
        }),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: animationItemWidget(
                        postion: 1, child: userInformationBar(null)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  creaditReviewWidget('5,001'),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: informationCreadit(
                            context: context,
                            title: 'Your Credit Point',
                            value: '5,001'),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: informationCreadit(
                            context: context,
                            title: 'Exchangeable Amount',
                            value: "50"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Container(
              height: 5.0,
              color: Colors.grey.shade300,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: const EdgeInsets.only(left: 17, right: 17, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Exchange Point',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 40.0,
                              child: CustomInputFieldNoLabel(
                                textEditingController:
                                    voucherEdittingController,
                              ),
                            )),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                            child: SizedBox(
                          height: 40.0,
                          child: CustomButtonWidget(
                              text: 'Redemption', onPressed: () {}),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      '*Points can be exchanged in increments of 5,000',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
