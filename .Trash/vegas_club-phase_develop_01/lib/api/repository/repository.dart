import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vegas_club/api/provider/provider_api.dart';
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

class Repository {
  Repository();
  final ApiProvider _provider = ApiProvider();
  Future<List<RouletteResponse>> getListRoulettes(int offset) async {
    return _provider.getListRoulettes(offset: offset);
  }

  Future<List<RouletteResponse>> getListRoulettesById(int id) async {
    return _provider.getListRoulettesById(id);
  }

  Future<List<OfficerResponse>> getListOffcier() async {
    return _provider.getListOfficers(sort: "-is_reception,-online");
  }

  Future<List<HistoryCallResponse>> getHistoryCall(
      int idCustomer, String include, int offset, int limit) async {
    return _provider.getHistoryCall(idCustomer, include,
        offset: offset, limit: limit);
  }

  Future<CustomerResponse> getCustomerByUserId(int userId) async {
    return _provider.getCustomerByUserId(userId);
  }

  Future<ReservationResponse> bookingCar(Map<String, dynamic> body) async {
    return _provider.bookingCar(body);
  }

  Future<List<SettingResponse>> getSetting(String setting) async {
    return _provider.getSetting(setting);
  }

  Future<List<ReservationResponse>> getHistoryReservation(
      int idCustomer, String include,
      {int? offset = 0, int? limit = 10}) async {
    return _provider.getHistoryReservation(idCustomer, include,
        offset: offset, limit: limit);
  }

  Future<ReservationResponse> getReservationBySourceId(int sourceId) async {
    return _provider.getReservationBySourceId(sourceId);
  }

  Future<MemberShipPointResponse?> getMembershipPoint(int customerId) async {
    return _provider.getMembershipPoint(customerId);
  }

  Future<VoucherSumResponse> getVoucherSum(int customerId) async {
    return _provider.getVoucherSum(customerId);
  }

  Future<List<VoucherResponse>> getMyVoucher(int customerId,
      {int? offset = 0, int? limit = 10}) async {
    return _provider.getMyVoucher(customerId, offset: offset, limit: limit);
  }

  Future<List<JackpotHistoryResponse>> getJackpotHistory(int customerId,
      {int? offset = 0, int? limit = 10}) async {
    List<JackpotHistoryResponse> response = await _provider
        .getJackpotHistory(customerId, offset: offset!, limit: limit!);
    return response;
  }

  Future<List<PyramidPointResponse>> getPyramidPoint() async {
    return _provider.getPyramidPoint();
  }

  Future<DeviceResponse> createTokenDevice(Map<String, dynamic> body) async {
    return _provider.createTokenDevice(body);
  }

  Future<void> detroyTokenDevice(Map<String, dynamic> body) async {
    return _provider.detroyTokenDevice(body);
  }

  Future<void> revokeToken(Map<String, dynamic> body) async {
    return _provider.revokeToken(body);
  }

  Future<List<NotificationResponse>> getListNotification(int? byUser,
      {int? byNotificationType,
      int? bySourceId,
      int? offset,
      int? byStatus}) async {
    return _provider.getListNotification(byUser!,
        byNotificationType: byNotificationType,
        bySourceId: bySourceId,
        offset: offset,
        byStatus: byStatus);
  }

  Future<SumNotifcationResponse> getNotificationIsNotRead(
    int byUser,
  ) async {
    return _provider.getSumNotificationIsNotRead(byUser);
  }

  Future<List<MachineResponse>> getListMachine(
      int idCustomer, int offset, int byStatus) async {
    return _provider.getListMachine(idCustomer, 'customer',
        offset: offset, byStatus: byStatus);
  }

  Future<NotificationResponse> getNotificationDetail(int notificationId) async {
    return _provider.getNotificationDetail(notificationId);
  }

  Future<MachineResponse> createMachineSlotReservation(
      Map<String, dynamic> body) async {
    return _provider.createMachineSlotReservation(body);
  }

  Future<List<MachinePlayResponse>> getMachinePlayingByUserId(
      int userId, int offset) async {
    return _provider.getMachinePlayingByUserId(userId, offset);
  }

  Future<List<ProductResponse>> getProduct(
      String? search, String? qrCode, String? include, int offset) async {
    return _provider.getProduct(search, qrCode, include, offset);
  }

  Future<List<CartDetailResponse>> getCart(int? userId, int offset) async {
    return _provider.getCart(userId, "product", offset: offset);
  }

  Future<CartResponse> postCart(Map<String, dynamic> body) async {
    return _provider.postCart(body);
  }

  Future<CartResponse> updateCart(Map<String, dynamic> body, int idCart) async {
    return _provider.updateCart(body, idCart);
  }

  Future<OrderResponse> createOrder(Map<String, dynamic> body) async {
    return _provider.createOrder(body);
  }

  Future<void> createHostLine(Map<String, dynamic> body) async {
    return _provider.createHostLine(body);
  }

  Future<List<CalendarPromoResponse>> getCalendarPromo(String include) async {
    return _provider.getCalendarPromo(include);
  }

  Future<void> removeAccount(int userId) async {
    return _provider.removeAccount(userId);
  }

  Future<void> signOut(int userId) async {
    return _provider.signOut(userId);
  }

  Future<List<JackpotResponse>> getJackpot(String sort) async {
    return _provider.getJackPot(sort);
  }

  Future<JackpotRealtimeResponse> getJackpotReatime() async {
    return _provider.getJackpotReatime();
  }

  Future<dynamic> changePassword(Map<String, dynamic> body) async {
    return _provider.changePassword(body);
  }

  Future<OrderDetailResponse> getOrderBySourceId(
      int sourceId, String? include) async {
    return _provider.getOrderBySourceId(sourceId, include);
  }

  Future<MachineResponse> getMachineReservationBySourceId(
    int sourceId,
  ) async {
    return _provider.getMachineReservationBySourceId(sourceId);
  }

  Future<MachineNeonResponse> getMachineNeon(int id) async {
    return _provider.getMachineNeon(id);
  }

  Future<List<ProductCategoryResponse>> getAllCategoryProduct() async {
    return _provider.getAllCategoryProduct();
  }

  Future<List<ProductResponse>> getProductByCategoryId(
      int categoryId,
      String customerLevel,
      int productType,
      String include,
      String search,
      int offset) async {
    return _provider.getProductByCategoryId(
        categoryId, customerLevel, productType, include, search, offset);
  }

  Future<List<UploadImageResponse>> uploadImage(File file,
      {ProgressCallback? sendProgress}) async {
    return await _provider.uploadImage(
        FormData.fromMap({
          "file": await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last)
        }),
        "multipart/form-data",
        sendProgress: sendProgress);
  }

  Future<CustomerResponse> updateAvatar(
      int customerId, int attachmentId) async {
    return await _provider.updateAvatar(customerId, attachmentId);
  }

  Future<SettingResponse> getTermOfService() async {
    return await _provider.getTermOfService();
  }

  Future<void> deleteNotification(Map<String, dynamic> body) async {
    return await _provider.deleteNotification(body);
  }

  Future<NotificationLocalResponse> getMessage(int notificationId) async {
    return await _provider.getMessage(notificationId);
  }

  Future<List<SlideLevelResponse>> getSlideLevel(String sort) async {
    return await _provider.getSlideLevel(sort);
  }
}
