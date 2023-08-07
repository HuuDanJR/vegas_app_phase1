import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/models/roulette_response.model.dart';

class RoutetteViewModel extends ChangeNotifier with BaseFunction {
  final Repository _repository = Repository();
  List<RouletteResponse> listRoutett = [];
  Future<void> getListRoutette(int offset) async {
    try {
      if (offset == 0) {
        listRoutett = [];
      }
      List<RouletteResponse> listRoutettTmp =
          await _repository.getListRoulettes(offset);
      if (listRoutettTmp.isNotEmpty) {
        listRoutett.addAll(listRoutettTmp);
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }
}
