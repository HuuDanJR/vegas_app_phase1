import 'package:dio/dio.dart';
import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/models/response/jackpot_history_response.dart';
import 'package:vegas_club/models/response/jackpot_reatime_response.dart';
import 'package:vegas_club/models/response/jackpot_response.dart';
import 'package:vegas_club/service/authentication.service.dart';

class JackpotHistoryViewmodel extends ChangeNotifier with BaseFunction {
  var repo = Repository();
  List<JackpotHistoryResponse> listJacpotHistory = [];
  List<JackpotResponse> listJackpot = [];
  JackpotRealtimeResponse? jackpotRealtime;
  List<ListDatumModel> listJackpotRealtime = [];
  bool? isLoadingJackpotRealtime = false;
  Future<void> getJackpotHistory() async {
    int customerId = await ProfileUser.getCurrentCustomerId();
    List<JackpotHistoryResponse> response = [];
    response = await repo.getJackpotHistory(customerId);
    if (response.isNotEmpty) {
      listJacpotHistory = response;
      listJacpotHistory.sort((a, b) => b.date!.compareTo(a.date!));
      notifyListeners();
    }
  }

  Future<void> getJackpot() async {
    try {
      List<JackpotResponse> response = [];
      response = await repo.getJackpot("-id");
      if (response.isNotEmpty) {
        listJackpot = response.toList();
        notifyListeners();
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
  }

  List<dynamic> listDatum = [];
  Future<void> getJackpotRealtime() async {
    try {
      // isLoadingJackpotRealtime = true;
      // notifyListeners();
      listJackpotRealtime = [];
      JackpotRealtimeResponse? response = await repo.getJackpotReatime();

      // isLoadingJackpotRealtime = false;

      jackpotRealtime = response;
      jackpotRealtime!.data!.map((e) {
        listDatum = [e.value];
        listJackpotRealtime.add(ListDatumModel(
            name: e.name, max: e.max, min: e.min, value: listDatum));
      }).toList();
      notifyListeners();
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }

    notifyListeners();
  }
}
