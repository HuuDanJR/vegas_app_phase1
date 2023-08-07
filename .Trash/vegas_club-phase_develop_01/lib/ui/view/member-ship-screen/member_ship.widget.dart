import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';

class RoadMapLevelModel {
  final String? imageCartPath;
  final String? note;

  RoadMapLevelModel({this.imageCartPath, this.note});
}

class LevelRoadMap extends StatefulWidget {
  const LevelRoadMap({super.key});

  @override
  State<LevelRoadMap> createState() => _LevelRoadMapState();
}

class _LevelRoadMapState extends State<LevelRoadMap> with BaseFunction {
  List<RoadMapLevelModel> listImageCard = [
    RoadMapLevelModel(
        imageCartPath: Assets.image_vegas_membership_p_1.path, note: ""),
    RoadMapLevelModel(
        imageCartPath: Assets.image_vegas_membership_i_1.path,
        note: "20.000 Point to qualify"),
    RoadMapLevelModel(
        imageCartPath: Assets.image_vegas_membership_v_1.path,
        note: "100.000 Point to qualify"),
    RoadMapLevelModel(
        imageCartPath: Assets.image_vegas_membership_one_1.path,
        note: "320.000 Point to qualify"),
    RoadMapLevelModel(
        imageCartPath: Assets.image_vegas_membership_one_plus_1.path,
        note: "1.000.000 Point to qualify"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      height: 450,
      width: width(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              "Level Road Map",
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          CarouselSlider.builder(
            itemCount: listImageCard.length,
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            itemBuilder: (context, index, realIndex) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset(
                        listImageCard[index].imageCartPath!,
                        height: 400.0,
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    listImageCard[index].note!,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

double dividerNum = 4.4;

Widget buildProgressLine({double? itemWidth, int? pointFrame}) {
  return Column(
    children: [
      Container(
          width: itemWidth,
          height: 25,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: buildItemProgress(
                  color: const Color(0xFFAE9E7D).withOpacity(.25),
                  itemWidth: itemWidth,
                  maxValue: 20000,
                  minValue: 0,
                  point_frame: pointFrame,
                ),
              ),
              Expanded(
                child: buildItemProgress(
                  color: const Color(0xFF87898B).withOpacity(.25),
                  itemWidth: itemWidth,
                  maxValue: 100000,
                  minValue: 20000,
                  point_frame: pointFrame,
                ),
              ),
              Expanded(
                child: buildItemProgress(
                  color: const Color(0xFFFFBD31).withOpacity(.25),
                  itemWidth: itemWidth,
                  maxValue: 320000,
                  minValue: 100000,
                  point_frame: pointFrame,
                ),
              ),
              Expanded(
                child: buildItemProgress(
                  color: const Color(0xFFDC0025).withOpacity(.25),
                  itemWidth: itemWidth,
                  maxValue: 1000000,
                  minValue: 320000,
                  point_frame: pointFrame,
                ),
              ),
            ],
          )),
      Container(
        width: itemWidth,
        height: 32.0, //32
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            buildTextCol(itemWidth: itemWidth, level: 'P', point: '0 pts'),
            buildTextCol(itemWidth: itemWidth, level: 'I', point: '20,000 pts'),
            buildTextCol(
                itemWidth: itemWidth, level: 'V', point: '100,000 pts'),
            Container(
                color: Colors.transparent,
                width: itemWidth! / 4,
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "One",
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontFamily.quicksand),
                          ),
                          Text(
                            "320,000 pts",
                            style: TextStyle(
                                fontSize: 8.5,
                                color: Colors.black,
                                fontFamily: FontFamily.quicksand),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "One+",
                            style: TextStyle(
                                fontSize: 11,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: FontFamily.quicksand),
                          ),
                          Text(
                            "1,000,000 pts",
                            style: TextStyle(
                                fontSize: 8.5,
                                color: Colors.black,
                                fontFamily: FontFamily.quicksand),
                          ),
                        ],
                      ),
                    ])),
          ],
        ),
      )
    ],
  );
}

Widget buildItemProgress(
    {point_frame, itemWidth, int? minValue, int? maxValue, color}) {
  return Container(
    decoration: BoxDecoration(
        color: color,
        border: const Border(left: BorderSide(color: Colors.grey, width: 1))),
    width: itemWidth / 4.4,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: point_frame >= minValue && point_frame < maxValue
                ? const Color.fromRGBO(192, 154, 53, 1)
                : point_frame > maxValue
                    ? const Color.fromRGBO(192, 154, 53, 1)
                    : Colors.transparent,
          ),
          width: point_frame >= minValue && point_frame < maxValue
              ? itemWidth / 4.4 * (point_frame / maxValue)
              : itemWidth / 4.4,
        ),
      ],
    ),
  );
}

