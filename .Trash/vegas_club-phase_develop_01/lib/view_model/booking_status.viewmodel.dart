import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/config/mixpanel_config.dart';
import 'package:vegas_club/models/history_reservation.model.dart';
import 'package:vegas_club/models/request/booking_car_request.dart';
import 'package:vegas_club/models/response/reservation_response.dart';
import 'package:vegas_club/service/authentication.service.dart';

class BookingStatusViewModel extends ChangeNotifier with BaseFunction {
  var repo = Repository();
  ReservationResponse? reservationResponse;
  List<ReservationResponse> listReservation = [];
  List<ReservationResponse> listReservationTmp = [];

  List<HistoryReservation> listHistoryReservation = [];

  Future<void> postCar(BookingCarRequest requestModel,
      {VoidCallback? callback}) async {
    ReservationResponse? response;
    await fetch(() async {
      response = await repo.bookingCar(requestModel.toJson());
    });
    var customResponse = await ProfileUser.getProfile();
    locator.get<MixPanelTrackingService>().trackData(
          name: "Đặt xe",
        );
    if (response!.id != null) {
      showAlertDialog(
        barrierDismissible: true,
        title: "Request Success!",
        typeDialog: TypeDialog.success,
      );

      reservationResponse = response;
      if (callback != null) {
        callback();
      }
      notifyListeners();
    }
  }

  Future<void> getGroupHistoryBooking(BuildContext context, int offset) async {
    try {
      if (offset == 0) {
        listReservation = [];
      }
      int? user = await ProfileUser.getCurrentCustomerId();
      listReservationTmp =
          await repo.getHistoryReservation(user, "", offset: offset, limit: 10);
      if (listReservationTmp.isNotEmpty) {
        listReservation = [];
        if (listReservationTmp.isNotEmpty) {
          listHistoryReservation = [];
          listReservation.addAll(listReservationTmp);
          listReservation.map((e) {
            e.formatDate = DateTime(
                e.createdAt!.year, e.createdAt!.month, e.createdAt!.day);
          }).toList();
          var groupHistoryReservation =
              groupBy(listReservation, (ReservationResponse e) => e.formatDate);
          groupHistoryReservation.map((key, value) {
            List<ReservationResponse> listTmp = [];
            HistoryReservation? groupHistory;
            MapEntry(
                key,
                value.map((item) {
                  listTmp.add(item);
                  groupHistory = HistoryReservation(
                      dateTime: Utils.checkDate(context, key!),
                      listReservation: listTmp);
                }).toList());
            listHistoryReservation.add(groupHistory ?? HistoryReservation());
            return const MapEntry(null, null);
          });
        }
        log(listHistoryReservation.toString());
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> getHistoryBooking(BuildContext context, int offset) async {
    if (offset == 0) {
      listReservation = [];
    }
    int? user = await ProfileUser.getCurrentCustomerId();
    await fetch(() async {
      listReservationTmp =
          await repo.getHistoryReservation(user, "", offset: offset, limit: 10);
    });
    if (listReservationTmp.isNotEmpty) {
      listReservation.addAll(listReservationTmp);
    }
    notifyListeners();
  }
  // Future<void>
}
