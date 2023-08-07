import 'package:dio/dio.dart';
import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';
import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/common/utils/extension.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/config/mixpanel_config.dart';
import 'package:vegas_club/models/response/machine_response.dart';
import 'package:vegas_club/models/response/notification_local_response.dart';
import 'package:vegas_club/models/response/notification_response.dart';
import 'package:vegas_club/models/response/order_detail_response.dart';
import 'package:vegas_club/models/response/reservation_response.dart';
import 'package:vegas_club/models/response/setting_model.dart';
import 'package:vegas_club/models/response/sum_notification_response.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/ui/view/notification-screen/notification_detail.screen.dart';

class NotificationScreenViewModel extends ChangeNotifier with BaseFunction {
  List<NotificationResponse>? listNotification = [];
  List<NotificationResponse>? listNotificationByConfigType = [];
  NotificationResponse? notificationResponse;
  ReservationResponse? reservationResponse;
  MachineResponse? machineResponse;
  OrderDetailResponse? productResponse;
  NotiContent? notiContent;
  int? sumNotification = 0;
  NotificationLocalResponse? notificationLocalResponse;
  var repo = Repository();

  Future<void> getSumNotificationIsNotRead() async {
    int? userId = await ProfileUser.getCurrentUserId();
    SumNotifcationResponse? response =
        await repo.getNotificationIsNotRead(userId);
    sumNotification = response.total;
    notifyListeners();
  }