Widget buildTextCol({itemWidth, level, point}) {
  return Container(
    color: Colors.transparent,
    width: itemWidth / 4.4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$level",
          style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              height: 1.5,
              fontFamily: FontFamily.quicksand),
        ),
        Text(
          "$point",
          style: const TextStyle(
              fontSize: 8.5,
              color: Colors.black,
              fontFamily: FontFamily.quicksand),
        ),
      ],
    ),
  );
}

Widget memberShipWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 8.0,
      ),
      _itemTitleMemship(titleLevel: " P Level ", descriptionLevel: "(Ivory)"),
      const Text(
        "Free join for new member",
        style: TextStyle(fontSize: 14.0),
      ),
      const Divider(
        color: Colors.black,
      ),
      _itemTitleMemship(titleLevel: " I Level ", descriptionLevel: "(Sliver)"),
      const SizedBox(
        height: 10.0,
      ),
      GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _itemIconMemberShip(
              Assets.icons_ic_birthday_offer.path, "Birthday offer"),
          _itemIconMemberShip(
              Assets.icons_ic_free_hotel_room.path, "Free hotel room"),
          _itemIconMemberShip(
              Assets.icons_ic_buffet_spa.path, "Free spa voucher"),
          _itemIconMemberShip(
              Assets.icons_ic_limousine_service.path, "Limousine service"),
          _itemIconMemberShip(
              Assets.icons_ic_promotion_advantage.path, "Promotion advance"),
        ],
      ),
      const Divider(
        color: Colors.black,
      ),
      _itemTitleMemship(titleLevel: " V Level ", descriptionLevel: "(Gold)"),
      const SizedBox(
        height: 10.0,
      ),
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _itemIconMemberShip(
              Assets.icons_ic_birthday_offer.path, "Birthday offer"),
          _itemIconMemberShip(
              Assets.icons_ic_flight_ticket.path, "Free flight ticket"),
          _itemIconMemberShip(
              Assets.icons_ic_free_hotel_room.path, "Free hotel room"),
          _itemIconMemberShip(
              Assets.icons_ic_buffet_spa.path, "Free spa voucher"),
          _itemIconMemberShip(
              Assets.icons_ic_limousine_service.path, "Limousine service"),
          _itemIconMemberShip(
              Assets.icons_ic_promotion_advantage.path, "Promotion advance"),
        ],
      ),
      const Divider(
        color: Colors.black,
      ),
      _itemTitleMemship(
          titleLevel: " One Level & One Plus Level ",
          descriptionLevel: "(Red)"),
      const SizedBox(
        height: 10.0,
      ),
      GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _itemIconMemberShip(
              Assets.icons_ic_birthday_offer.path, "Birthday offer"),
          _itemIconMemberShip(
              Assets.icons_ic_flight_ticket.path, "Free flight ticket"),
          _itemIconMemberShip(
              Assets.icons_ic_free_hotel_room.path, "Free hotel room"),
          _itemIconMemberShip(
              Assets.icons_ic_buffet_spa.path, "Free spa voucher"),
          _itemIconMemberShip(
              Assets.icons_ic_limousine_service.path, "Limousine service"),
          _itemIconMemberShip(
              Assets.icons_ic_promotion_advantage.path, "Promotion advance"),
        ],
      ),
    ],
  );
}

Widget _itemIconMemberShip(String pathImage, String title) {
  return SizedBox(
    width: 110.0,
    height: 120.0,
    child: Column(
      children: [
        Image.asset(
          pathImage,
          width: 60.0,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}

Widget _itemTitleMemship({String? titleLevel, String? descriptionLevel}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 3.0,
            height: 3.0,
            decoration: const BoxDecoration(color: Colors.black),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Text.rich(
            TextSpan(
                text: titleLevel ?? '',
                style: const TextStyle(fontSize: 14.0, color: Colors.black),
                children: [
                  TextSpan(
                      text: descriptionLevel ?? '',
                      style: const TextStyle(color: Colors.grey))
                ]),
          ),
        ],
      ),
      const SizedBox(
        height: 3.0,
      ),
    ],
  );
}
// static final Color grey_tab = Color(0xFFE0E0E0);
// static final Color grey_BG = Color(0xFFeeeeee);
