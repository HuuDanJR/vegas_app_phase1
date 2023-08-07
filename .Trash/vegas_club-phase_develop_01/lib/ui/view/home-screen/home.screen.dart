import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/config/store_setting.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/main.dart';
import 'package:vegas_club/models/response/notification_local_response.dart';
import 'package:vegas_club/models/response/system_store_model.dart';
import 'package:vegas_club/models/setting_value_model.dart';
import 'package:vegas_club/notification_controller.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/share_widget/bottom_bar.widget.dart';
import 'package:vegas_club/ui/view/home-screen/home.widget.dart';
import 'package:vegas_club/ui/view/notification-screen/notification_detail.screen.dart';
import 'package:vegas_club/view_model/notification_screen.viewmodel.dart';
import 'dart:io';
import 'package:motion_toast/motion_toast.dart';

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

class HomeScreen extends StateFullConsumer {
  const HomeScreen({Key? key}) : super(key: key);
  static const String route = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');

class _HomeScreenState extends StateConsumer<HomeScreen> {
  PageController? _pageController;
  int? _selectedPageIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (Platform.isAndroid) {
        _showNotification(NotificationPayloadResponse.fromJson(message.data));
      }
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data.toString()}');
      Timer(const Duration(milliseconds: 2000), () {
        Provider.of<NotificationScreenViewModel>(context, listen: false)
            .getListNotification(0);
      });
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetch(() async {
        var res = boxSetting!.get(settingNotifcationTypeConfig);
        List<SettingValueModel> listTypeNotification =
            settingValueModelFromJson(res);

        SettingValueModel typeNoti = listTypeNotification.firstWhere(
            (element) =>
                element.name!.toLowerCase() ==
                message.data["type"].toString().toLowerCase());

        NotificationPayloadResponse payloadResponse =
            NotificationPayloadResponse.fromJson(message.data);
        Provider.of<NotificationScreenViewModel>(context, listen: false)
            .getNotficationByTypeConfigNoti(
                typeNoti.id!, payloadResponse.objectId!,
                onCallBack: (notiId, sourceId, notificationType) {
          locator.get<CommonService>().navigatoToRoute(
                  Utils.createRouteRightToLeft(NotificationDetailScreen(
                isRouteFromBottomBar: false,
                statusType: -1,
                title: "",
                notificationId: notiId,
                sourceId: sourceId,
                typeId: notificationType,
              )));
        });
      });
    });
  }

  Future<void> _showNotification(NotificationPayloadResponse res) async {
    var titleApp = await boxSetting!.get(appNameNotifcationAndroidStore);
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        1, titleApp ?? 'VG Caravelle', res.message, notificationDetails,
        payload: json.encode(res));
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      var res = boxSetting!.get(settingNotifcationTypeConfig);
      NotificationPayloadResponse payloadResponse =
          NotificationPayloadResponse.fromJson(json.decode(payload!));
      // pushNamed(NotificationScreen.route);
      List<SettingValueModel> listTypeNotification =
          settingValueModelFromJson(res);
      SettingValueModel typeNoti = listTypeNotification.firstWhere((element) =>
          element.name!.toLowerCase() == payloadResponse.type!.toLowerCase());
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<NotificationScreenViewModel>(context, listen: false)
            .getNotficationByTypeConfigNoti(
                typeNoti.id!, payloadResponse.objectId!,
                onCallBack: (notiId, sourceId, notificationType) {
          locator.get<CommonService>().navigatoToRoute(
                  Utils.createRouteRightToLeft(NotificationDetailScreen(
                isRouteFromBottomBar: false,
                statusType: -1,
                title: "",
                notificationId: notiId,
                sourceId: sourceId,
                typeId: notificationType,
              )));
        });
      });
    });
  }

//   Future<void> autoUpdate() async {
//     // Android/Windows

//     // var updater = UpdateManager(versionUrl: 'versionUrl');

// // iOS
//     var updater = UpdateManager(appId: 6443826209, countryCode: 'us');

// // App Store country code, this flag is optional and only applies to iOS
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();

