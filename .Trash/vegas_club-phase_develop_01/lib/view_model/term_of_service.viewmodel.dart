import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/models/response/setting_response.dart';

class TermOfServiceViewModel extends ChangeNotifier with BaseFunction {
  final repo = Repository();
  String termOfUser = "";
  Future<void> getTermOfService() async {
    try {
      SettingResponse? response = await repo.getTermOfService();
      termOfUser = response.settingValue ?? '';
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }
}
