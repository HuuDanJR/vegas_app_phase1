import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/models/response/reservation_response.dart';
import 'package:vegas_club/view_model/booking_status.viewmodel.dart';

class HistoryBooking extends StateFullConsumer {
  const HistoryBooking({Key? key}) : super(key: key);
  static const String routeName = "/history_booking";
  @override
  _HistoryBookingState createState() => _HistoryBookingState();
}

class _HistoryBookingState extends StateConsumer<HistoryBooking> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initStateWidget() {
    Provider.of<BookingStatusViewModel>(context, listen: false)
        .getGroupHistoryBooking(context, 0);
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
          elevation: 0,
          backgroundColor: ColorName.primary2,
          title: const Text(
            "History Booking",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Consumer<BookingStatusViewModel>(
          builder: (BuildContext context, BookingStatusViewModel model,
              Widget? child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(),
                controller: _refreshController,
                onLoading: () {
                  Provider.of<BookingStatusViewModel>(context, listen: false)
                      .getHistoryBooking(
                          context, model.listReservationTmp.length);
                  _refreshController.loadComplete();
                },
                onRefresh: () {
                  Provider.of<BookingStatusViewModel>(context, listen: false)
                      .getHistoryBooking(context, 0);
                  _refreshController.refreshCompleted();
                },
                child: ListView.separated(
                  // physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10.0),
                  itemCount: model.listReservation.length,
                  itemBuilder: (context, index) {
                    return itemElementCar(model.listReservation[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 4.0,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget itemCar(HistoryReservation historyReservation) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         historyReservation.dateTime!,
  //         style: TextStyle(
  //             fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  //       ),
  //       SizedBox(
  //         height: 10.0,
  //       ),
  //       ListView.separated(
  //         physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: historyReservation.listReservation!.length,
  //         itemBuilder: (context, index) {
  //           return itemElementCar(historyReservation.listReservation![index]);
  //         },
  //         separatorBuilder: (BuildContext context, int index) {
  //           return SizedBox(
  //             height: 10.0,
  //           );
  //         },
  //       )
  //     ],
  //   );
  // }

  Widget itemElementCar(ReservationResponse reservationResponse) {
    return Container(
      // height: 100.0,
      width: width(context),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.car_crash_outlined),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reservationResponse.pickupAt != null
                      ? reservationResponse.pickupAt!.toDateString()
                      : 'No data',
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  (reservationResponse.address == null ||
                          reservationResponse.address!.isEmpty)
                      ? 'No data'
                      : reservationResponse.address!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: SizedBox(
              height: 30,
              child: buttonView(
                  text: "Book",
                  onPressed: () {
                    pop(reservationResponse);
                  }),
            ),
          )
        ],
      ),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
