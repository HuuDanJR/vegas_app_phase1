import 'package:flutter/material.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';

Widget itemJackpot() {
  return Stack(
    children: [
      Container(
        height: 135,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(Assets.image_jackpot.path))),
        child: const Center(
          child: Text(
            "109.955",
            style: TextStyle(
                fontSize: 36, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      Positioned(
        left: 130,
        child: Container(
          height: 20,
          width: 126,
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: const Center(
            child: FittedBox(
              child: Text(
                'CARAVELLE',
                style: TextStyle(color: Color.fromRGBO(190, 30, 45, 1)),
              ),
            ),
          ),
        ),
      )
    ],
  );
}
