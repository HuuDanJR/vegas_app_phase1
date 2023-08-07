import 'package:flutter/material.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/response/voucher_response.dart';

Widget itemVoucher(BuildContext context, VoucherResponse voucherResponse) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      height: 69,
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
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              Positioned(
                top: 13.0,
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
                top: 13.0,
                right: -30,
                child: Container(
                  width: 46,
                  height: 46.0,
                  decoration: BoxDecoration(
                      color: ColorName.greyWhite,
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: (voucherResponse.voucherStatus ?? '').toLowerCase() ==
                          "available"
                      ? Colors.white
                      : Colors.black12,
                ),
              ),
            ],
          ),
          // Positioned(
          //   // left: 18.0,
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //         top: 8.0, bottom: 8.0, left: 30.0, right: 30.0),
          //     child: DottedBorder(
          //       color: Colors.white,
          //       strokeWidth: 2,
          //       child: SizedBox(
          //         height: double.infinity,
          //         width: double.infinity,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            left: 30.0,
            child: SizedBox(
              // color: Colors.amber,
              width: MediaQuery.of(context).size.width * 0.78,
              height: 69,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          voucherResponse.voucherName ?? '',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Thanks for coming, we hope you enjoy your visit.',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        // Text('ISSUED DATE : 27 Oct 2021',
                        //     style: TextStyle(fontSize: 7, color: Colors.white)),
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          border:
                              Border.all(width: 1, color: ColorName.primary)),
                      child: FittedBox(
                          child: Text(
                        voucherResponse.voucherStatus ?? '',
                        style: TextStyle(
                          color: (voucherResponse.voucherStatus ?? '')
                                      .toLowerCase() ==
                                  "available"
                              ? Colors.green
                              : null,
                        ),
                      ))),
                ],
              ),
            ),
          ),
          // Positioned(
          //   right: 45.0,
          //   top: 30.0,
          //   child: SizedBox(
          //     width: 100,
          //     // height: 70,
          //     child: Text(
          //       voucherResponse.value ?? '',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(color: Colors.black, fontSize: 30),
          //     ),
          //   ),
          // ),
          Visibility(
            visible: voucherResponse.voucherStatus! == "Expired",
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white54),
            ),
          ),
        ],
      ),
    ),
  );
}
