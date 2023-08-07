import 'package:dio/dio.dart';
import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/models/response/membership_point_response.dart';
import 'package:vegas_club/models/response/pyramid_point_response.dart';
import 'package:vegas_club/service/authentication.service.dart';

class PointPyramidScreenViewModel extends ChangeNotifier with BaseFunction {
  Repository repository = Repository();

  MemberShipPointResponse? memberShipPointResponse;
  List<PyramidPointResponse>? listPyramidPoint;
  int? mbsPoint = 0;
  CustomerResponse? customerResponse;

  Future<void> initDate() async {
    try {
      await getMembershipPoint();
      await getPyramidPoint();
      await initGetProfile();
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> initGetProfile() async {
    customerResponse = await ProfileUser.getProfile();
  }

  Future<void> getMembershipPoint() async {
    int customerId = await ProfileUser.getCurrentCustomerId();
    var memberShipPointResponseTmp =
        await repository.getMembershipPoint(customerId);
    if (memberShipPointResponseTmp != null) {
      memberShipPointResponse = memberShipPointResponseTmp;
      mbsPoint = memberShipPointResponse!.loyaltyPoint;
    }
  }

  Future<void> getPyramidPoint() async {
    var reponse = await repository.getPyramidPoint();
    if (reponse.isNotEmpty) {
      listPyramidPoint = reponse;
    }
  }
}
