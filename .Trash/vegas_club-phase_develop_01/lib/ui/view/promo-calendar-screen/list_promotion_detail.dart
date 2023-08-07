import 'package:flutter/material.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/promo_request.dart';
import 'package:vegas_club/ui/view/promo-calendar-screen/detail_promotion.screen.dart';

class ListPromotionDetial extends StateFullConsumer {
  const ListPromotionDetial({super.key, this.listWidget});
  static const String routeName = "./list_promotion_detail";
  final List<PromotionDetailModel>? listWidget;
  @override
  StateConsumer<ListPromotionDetial> createState() =>
      _ListPromotionDetialState();
}

class _ListPromotionDetialState extends StateConsumer<ListPromotionDetial>
    with BaseFunction {
  List<PromotionDetailModel> _listWidget = [];
  @override
  void initStateWidget() {
    if (widget.listWidget != null) {
      _listWidget = widget.listWidget!;
    }
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
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
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                pop();
              },
              child: const Icon(Icons.clear)),
          backgroundColor: ColorName.primary2,
          centerTitle: true,
          elevation: 0,
          title: const Text("Promotion Detail",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              )),
          // toolbarHeight: 80,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ListView.separated(
            itemCount: _listWidget.length,
            itemBuilder: (context, index) {
              return _promotionNote(_listWidget[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _promotionNote(PromotionDetailModel promotionDetailModel) {
    return Card(
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: 30,
                    child: Image.network(
                      Utils.getImageFromId(promotionDetailModel.attachmentId!),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      promotionDetailModel.name ?? '',
                      style: const TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            buttonView(
                height: 30.0,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPromotionScreen(
                            data: {
                              "term": promotionDetailModel.term,
                              "prize": promotionDetailModel.prize,
                            },
                          )));
                },
                text: "view",
                backgroundColor: ColorName.primary),
          ],
        ),
      ),
    );
  }
}
