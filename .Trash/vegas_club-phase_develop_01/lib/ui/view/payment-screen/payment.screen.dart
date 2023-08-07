import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';

class PaymentScreen extends StateFullConsumer {
  const PaymentScreen({Key? key}) : super(key: key);
  static const String route = '/payment-screen';
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends StateConsumer<PaymentScreen> {
  var textController = TextEditingController();

  List<String> listImageLog = [
    Assets.logo_image_1.path,
    Assets.logo_image_2.path,
    Assets.logo_image_3.path,
    Assets.logo_image_4.path,
    Assets.logo_image_5.path,
    Assets.logo_image_6.path,
    Assets.logo_image_7.path,
    Assets.logo_image_8.path,
  ];
  @override
  void initStateWidget() {
    textController = TextEditingController(text: '@');
  }
  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  Widget buildWidget(BuildContext context) {
    var focusNode = FocusNode();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      scale: 1,
                      image: AssetImage(Assets.image_q_r_code.path),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: ColorName.primary,
                      height: 5,
                    )),
                    const Text('ENJOY WITH'),
                    Expanded(
                        child: Container(
                      color: ColorName.primary,
                      height: 5,
                    )),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 2.5),
                      itemCount: listImageLog.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(listImageLog[index]))),
                        );
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
