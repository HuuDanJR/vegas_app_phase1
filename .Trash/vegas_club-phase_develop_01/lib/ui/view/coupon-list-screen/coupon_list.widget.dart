import 'package:flutter/material.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';

Widget itemCoupon(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: SizedBox(
      height: 100,
      width: 400,
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0)),
              ),
              Positioned(
                top: 25.0,
                left: -30,
                child: Container(
                  width: 46,
                  height: 46.0,
                  decoration: BoxDecoration(
                      color: ColorName.greyWhite,
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
              Positioned(
                top: 25.0,
                right: -30,
                child: Container(
                  width: 46,
                  height: 46.0,
                  decoration: BoxDecoration(
                      color: ColorName.greyWhite,
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              )
            ],
          ),
          // Positioned(
          //   left: 20.0,
          //   top: 7.5,
          //   child: DottedBorder(
          //     color: Colors.white,
          //     strokeWidth: 2,
          //     child: SizedBox(
          //       height: 80,
          //       width: 340,
          //     ),
          //   ),
          // ),
          Positioned(
            top: 18.0,
            left: 38.0,
            child: Row(
              children: [
                Row(
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '1 GRADE',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        Text(
                          'UP ON POINT',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        Text(
                          'PYRAMID',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text('ISSUED DATE : 27 Oct 2021',
                            style: TextStyle(fontSize: 7, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('UP TO',
                                  style: TextStyle(color: Colors.black)),
                              Text('\$7000',
                                  style: TextStyle(color: Colors.black))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const Positioned(
            right: 40.0,
            top: 25.0,
            child: SizedBox(
              width: 100,
              // height: 70,
              child: Text(
                'Valid period only 3  month since issued and expired coupon in valid',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
