import 'package:flutter/material.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';

Widget informationCreadit(
    {required BuildContext context, String? title, String? value}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 66,
    decoration: BoxDecoration(
        color: const Color.fromRGBO(252, 251, 246, 1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: ColorName.primary)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title!,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5.0,
        ),
        RichText(
          text: TextSpan(
              text: "${value!} ",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              children: const [
                TextSpan(
                    text: "", style: TextStyle(fontWeight: FontWeight.normal))
              ]),
        )
      ],
    ),
  );
}

Widget creaditReviewWidget(String point) {
  return SizedBox(
    height: 200,
    width: 200,
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.image_background_point.path)),
          ),
        ),
        Positioned(
          top: 41,
          left: 30,
          child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(65)),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    point,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
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
