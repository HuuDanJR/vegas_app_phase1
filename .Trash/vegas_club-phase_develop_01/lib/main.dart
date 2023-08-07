import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart' as provider;
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:vegas_club/common/utils/localizations.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/config/locator.dart';
import 'package:vegas_club/config/store_setting.dart';
import 'package:vegas_club/flavor_config.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/resource/theme.dart';
import 'package:vegas_club/route_generator.dart';
import 'package:vegas_club/service/navigator.service.dart';
import 'package:vegas_club/ui/view/home-screen/home.screen.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vegas_club/view_model/application.viewmodel.dart';
import 'package:vegas_club/view_model/booking_status.viewmodel.dart';
import 'package:vegas_club/view_model/coupon_list_screen.viewmodel.dart';
import 'package:vegas_club/view_model/food_reservation.viewmodel.dart';
import 'package:vegas_club/view_model/home_screen.viewmodel.dart';
import 'package:vegas_club/view_model/host_screen.viewmodel.dart';
import 'package:vegas_club/view_model/intro_screen.viewmodel.dart';
import 'package:vegas_club/view_model/jackpot_history.viewmodel.dart';
import 'package:vegas_club/view_model/login_screen.viewmodel.dart';
import 'package:vegas_club/view_model/machine_reservation.viewmodel.dart';
import 'package:vegas_club/view_model/message_screen.viewmodel.dart';
import 'package:vegas_club/view_model/notification_screen.viewmodel.dart';
import 'package:vegas_club/view_model/payment_screen.viewmodel.dart';
import 'package:vegas_club/view_model/point_pyramid_screen.viewmodel.dart';
import 'package:vegas_club/view_model/profile_screen.viewmodel.dart';
import 'package:vegas_club/view_model/promo_calendart_screen.viewmodel.dart';
import 'package:vegas_club/view_model/routette.viewmodel.dart';
import 'package:vegas_club/view_model/term_of_service.viewmodel.dart';
import 'package:vegas_club/view_model/user.viewmodel.dart';
import 'package:vegas_club/view_model/voucher_list_screen.viewmodel.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

var languageProvider = StateProvider((ref) => "en");
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  FlutterAppBadger.updateBadgeCount(1);
  bool isSupport = await FlutterAppBadger.isAppBadgeSupported();
  log("is suppoer$isSupport");
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  await dotenv.load(fileName: ".env");
  ConfigFlavor.setUpConfigDev();
  baseUrl = FlavorConfig.instance.variables['baseUrl'];
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  log('User granted permission: ${settings.authorizationStatus}');

  //setup singleton
  await setupLocator();
  await StoreConfig.initStore();

  //setup storage local
  await HiveUtil.init(directory);
  // provider.debugCheckInvalidValueType = null;
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initNotification() async {
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
  }

  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('app_icon');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );
  LinuxInitializationSettings initializationSettingsLinux =
      const LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    // defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // LocalJsonLocalization.delegate.directories = ['i18n'];
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(
            create: (_) => PromoCalendarViewModel()),
        provider.ChangeNotifierProvider(create: (_) => ApplicationViewmodel()),
        provider.ChangeNotifierProvider(
            create: (_) => BookingStatusViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => CouponListScreenViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => FoodReservationViewmodel()),
        provider.ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
        provider.ChangeNotifierProvider(create: (_) => HostScreenViewModel()),
        provider.ChangeNotifierProvider(create: (_) => IntroScreenViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => JackpotHistoryViewmodel()),
        provider.ChangeNotifierProvider(create: (_) => LoginScreenViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => MachineReservationViewmodel()),
        provider.ChangeNotifierProvider(
            create: (_) => MessageScreenViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => NotificationScreenViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => PaymentScreenViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => PointPyramidScreenViewModel()),
        provider.ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => PromoCalendarViewModel()),
        provider.ChangeNotifierProvider(create: (_) => RoutetteViewModel()),
        provider.ChangeNotifierProvider(
            create: (_) => VoucherListScreenViewModel()),
        provider.ChangeNotifierProvider(
          create: (_) => UserViewmodel(),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => TermOfServiceViewModel(),
        ),
      ],
      child: ResponsiveSizer(
        builder:
            (BuildContext context, Orientation orientation, ScreenType type) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: locator.get<CommonService>().navigatorKey,
            title: 'E-Vegas',
            theme: ThemeCustom.configTheme.copyWith(useMaterial3: false),
            home: const LoginScreen(),
            locale: const Locale("en"),
            supportedLocales: const [
              Locale('en'),
              Locale('vi'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              // GlobalMaterialLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate,
              // GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: RouteGenerator.generatorRoute,
          );
        },
      ),
    );
  }
}