//     var result = await updater.fetchUpdates();
//     log("update.......");
//     print(result?.latestVersion.toString());
//     print(result?.downloadUrl);
//     print(result?.releaseNotes);
//     print(result?.releaseDate);

//     if (result?.latestVersion.toString() != packageInfo.version) {
//       // Get update stream controller
//       var update = await result?.runUpdate(
//         'https://apps.apple.com/vn/app/e-vegas/id6443826209?l=vi',
//       );

//       // update?.stream.listen((event) async {
//       //   // You can build a download progressbar from the data available here
//       //   print(event.receivedBytes);
//       //   print(event.totalBytes);
//       //   if (event.completed) {
//       //     print('Download completed');

//       //     // Close the stream controller
//       //     await update.close();

//       //     // On Windows, autoExit and exitDelay flag are supported.
//       //     // On iOS, this will attempt to launch the App Store from the appId provided
//       //     // On Android, this will simply attempt to install the downloaded APK
//       //     await result?.runUpdate(event.path, autoExit: true, exitDelay: 5000);
//       //   }
//       // });
//     }
//   }

  // ProfileScreenViewModel? model;
  Future<void> getVersion() async {
    packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo!.version;
    log("version: $version");
    var versionAppStore = await boxSetting!.get(settingVersionApp);
    log("version store: $versionAppStore");
    String? systemApp = await boxSetting!.get(settingSystemMobileConfig);
    SystemStoreModel systemStore =
        SystemStoreModel.fromJson(json.decode(systemApp!));
    log("system app : ${systemStore.toJson()}");
    if (version != versionAppStore && systemStore.canUpdate == true) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: ColorName.primary,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Text("Notification"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Update new version!",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: buttonView(
                              onPressed: () {
                                pop();
                              },
                              text: "Cancel")),
                      Expanded(
                          child: buttonView(
                              onPressed: () {
                                if (Platform.isAndroid) {
                                  launchUrl(Uri.parse(systemStore.urlAndroid!));
                                } else {
                                  launchUrl(Uri.parse(systemStore.urlApple!));
                                }
                              },
                              text: "Update")),
                    ],
                  )
                ],
              ),
            );
          });
    }
  }

  @override
  void initStateWidget() {
    _selectedPageIndex = 0;
    // _initNotification();
    // locator.get<NotificationService>().onListenMessage();
    _pageController = PageController(initialPage: _selectedPageIndex!);

    NotificationController.startListeningNotificationEvents();
    // autoUpdate();
    initNotification();
    _configureSelectNotificationSubject();
    getVersion();
    setupInteractedMessage();
    _showAlertSuccess();
  }

  Future<void> _showAlertSuccess() async {
    bool isFirstLogin =
        await StoreConfig.getConfigFromStore(SharePreferenceKey.isFirstLogin);
    MotionToast.success(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      position: MotionToastPosition.top,
      // title: Text("User Data"), ,

      description: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              "Login successful!",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )),
      // padding: EdgeInsets,
      displaySideBar: false,
      animationDuration: const Duration(seconds: 1),
      toastDuration: const Duration(seconds: 2),
      animationType: AnimationType.fromTop,
      onClose: () {
        // MotionToast.error(
        //   title: Text("User Data"),
        //   description: Text("Your data has been deleted"),
        // ).show(context);
      },
    ).show(context);
    await StoreConfig.setConfigToStore<bool>(
        SharePreferenceKey.isFirstLogin, false);
    if (true) {

    }
  }

  Widget _body() {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorName.primary,
        ),
        key: _scaffoldKey,
        // drawer: DrawableWidget(
        //   onRouteToScreen: (widgetChild) {
        //     _scaffoldKey.currentState!.openEndDrawer();
        //     locator
        //         .get<CommonService>()
        //         .navigatoToRoute(Utils.createRouteBottomToTop(widgetChild));
        //   },
        // ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: widgetOptions,
        ),
        bottomNavigationBar: BottomBarWidget(
          onPageView: (index) {
            print(index);
            _pageController!.jumpToPage(index);
            // Provider.of<HomeScreenViewModel>(context, listen: false)
            //     .changePage(index);
          },
        ),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return _body();
  }

  @override
  void disposeWidget() {}
}
