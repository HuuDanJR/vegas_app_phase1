import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/config/mixpanel_config.dart';
import 'package:vegas_club/file_asset_gen/assets.gen.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/request/device_request.dart';
import 'package:vegas_club/models/response/customer_level_response.dart';
import 'package:vegas_club/models/response/setting_menu_response.dart';
import 'package:vegas_club/models/response/setting_model.dart';
import 'package:vegas_club/models/response/setting_response.dart';
import 'package:vegas_club/models/response/system_store_model.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/share_widget/dropdown.widget.dart';
import 'package:vegas_club/ui/view/home-screen/home.screen.dart';
import 'package:vegas_club/ui/view/login-screen/term_of_service.dart';
import 'package:vegas_club/view_model/application.viewmodel.dart';
import 'package:vegas_club/view_model/login_screen.viewmodel.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

MethodChannel platform =
    const MethodChannel('dexterx.dev/flutter_local_notifications_example');

String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

/// IMPORTANT: running the following code on its own won't work as there is
/// setup required for each platform head project.
///
/// Please download the complete example app from the GitHub repository where
/// all the setup has been done
class LoginScreen extends StateFullConsumer {
  const LoginScreen({Key? key}) : super(key: key);
  static const String route = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateConsumer<LoginScreen> {
  late TextEditingController userTextEdittingController;
  late TextEditingController pinCodeTextEdittingController;

  SettingResponse? settingResponse;
  List<DropdownModel> listDropdown = [
    DropdownModel(
        id: 1, value: "en", display: "ENG", widget: const Icon(Icons.flag)),
    DropdownModel(id: 1, value: "vi", display: "VN")
  ];

  var repo = Repository();

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {});
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {});
    }
  }

  requestTokenDevice() async {
    FirebaseMessaging.instance.requestPermission();

    //remove old device token
    String oldDeviceToken =
        await locator.get<AuthenticationService>().getDeviceToken();
    locator.get<Repository>().detroyTokenDevice({"token": oldDeviceToken});
    await locator.get<AuthenticationService>().removeDeviceToken();
    //
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      log("FCM Token request : ");
      print(newToken);
      int? userId = await ProfileUser.getCurrentUserId();
      locator.get<AuthenticationService>().setDevideToken(newToken);
      await repo.createTokenDevice(DeviceRequest(
              userId: userId,
              token: newToken,
              deviceType: Platform.isAndroid ? "android" : "ios",
              timeExpired: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day + 7)
                  .toString())
          .toJson());
    });
  }

  getTokenDevice() async {
    FirebaseMessaging.instance.getToken().then((newToken) async {
      log("FCM Token: ${newToken ?? 'Không có token device'}");
      if (newToken != null) {
        int? userId = await ProfileUser.getCurrentUserId();
        locator.get<AuthenticationService>().setDevideToken(newToken);
        await repo.createTokenDevice(DeviceRequest(
                userId: userId,
                token: newToken,
                deviceType: Platform.isAndroid ? "android" : "ios",
                timeExpired: DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day + 7)
                    .toString())
            .toJson());
      }
    });
  }

  Future<void> initSetting() async {
    await getSettingAndStoreToApp(Setting.termOfService, termOfServiceKey);
    await getSettingAndStoreToApp(Setting.bookingSetting, settingKey);
    await getSettingAndStoreToApp(Setting.customerLevel, settingCustomerLevel);
    await getSettingAndStoreToApp(Setting.showMenu, settingMenuKey);

    await getSettingAndStoreToApp(
        Setting.machineBookingConfig, settingMachineBooking);
    await getSettingAndStoreToApp(
        Setting.showFunctionDelete, settingFunctionDelete);
    await getSettingAndStoreToApp(
        Setting.notifcationTypeConfig, settingNotifcationTypeConfig);
    await getSettingAndStoreToApp(
        Setting.systemStoreMobile, settingSystemMobileConfig);

    await getSettingAndStoreToApp(Setting.mixpanelToken, mixPanelTokenStore);
    await getSettingAndStoreToApp(Setting.enableMixpanel, enableMixpanelStore);
    if (Platform.isAndroid) {
      await getSettingAndStoreToApp(
          Setting.versionAppAndroid, settingVersionApp);
    } else {
      await getSettingAndStoreToApp(Setting.versionAppIos, settingVersionApp);
    }
    await getSettingAndStoreToApp(
        Setting.appNameNotificationAndroid, appNameNotifcationAndroidStore);
    Provider.of<ApplicationViewmodel>(context, listen: false)
        .getSettingValueNotificationType();
  }

  Future<void> getSettingAndStoreToApp<T>(String setting, String key) async {
    List<SettingResponse> listSettingResponse = await repo.getSetting(setting);
    if (listSettingResponse.isNotEmpty) {
      settingResponse = listSettingResponse[0];

      final jsonSetting = settingResponse!.settingValue;

      try {
        if (key == settingSystemMobileConfig) {
          SystemStoreModel systemStoreModel =
              SystemStoreModel.fromJson(json.decode(jsonSetting!));
          await boxSetting!.put(key, systemStoreModel);
        } else {
          SettingModel settingModel =
              SettingModel.fromJson(json.decode(jsonSetting!));
          await boxSetting!.put(key, settingModel);
        }
      } catch (e) {
        if (setting == Setting.showMenu) {
          await boxSetting!.put(key, listSettingResponse[0].settingValue);
          var setingMenu = boxSetting!.get(key);
          List<SettingMenuResponse> listSetting =
              settingMenuResponseFromJson(setingMenu);
          if (!mounted) return;
          Provider.of<ApplicationViewmodel>(context, listen: false)
              .setSettingMenu(listSetting);
        } else if (setting == Setting.customerLevel) {
          await boxSetting!.put(key, listSettingResponse[0].settingValue);

          var customerLevel = boxSetting!.get(key);
          List<CustomerLevelResponse> listLevel =
              customerLevelResponseFromJson(customerLevel);

          await boxCustomer!.put(customerBoxKey, listLevel);
        } else if (setting == Setting.termOfService ||
            setting == Setting.mixpanelToken ||
            setting == Setting.enableMixpanel ||
            setting == Setting.appNameNotificationAndroid) {
          await boxSetting!.put(key, listSettingResponse[0].settingValue);
        }
        //  else if (setting == Setting.mixpanelToken) {
        //   await boxSetting!.put(key, listSettingResponse[0].settingValue);
        // } else if (setting == Setting.enableMixpanel) {
        //   await boxSetting!.put(key, listSettingResponse[0].settingValue);
        // }
        else {
          await boxSetting!.put(key, jsonSetting);
        }
      }
    }
  }

  Future<void> getVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo!.version;
    log("version: $version");
  }

  @override
  void initStateWidget() {
    _isAndroidPermissionGranted();
    _requestPermissions();

    userTextEdittingController = TextEditingController();
    pinCodeTextEdittingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LoginScreenViewModel>(context, listen: false)
          .initLogin(context, onSucess: () async {
        // await requestTokenDevice();
        locator.get<MixPanelTrackingService>().initMixpanel();

        initSetting();
        // ignore: use_build_context_synchronously

        locator.get<CommonService>().showWarningDialog(
            errorType: ErrorType.success, title: "Login thành công");

        pushReplaceName(HomeScreen.route);
      }, onFailed: () {
        Navigator.of(context).pop();
      });
    });
    // clearData();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(Assets.image_background_png.path),
            fit: BoxFit.fill,
          )),
          child: Consumer<LoginScreenViewModel>(
            builder: (BuildContext context, LoginScreenViewModel model,
                Widget? child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            children: [
                              Text.rich(
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor,
                                  TextSpan(
                                      text: "Welcome to",
                                      style: TextStyle(
                                          fontSize:
                                              isSmallScreen(context) ? 24 : 30,
                                          color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: "\nVegas Club",
                                            style: TextStyle(
                                                fontSize: isSmallScreen(context)
                                                    ? 24
                                                    : 30,
                                                fontWeight: FontWeight.w600))
                                      ]))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Center(
                          child: SizedBox(
                            height: isSmallScreen(context) ? 30 : 40.0,
                            width: isSmallScreen(context) ? 100 : 150,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    backgroundColor:
                                        const Color.fromRGBO(255, 43, 92, 1),
                                    textStyle: TextStyle(
                                        fontSize:
                                            isSmallScreen(context) ? 14 : 18,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: const TermOfService(),
                                          actionsOverflowDirection:
                                              VerticalDirection.down,
                                          actionsPadding:
                                              const EdgeInsets.all(0),
                                          actions: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      pop();
                                                    },
                                                    child: Container(
                                                      height: 40.0,
                                                      decoration: const BoxDecoration(
                                                          border: Border(
                                                              right: BorderSide(
                                                                  width: 0.5,
                                                                  color: Colors
                                                                      .grey),
                                                              top: BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey))),
                                                      child: const Center(
                                                          child: Text("Cancel",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      pop();
                                                      model.eventLogin(
                                                          onFailed: () {},
                                                          onSucess: () async {
                                                            locator
                                                                .get<
                                                                    MixPanelTrackingService>()
                                                                .initMixpanel(
                                                                    callBack:
                                                                        () {
                                                              locator
                                                                  .get<
                                                                      MixPanelTrackingService>()
                                                                  .identity();
                                                            });

                                                            // showAlertDialog(
                                                            //     typeDialog:
                                                            //         TypeDialog
                                                            //             .success,
                                                            //     title:
                                                            //         "Login success");
                                                            getTokenDevice();
                                                            await initSetting();
                                                            pushReplaceName(
                                                                HomeScreen
                                                                    .route);
                                                          });
                                                    },
                                                    child: Container(
                                                      height: 40.0,
                                                      decoration: const BoxDecoration(
                                                          border: Border(
                                                              left: BorderSide(
                                                                  width: 0.5,
                                                                  color: Colors
                                                                      .grey),
                                                              top: BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey))),
                                                      child: const Center(
                                                          child: Text(
                                                        "Consent",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: const FittedBox(
                                  child: TextWidget(
                                    text: 'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: FontFamily.quicksand),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: width(context),
                          height: isSmallScreen(context) ? 100 : 200.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Text(
                                  "Kindly note".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              FittedBox(
                                child: Text(
                                    "This application is non-commercial"
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
