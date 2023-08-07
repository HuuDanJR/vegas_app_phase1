import 'package:flutter/material.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/models/response/voucher_response.dart';
import 'package:vegas_club/service/authentication.service.dart';

class VoucherListScreenViewModel extends ChangeNotifier with BaseFunction {
  var repo = Repository();
  List<VoucherResponse>? listMyVoucher;
  bool? isLoading = false;
  Future<void> getMyVoucher(int offset) async {
    isLoading = true;
    notifyListeners();
    if (offset == 0) {
      listMyVoucher = [];
    }

    int customerId = await ProfileUser.getCurrentCustomerId();

    List<VoucherResponse> response = [];
    response = await repo.getMyVoucher(customerId, offset: offset);
    isLoading = false;
    if (response.isNotEmpty) {
      listMyVoucher!.addAll(response);
    }
    notifyListeners();
  }
}