  Future<void> getListNotification(int offset) async {
    try {
      if (offset == 0) {
        listNotification = null;
      }
      notifyListeners();

      int? userId = await ProfileUser.getCurrentUserId();
      var customResponse = await ProfileUser.getProfile();

      locator
          .get<MixPanelTrackingService>()
          .trackData(name: "Xem danh sách thông báo");
      List<NotificationResponse> response =
          await repo.getListNotification(userId, offset: offset, byStatus: 1);
      // await fetch(() async {
      //   response =
      //       await repo.getListNotification(userId, offset: offset, byStatus: 1);
      // });
      await getSumNotificationIsNotRead();
      if (offset == 0) {
        listNotification = [];
      }
      if (response.isNotEmpty) {
        listNotification!.addAll(response);
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }

  Future<void> getMessageNotification(int notficationID) async {
    NotificationLocalResponse response = await repo.getMessage(notficationID);
    notificationLocalResponse = response;
    notifyListeners();
  }

  Future<void> getMessageNotificationDetail(int) async {}

  void setIsRead(int index) {
    listNotification![index].isRead = true;
    notifyListeners();
  }

  Future<void> getDetailNotification(int notificationId) async {
    NotificationResponse? response =
        await repo.getNotificationDetail(notificationId);

    notificationResponse = response;
    notifyListeners();
  }

  Future<void> getNotficationByTypeConfigNoti(
      int notificationType, String sourceId,
      {Function(int id, int sourceId, int notiType)? onCallBack}) async {
    int? userId = await ProfileUser.getCurrentUserId();
    List<NotificationResponse> response = await repo.getListNotification(userId,
        byNotificationType: notificationType,
        bySourceId: int.tryParse(sourceId),
        offset: 0,
        byStatus: 1);
    listNotificationByConfigType = response;
    if (onCallBack != null) {
      onCallBack(
          listNotificationByConfigType!.first.id!,
          listNotificationByConfigType!.first.sourceId!,
          listNotificationByConfigType!.first.notificationType!);
    }
    notifyListeners();
  }

  Future<void> getDetailNotificationBySourceId(
      int sourceId, int typeId, int statusType, int notificationId) async {
    try {
      SettingModel setting = await boxSetting!.get(settingKey);
      notiContent = NotiContent(status: "", dateTime: "", content: "");
      notifyListeners();
      await repo.getNotificationDetail(notificationId);
      await getSumNotificationIsNotRead();
      var customResponse = await ProfileUser.getProfile();
      locator
          .get<MixPanelTrackingService>()
          .trackData(name: "Xem chi tiết thông báo");
      if (typeId == 2) {
        try {
          ReservationResponse response =
              await repo.getReservationBySourceId(sourceId);
          if (statusType == 2) {
            notiContent = NotiContent(
              status: setting.status!
                  .firstWhere((element) => element.id == response.status)
                  .name,
              idStatus: response.status,
              // dateTime:
              //     response.pickupAt!.toDateFormatString(response.createdAt!.day),
              internalNote: response.internalNote,
              driverName: response.driverName ?? '',
              carName: response.carType ?? '',
              carNumber: response.licensePlate ?? '',
              timeRequest: response.createdAt == null
                  ? ''
                  : response.createdAt!
                      .toFormatStringDateTime("HH:mm a dd/MM/yyyy"),
              timeArrive: response.arrivalAt == null
                  ? ''
                  : DateTime.parse(response.arrivalAt!)
                      .toFormatStringDateTime("HH:mm a dd/MM/yyyy"),
              // dateRequest: response.createdAt == null
              //     ? ''
              //     : response.createdAt!.toFormatStringDateTime("dd/MM/yyyy"),
              // dateArrive: response.arrivalAt == null
              //     ? ''
              //     : DateTime.parse(response.arrivalAt!)
              //         .toFormatStringDateTime("dd/MM/yyyy"),
            );
          } else {
            notiContent = NotiContent(
              status: setting.status!
                  .firstWhere((element) => element.id == response.status)
                  .name,
              idStatus: response.status,
              // dateTime:
              //     response.pickupAt!.toDateFormatString(response.createdAt!.day),
              driverName: response.driverName ?? '',
              carName: response.carType ?? '',
              carNumber: response.licensePlate ?? '',
              timeRequest: response.createdAt == null
                  ? ''
                  : response.createdAt!
                      .toLocal()
                      .toUtc()
                      .toFormatStringDateTime("HH:mm a dd/MM/yyyy"),
              timeArrive: response.arrivalAt == null
                  ? ''
                  : DateTime.parse(response.arrivalAt!)
                      .toFormatStringDateTime("HH:mm a dd/MM/yyyy"),
              // dateRequest: response.createdAt == null
              //     ? ''
              //     : response.createdAt!.toFormatStringDateTime("dd/MM/yyyy"),
              // dateArrive: response.arrivalAt == null
              //     ? ''
              //     : DateTime.parse(response.arrivalAt!)
              //         .toFormatStringDateTime("dd/MM/yyyy"),
              internalNote: response.internalNote,
            );
          }
        } catch (e) {
          notiContent = NotiContent(isError: true);
        }

        notifyListeners();
      } else if (typeId == 4) {
        // food and drink
        try {
          OrderDetailResponse response = await repo.getOrderBySourceId(
              sourceId, "order_products.products");
          productResponse = response;
          String productName = "";
          response.products!.map((e) {
            productName = "$productName ${e.name!}\n";
          }).toList();
          notiContent = NotiContent(
              idStatus: response.status,
              internalNote: response.internalNote,
              status: setting.status!
                  .firstWhere((element) => element.id == response.status)
                  .name,
              // dateTime: response.!.toDateString() + " - "+response.endedAt!.toDateString(),
              foodName: productName);
        } catch (e) {
          notiContent = NotiContent(
            isError: true,
          );
        }

        notifyListeners();
      } else if (typeId == 3) {
        // machine reservation
        try {
          MachineResponse response =
              await repo.getMachineReservationBySourceId(sourceId);
          machineResponse = response;
          notiContent = NotiContent(
              idStatus: response.status,
              status: setting.status!
                  .firstWhere((element) => element.id == response.status)
                  .name,
              startTime: response.startedAt == null
                  ? ''
                  : response.startedAt!
                      .toFormatStringDateTime("HH:mm a dd/MM/yyyy"),
              endTime: response.endedAt == null
                  ? ''
                  : response.endedAt!
                      .toFormatStringDateTime("HH:mm a dd/MM/yyyy"),
              internalNote: response.internalNote,
              gameTheme: response.machineName,
              gameNumber: response.machineNumber.toString());
        } catch (e) {
          notiContent = NotiContent(isError: true);
        }

        notifyListeners();
      } else {
        NotificationLocalResponse? response = await repo.getMessage(sourceId);
        notiContent = NotiContent(
            status: "System",

            // dateTime: response.startedAt!.toDateString() + " - "+response.endedAt!.toDateString(),
            content: response.content);
        // notificationResponse = response;

        notifyListeners();
      }
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
  }

  Future<void> deleteNotification(int id) async {
    int? userId = await ProfileUser.getCurrentUserId();
    try {
      var response = await repo
          .deleteNotification({"id": id, "user_id": userId, "status": 0});

      List<NotificationResponse> responseTmp = [];
      responseTmp =
          await repo.getListNotification(userId, offset: 0, byStatus: 1);
      await getSumNotificationIsNotRead();
      listNotification = responseTmp;
    } catch (e) {
      if (e is DioError) {
        catchError(e);
      }
    }
    notifyListeners();
  }
}
