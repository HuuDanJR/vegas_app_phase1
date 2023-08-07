import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/models/promo_request.dart';

class DetailPromotionV2Screen extends StateFullConsumer {
  const DetailPromotionV2Screen({Key? key, required this.promotionDetailModel})
      : super(key: key);
  static const String routeName = "detail_promotion_v2_screen";
  final PromotionDetailModel promotionDetailModel;
  @override
  StateConsumer<DetailPromotionV2Screen> createState() =>
      _DetailPromotionV2ScreenState();
}

class _DetailPromotionV2ScreenState
    extends StateConsumer<DetailPromotionV2Screen> with BaseFunction {
  PromotionDetailModel? _promotionDetailModel;
  @override
  void initStateWidget() {
    _promotionDetailModel = widget.promotionDetailModel;
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: GestureDetector(
            onTap: () {
              pop();
            },
            child: const Icon(
              Icons.clear_rounded,
              color: Colors.black,
            )),
        title: Text(
          _promotionDetailModel?.name ?? '',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border:
                      const Border(bottom: BorderSide(width: 1, color: Colors.grey)),
                  image: DecorationImage(
                      image: NetworkImage(Utils.getImageFromId(
                          _promotionDetailModel!.attachmentId ?? -1)))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: fromCssColor(
                                _promotionDetailModel!.color ?? '#fff')),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(_promotionDetailModel!.name ?? ''),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Term: ",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
                width: width(context),
                child: HtmlWidget(
                  _promotionDetailModel!.term ?? 'No data',
                  customStylesBuilder: (element) {
                    return {'color': 'black'};
                  },
                )),
            const SizedBox(
              height: 16.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Prize: ",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
                width: width(context),
                child: HtmlWidget(
                  _promotionDetailModel!.prize ?? 'No data',
                  customStylesBuilder: (element) {
                    return {'color': 'black'};
                  },
                )),
          ],
        ),
      ),
    );
  }
}
