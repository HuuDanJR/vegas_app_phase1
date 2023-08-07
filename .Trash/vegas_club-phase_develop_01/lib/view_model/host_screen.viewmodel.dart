import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/models/group_history_call.model.dart';
import 'package:vegas_club/models/request/call_hostline_request.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/models/response/history_call_response.dart';
import 'package:vegas_club/models/response/officer_response.dart';
import 'package:vegas_club/service/authentication.service.dart';

class HostScreenViewModel extends ChangeNotifier with BaseFunction {
  var repo = Repository();
  List<OfficerResponse> listOfficer = [];
  List<HistoryCallResponse> listHistoryCallTmp = [];
  List<HistoryCallResponse> listHistoryCall = [];

  List<GroupHistoryCall> listGroupHistoryCall = [];
  Future<void> getOfficer() async {
    listOfficer = await repo.getListOffcier();
    notifyListeners();
  }

  Future<void> getHistoryCall(BuildContext context, int offset) async {
    if (offset == 0) {
      listHistoryCall = [];
    }
    CustomerResponse? user = await ProfileUser.getProfile();
    await fetch(() async {
      listHistoryCallTmp =
          await repo.getHistoryCall(user.id!, 'officer', offset, 30);
    });

    if (listHistoryCallTmp.isNotEmpty) {
      listGroupHistoryCall = [];

      listHistoryCall.addAll(listHistoryCallTmp);
      listHistoryCall.map((e) {
        e.formatDate = DateTime(e.createdAt!.year, e.createdAt!.month,
            e.createdAt!.day, e.createdAt!.hour, e.createdAt!.minute);
      }).toList();
      var groupHistoryCall =
          groupBy(listHistoryCall, (HistoryCallResponse e) => e.formatDate);
      groupHistoryCall.map((k, v) {
        List<HistoryCallResponse> listTmp = [];
        GroupHistoryCall? groupVideo;
        MapEntry(
            k,
            v.map((item) {
              listTmp.add(item);

              groupVideo = GroupHistoryCall(
                  name: item.officer?.name ?? '',
                  dateTime: Utils.toDateAndTime(k!, format: "yyyy-MMM-dd"),
                  listHisCall: listTmp);
            }).toList());
        listGroupHistoryCall.add(groupVideo!);
        return const MapEntry(null, null);
      });
    }
    notifyListeners();
  }

  Future<void> createHostLine(int officerId) async {
    int userId = await ProfileUser.getCurrentCustomerId();

    await repo.createHostLine(
        CallHotLineRequest(officerId: officerId, customerId: userId).toJson());
    notifyListeners();
  }
}
