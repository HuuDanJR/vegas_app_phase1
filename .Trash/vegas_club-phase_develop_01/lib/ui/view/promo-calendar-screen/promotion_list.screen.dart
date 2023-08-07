import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/models/promo_request.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/detail_promotion_v2.screen.dart';

class PromotionListScreen extends StatefulWidget {
  static const String routeName = "promotion_list_screen";
  const PromotionListScreen({super.key, this.promotions});
  final List<PromotionDetailModel>? promotions;
  @override
  State<PromotionListScreen> createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends State<PromotionListScreen>
    with BaseFunction {
  List<PromotionDetailModel>? listPromotions = [];

  @override
  void initState() {
    listPromotions = widget.promotions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            pop();
          },
          child: const Icon(
            Icons.clear_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'PROMO LIST',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: listPromotions!.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemPromotion(listPromotions![index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.grey,
          );
        },
      ),
    );
  }

  Widget _itemPromotion(PromotionDetailModel promotionDetailModel) {
    return GestureDetector(
      onTap: () {
        pushNamed(DetailPromotionV2Screen.routeName,
            arguments: promotionDetailModel);
      },
      child: Container(
        color: Colors.transparent,
        child: Row(children: [
          Expanded(
            child: Container(
              height: 100,
              width: 237,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        Utils.getImageFromId(
                            promotionDetailModel.attachmentId!),
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: fromCssColor(
                                promotionDetailModel.color ?? '#fff')),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(promotionDetailModel.name ?? ''),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
