import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
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

part 'api.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  //login

  @GET("api/v1/roulettes")
  Future<List<RouletteResponse>> getListRoulettes(
      @Query("offset") int offset, @Query("limit") int limit);

  @GET("api/v1/roulettes/{id}")
  Future<List<RouletteResponse>> getListRoulettesById(@Path("id") int id);

  @GET("api/v1/officers")
  Future<List<OfficerResponse>> getListOfficer(@Query("offset") int offset,
      @Query("limit") int limit, @Query("sort") String sort);

  @GET("api/v1/officer_customers")
  Future<List<HistoryCallResponse>> getHistoryCall(
      @Query("by_customer") int idCustomer,
      @Query("include") String include,
      @Query("offset") int offset,
      @Query("limit") int limit);

  @POST("api/v1/officer_customers")
  Future<void> createCallHotLine(@Body() Map<String, dynamic> body);

  @GET("api/v1/customers/get_customer_by_user_id/{id}")
  Future<CustomerResponse> getCustomerByUserId(@Path("id") int userId);

  @POST("api/v1/reservations")
  Future<ReservationResponse> bookingCar(@Body() Map<String, dynamic> body);

  @GET("api/v1/settings")
  Future<List<SettingResponse>> getSetting(
      @Query("by_setting_key") String setting);

  @GET("api/v1/reservations")
  Future<List<ReservationResponse>> getHistoryReservation(
      @Query("by_customer") int idCustomer,
      @Query("include") String include,
      @Query("offset") int offset,
      @Query("limit") int limit,
      @Query("sort") String sort);

  @GET("api/v1/reservations/{sourceId}")
  Future<ReservationResponse> getReservationDetail(
      @Path("sourceId") int sourceId);

  @GET("api/v1/customers/{customerId}/point")
  Future<MemberShipPointResponse> getMembershipPoint(
      @Path("customerId") int customerId);

  @GET("api/v1/customers/{customerId}/voucher")
  Future<List<VoucherResponse>> getMyVoucher(@Path("customerId") int customerId,
      @Query("offset") int offset, @Query("limit") int limit);

  @GET("api/v1/customers/{customerId}/jackpot_history")
  Future<List<JackpotHistoryResponse>> getJackpotHistory(
      @Path("customerId") int customerId,
      @Query("offset") int offset,
      @Query("limit") int limit);

  @GET("api/v1/pyramid_points")
  Future<List<PyramidPointResponse>> getPyramidPoint();

  @POST("api/v1/devices")
  Future<DeviceResponse> createTokenDevice(@Body() Map<String, dynamic> body);

  @POST("api/v1/devices/destroy")
  Future<void> detroyTokenDevice(@Body() Map<String, dynamic> body);

  @POST("oauth/revoke")
  Future<void> revokeToken(@Body() Map<String, dynamic> body);

  @GET("api/v1/notifications")
  Future<List<NotificationResponse>> getListNotification(
      @Query("by_user") int byUser,
      @Query("by_notification_type") int? byNotificationType,
      @Query("by_source_id") int? bySourceId,
      @Query("sort") String sort,
      @Query("offset") int offset,
      @Query("limit") int limit,
      @Query("by_status") int status);

  @GET("api/v1/notifications/count/{userId}")
  Future<SumNotifcationResponse> getSumNotificationIsNotRead(
    @Path("userId") int userId,
  );

  @GET("api/v1/customers/{customerId}/total_voucher")
  Future<VoucherSumResponse> getVoucherSum(@Path("customerId") int customerId);

  @GET("api/v1/notifications/{id}")
  Future<NotificationResponse> getNotificationDetail(
      @Path("id") int notificationId);

  @GET("api/v1/messages/{id}")
  Future<NotificationLocalResponse> getMessage(@Path("id") int notificationId);

  @GET("api/v1/machine_reservations/")
  Future<List<MachineResponse>> getListMachine(
      @Query("by_customer") int idCustomer,
      @Query("include") String include,
      @Query("sort") String sort,
      @Query("offset") int offset,
      @Query("limit") int limit,
      @Query("by_status") int byStatus);

  @GET("api/v1/machine_reservations/{sourceId}")
  Future<MachineResponse> getMachineReservationBySourceId(
    @Path("sourceId") int sourceId,
  );

  @POST("api/v1/machine_reservations")
  Future<MachineResponse> createMachineSlotReservation(
      @Body() Map<String, dynamic> body);

  @GET("api/v1/customers/{id}/machine")
  Future<List<MachinePlayResponse>> getMachinePlayingByUserId(
      @Path("id") int userId,
      @Query("offset") int offset,
      @Query("limit") int limit);

  @GET("api/v1/products")
  Future<List<ProductResponse>> getProduct(
      @Query("search") String? search,
      @Query("by_qrcode") String? qrCode,
      @Query("include") String? include,
      @Query("offset") int offset,
      @Query("limit") int limit);

  @GET("api/v1/carts")
  Future<List<CartDetailResponse>> getCart(
      @Query("by_customer") int? userId,
      @Query("include") String? include,
      @Query("offset") int offset,
      @Query("limit") int limit);

  @POST("api/v1/carts")
  Future<CartResponse> postCart(@Body() Map<String, dynamic> body);

  @PUT("api/v1/carts/{idCart}")
  Future<CartResponse> updateCart(
      @Body() Map<String, dynamic> body, @Path("idCart") int idCart);

  @POST("api/v1/orders")
  Future<OrderResponse> createOrder(@Body() Map<String, dynamic> body);

  @GET("api/v1/orders/{sourceId}")
  Future<OrderDetailResponse> getOrderBySourceId(
      @Path("sourceId") int sourceId, @Query("include") String? include);

  @GET("api/v1/promotions")
  Future<List<CalendarPromoResponse>> getCalendarPromo(
      @Query("include") String? include);

  @GET("api/v1/customers/{id}/delete_account")
  Future<void> removeAccount(@Path("id") int id);

  @GET("api/v1/customers/{userId}/sign_out")
  Future<void> signout(@Path("userId") int userId);

  @GET("api/v1/jackpot_machines?include=jackpot_game_type")
  Future<List<JackpotResponse>> getJackpot(@Path("sort") String sort);

  @GET("api/v1/jackpot_machines/jp-real-time")
  Future<JackpotRealtimeResponse> getJackpotReatime();

  @POST("api/v1/customers/change_password")
  Future<dynamic> resetPassword(@Body() Map<String, dynamic> body);

  @GET("api/v1/machine_reservations/get_machine_from_neon/{id}")
  Future<MachineNeonResponse> getMachineNeonResponse(@Path("id") int id);

  @GET("api/v1/product_categories")
  Future<List<ProductCategoryResponse>> getAllCategoryProduct();

  @GET("api/v1/products")
  Future<List<ProductResponse>> getProductByCategoryId(
      @Query("by_product_category_id") int categoryId,
      @Query("by_customer_level") String customerLevel,
      @Query("include") String? include,
      @Query("offset") int offset,
      @Query("limit") int limit,
      @Query("search") String? search);

  @POST("api/v1/attachments/upload")
  Future<List<UploadImageResponse>> uploadImage(
      @Body() FormData data, @Header("Content-Type") String header,
      {@SendProgress() ProgressCallback? sendProgress});

  @GET("api/v1/customers/{customerId}/update_avatar/{attachmentId}")
  Future<CustomerResponse> updateAvatar(@Path("customerId") int customerId,
      @Path("attachmentId") int attachmentId);

  @GET("api/v1/settings/get_term_of_service")
  Future<SettingResponse> getTermOfService();

  @POST("api/v1/notifications/delete")
  Future<void> deleteNotification(@Body() Map<String, dynamic> body);

  @GET("api/v1/slides")
  Future<List<SlideLevelResponse>> getSlideLevel(@Query("sort") String sort);
}
