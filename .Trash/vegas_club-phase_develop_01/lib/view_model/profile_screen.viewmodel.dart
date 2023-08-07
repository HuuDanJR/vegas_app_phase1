import 'dart:async';

import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/models/request/reset_password_request.dart';
import 'package:vegas_club/models/response/customer_level_response.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/models/response/membership_point_response.dart';
import 'package:vegas_club/models/response/setting_response.dart';
import 'package:vegas_club/models/response/slide_level_response.dart';
import 'package:vegas_club/models/response/voucher_sum_response.dart';
import 'package:vegas_club/service/authentication.service.dart';

var profileProvider = ChangeNotifierProvider((ref) => ProfileViewModel());

class ProfileViewModel extends ChangeNotifier with BaseFunction {
  CustomerResponse? customerResponse;
  MemberShipPointResponse? memberShipPointResponse;
  int? mbsPoint = 0;
  String fileHtmlContents = "";
  SettingResponse? settingResponse;
  List<CustomerLevelResponse> listLevel = [];
  List<SlideLevelResponse> listSlideLevel = [];
  String level = "";
  double walletSum = 0;
  int cashBalance = 0;
  int fortuneCredit = 0;
  int voucherSum = 0;
  int currentIndex = 0;
  final repo = Repository();

  void clearData() {
    customerResponse = null;
    level = "";
    memberShipPointResponse = null;
    notifyListeners();
  }

  Future<void> initData(BuildContext context,
      {Function(CustomerResponse customerResponse)? onCallBack}) async {
    try {
      await initGetProfile();
      await getMembershipPoint();
      await getSlideLevel();

      getListCustomerLevel();
      await getWalletSum();

      await getVoucherSumPrice();
      if (onCallBack != null) {
        onCallBack(customerResponse!);
      }
    } catch (e) {
      // print("error : ${e.toString()}");
      // if (e is DioError) {
      //   catchError(e);
      // }
    }

    fileHtmlContents = await rootBundle.loadString(Assets.benefit);

    notifyListeners();
  }

  Future<void> getSlideLevel() async {
    List<SlideLevelResponse> response =
        await repo.getSlideLevel("-slide_index");
    listSlideLevel = response;
    notifyListeners();
  }

  void setListCustomerLevel(List<CustomerLevelResponse> list) async {
    listLevel = list;
    notifyListeners();
  }

  Future<void> getListCustomerLevel() async {
    List<CustomerLevelResponse> list = await boxCustomer!.get(customerBoxKey);
    listLevel = list;

    if (listLevel.isNotEmpty) {
      await getCustomerLevel();
    }
    notifyListeners();
  }

  Future<void> getCustomerLevel() async {
    for (int i = 0; i < listLevel.length; i++) {
      for (int x = 0; x < listLevel[i].type!.length; x++) {
        if (customerResponse!.membershipTypeName == listLevel[i].type![x]) {
          level = listLevel[i].level ?? '';

          await boxCustomer!.put(customerLevelKey, level);
        }
      }
    }
    notifyListeners();
  }

  Future<void> initGetProfile() async {
    customerResponse = await ProfileUser.getProfile();

    notifyListeners();
  }

  Future<void> getMembershipPoint() async {
    int customerId = await ProfileUser.getCurrentCustomerId();
    MemberShipPointResponse? memberShipPointResponseTmp;

    memberShipPointResponseTmp = await repo.getMembershipPoint(customerId);
    if (memberShipPointResponseTmp != null) {
      memberShipPointResponse = memberShipPointResponseTmp;
      mbsPoint = memberShipPointResponse!.loyaltyPoint;
    }
    getWalletSum();
  }

  Future<void> changePassword(
      {String? newsPassword,
      String? confirmPassword,
      Function? onSucess}) async {
    int userId = await ProfileUser.getCurrentUserId();
    ResetPasswordRequest request = ResetPasswordRequest(
        userId: userId,
        newPassword: newsPassword,
        confirmPassword: confirmPassword);
    await fetch(() async {
      await repo.changePassword(request.toJson());
    });

    if (onSucess != null) {
      onSucess();
    }
    notifyListeners();
  }

  Future<void> getWalletSum() async {
    walletSum = (memberShipPointResponse?.wallet ?? 0) +
        (memberShipPointResponse?.fortuneCredit ?? 0);
    notifyListeners();
  }

  Future<void> setIndexSlide(int index) async {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> getVoucherSumPrice() async {
    int customerId = await ProfileUser.getCurrentCustomerId();
    VoucherSumResponse? response = await repo.getVoucherSum(customerId);
    voucherSum = response.totalVoucher ?? 0;
    notifyListeners();
  }
}
