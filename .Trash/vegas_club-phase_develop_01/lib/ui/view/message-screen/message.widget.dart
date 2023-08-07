import 'package:flutter/material.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';

Widget itemMessage() {
  return Container(
    height: 70.0,
    padding: const EdgeInsets.only(left: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: ColorName.primary,
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                    child: FittedBox(
                        child: Text(
                  'CAR',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )))),
            const SizedBox(
              width: 20,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your booking is confirmed',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      '2021.10.31 at 22:30',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                        color: ColorName.primary,
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}
