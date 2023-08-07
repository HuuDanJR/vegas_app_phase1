import 'package:dio/dio.dart';
import 'package:vegas_club/api/api.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/models/response/calendar_promo_response.dart';
import 'package:vegas_club/models/response/cart_detail_response.dart';
import 'package:vegas_club/models/response/cart_response.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/models/response/device_response.dart';
import 'package:vegas_club/models/response/history_call_response.dart';
import 'package:vegas_club/models/response/jackpot_history_response.dart';
import 'package:vegas_club/models/response/jackpot_reatime_response.dart';
import 'package:vegas_club/models/response/jackpot_response.dart';
import 'package:vegas_club/models/response/machine_neon_response.dart';
import 'package:vegas_club/models/response/machine_playing_response.dart';
import 'package:vegas_club/models/response/machine_response.dart';
import 'package:vegas_club/models/response/membership_point_response.dart';
import 'package:vegas_club/models/response/notification_local_response.dart';
import 'package:vegas_club/models/response/notification_response.dart';
import 'package:vegas_club/models/response/officer_response.dart';
import 'package:vegas_club/models/response/order_detail_response.dart';
import 'package:vegas_club/models/response/order_response.dart';
import 'package:vegas_club/models/response/product_category_response.dart';
import 'package:vegas_club/models/response/product_response.dart';
import 'package:vegas_club/models/response/pyramid_point_response.dart';
import 'package:vegas_club/models/response/reservation_response.dart';
import 'package:vegas_club/models/response/setting_response.dart';
import 'package:vegas_club/models/response/slide_level_response.dart';
import 'package:vegas_club/models/response/sum_notification_response.dart';
import 'package:vegas_club/models/response/upload_image_response.dart';
import 'package:vegas_club/models/response/voucher_response.dart';
import 'package:vegas_club/models/response/voucher_sum_response.dart';
import 'package:vegas_club/models/roulette_response.model.dart';

class ApiProvider {
  ApiProvider();
  final RestClient _client = locator.get<RestClient>();

  Future<List<RouletteResponse>> getListRoulettes(
      {int? offset = 0, int? limit = 10}) async {
    return _client.getListRoulettes(offset!, limit!);
  }

  Future<List<RouletteResponse>> getListRoulettesById(int id) async {
    return _client.getListRoulettesById(id);
  }

  Future<List<OfficerResponse>> getListOfficers(
      {int? offset = 0, int? limit = 50, String? sort = "-online"}) async {
    return _client.getListOfficer(offset!, limit!, sort!);
  }

  Future<List<HistoryCallResponse>> getHistoryCall(
      int idCustomer, String include,
      {int? offset = 0, int? limit = 10}) async {
    return _client.getHistoryCall(idCustomer, include, offset!, limit!);
  }

  Future<CustomerResponse> getCustomerByUserId(int userId) async {
    return _client.getCustomerByUserId(userId);
  }

  Future<ReservationResponse> bookingCar(Map<String, dynamic> body) async {
    return _client.bookingCar(body);
  }

  Future<List<SettingResponse>> getSetting(String setting) async {
    return _client.getSetting(setting);
  }

  Future<List<ReservationResponse>> getHistoryReservation(
      int idCustomer, String include,
      {int? offset = 0, int? limit = 10}) async {
    return _client.getHistoryReservation(
        idCustomer, include, offset!, limit!, "-id");
  }

  Future<ReservationResponse> getReservationBySourceId(int sourceId) async {
    return _client.getReservationDetail(sourceId);
  }

  Future<MemberShipPointResponse> getMembershipPoint(int customerId) async {
    return _client.getMembershipPoint(customerId);
  }

  Future<VoucherSumResponse> getVoucherSum(int customerId) async {
    return _client.getVoucherSum(customerId);
  }

  Future<List<VoucherResponse>> getMyVoucher(int customerId,
      {int? offset = 0, int? limit = 10}) async {
    return _client.getMyVoucher(customerId, offset!, limit!);
  }

  Future<List<JackpotHistoryResponse>> getJackpotHistory(int customerId,
      {int? offset = 0, int? limit = 10}) async {
    return _client.getJackpotHistory(customerId, offset!, limit!);
  }

  Future<List<PyramidPointResponse>> getPyramidPoint() async {
    return _client.getPyramidPoint();
  }

  Future<DeviceResponse> createTokenDevice(Map<String, dynamic> body) async {
    return _client.createTokenDevice(body);
  }

  Future<void> detroyTokenDevice(Map<String, dynamic> body) async {
    return _client.detroyTokenDevice(body);
  }

  Future<void> revokeToken(Map<String, dynamic> body) async {
    return _client.revokeToken(body);
  }

  Future<List<NotificationResponse>> getListNotification(int byUser,
      {int? byNotificationType,
      int? bySourceId,
      int? offset = 0,
      int? limit = 10,
      int? byStatus,
      String? sort = "-created_at"}) async {
    return _client.getListNotification(byUser, byNotificationType, bySourceId,
        sort!, offset!, limit!, byStatus!);
  }

  Future<SumNotifcationResponse> getSumNotificationIsNotRead(
    int byUser,
  ) async {
    return _client.getSumNotificationIsNotRead(byUser);
  }

  Future<List<MachineResponse>> getListMachine(int idCustomer, String include,
      {int? offset = 0, int? limit = 10, int? byStatus}) async {
    return _client.getListMachine(
        idCustomer, include, "-id", offset!, limit!, byStatus!);
  }

  Future<NotificationResponse> getNotificationDetail(int notificationId) async {
    return _client.getNotificationDetail(notificationId);
  }

  Future<MachineResponse> createMachineSlotReservation(
      Map<String, dynamic> body) async {
    return _client.createMachineSlotReservation(body);
  }

  Future<List<MachinePlayResponse>> getMachinePlayingByUserId(
      int userId, int offset) async {
    return _client.getMachinePlayingByUserId(userId, offset, 10);
  }

  Future<List<ProductResponse>> getProduct(
      String? search, String? qrCode, String? include, int offset) async {
    return _client.getProduct(search, qrCode, include, offset, 10);
  }

  Future<List<CartDetailResponse>> getCart(
    int? userId,
    String? include, {
    int offset = 0,
    int limt = 10,
  }) async {
    return _client.getCart(userId, "product", offset, limt);
  }

  Future<CartResponse> postCart(Map<String, dynamic> body) async {
    return _client.postCart(body);
  }

  Future<CartResponse> updateCart(Map<String, dynamic> body, int idCart) async {
    return _client.updateCart(body, idCart);
  }

  Future<OrderResponse> createOrder(Map<String, dynamic> body) async {
    return _client.createOrder(body);
  }

  Future<void> createHostLine(Map<String, dynamic> body) async {
    return _client.createCallHotLine(body);
  }

  Future<List<CalendarPromoResponse>> getCalendarPromo(String include) async {
    return _client.getCalendarPromo(include);
  }

  Future<void> removeAccount(int userId) async {
    return _client.removeAccount(userId);
  }

  Future<void> signOut(int userId) async {
    return _client.signout(userId);
  }

  Future<List<JackpotResponse>> getJackPot(String sort) async {
    return _client.getJackpot(sort);
  }

  Future<JackpotRealtimeResponse> getJackpotReatime() async {
    return _client.getJackpotReatime();
  }

  Future<dynamic> changePassword(Map<String, dynamic> body) async {
    return _client.resetPassword(body);
  }

  Future<OrderDetailResponse> getOrderBySourceId(
      int sourceId, String? include) async {
    return _client.getOrderBySourceId(sourceId, include);
  }

  Future<MachineResponse> getMachineReservationBySourceId(
    int sourceId,
  ) async {
    return _client.getMachineReservationBySourceId(sourceId);
  }

  Future<MachineNeonResponse> getMachineNeon(int id) async {
    return _client.getMachineNeonResponse(id);
  }

  Future<List<ProductCategoryResponse>> getAllCategoryProduct() async {
    return _client.getAllCategoryProduct();
  }

  Future<List<ProductResponse>> getProductByCategoryId(
      int categoryId,
      String customerLevel,
      int productType,
      String include,
      String search,
      int offset) async {
    return _client.getProductByCategoryId(
        categoryId, customerLevel, include, offset, 20, search);
  }

  Future<List<UploadImageResponse>> uploadImage(FormData data, String header,
      {ProgressCallback? sendProgress}) async {
    return await _client.uploadImage(data, "multipart/form-data",
        sendProgress: sendProgress);
  }

  Future<CustomerResponse> updateAvatar(
      int customerId, int attachmentId) async {
    return await _client.updateAvatar(customerId, attachmentId);
  }

  Future<SettingResponse> getTermOfService() async {
    return await _client.getTermOfService();
  }

  Future<void> deleteNotification(Map<String, dynamic> body) async {
    return await _client.deleteNotification(body);
  }

  Future<NotificationLocalResponse> getMessage(int notificationId) async {
    return await _client.getMessage(notificationId);
  }

  Future<List<SlideLevelResponse>> getSlideLevel(String sort) async {
    return await _client.getSlideLevel(sort);
  }
}
