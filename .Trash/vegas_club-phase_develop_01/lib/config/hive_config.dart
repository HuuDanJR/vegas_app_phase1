import 'dart:io';

import 'package:hive/hive.dart';
import 'package:vegas_club/models/auth.model.dart';
import 'package:vegas_club/models/response/customer_level_response.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/models/response/setting_model.dart';
import 'package:vegas_club/models/response/setting_response.dart';

String box = "box";
String settingBox = "settingBox";
String customerBox = "customerBox";
String settingKey = "USER_CUSTOMER";
String settingMenuKey = "SETTING_MENU_KEY";
String settingMachineBooking = "SETTING_MACHINE_BOOKING";
String settingFunctionDelete = "SETTING_FUNCTION_DELETE";
String settingNotifcationTypeConfig = "SETTING_NOTIFICATION_TYPE_CONFIG";
String settingSystemMobileConfig = "SETTING_SYSTEM_MOBILE_CONFIG";
String settingVersionApp = "SETTING_VERSION_APP";
String settingCustomerLevel = "CUSTOMER_LEVEL";
String customerBoxKey = "CUSTOMER_BOX_KEY";
String customerLevelKey = "CUSTOMER_LEVEL_KEY";
String termOfServiceKey = "TERM_OF_SERVICE_KEY";
String levelKey = "LEVEL_KEY";
String settingMenu = "SETTING_MENU";
String mixPanelTokenStore = "MIXPANEL_TOKEN_STORE";
String enableMixpanelStore = "ENABLE_MIXPANEL_STORE";
String appNameNotifcationAndroidStore = "APP_NAME_NOTIFICATION_ANDROID_STORE";

///////
Box? boxAuth;
Box? boxSetting;
Box? boxCustomer;

class HiveUtil {
  static Future<void> init(Directory directory) async {
    // Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive
      ..init(directory.path)
      ..registerAdapter(UserAdapter())
      ..registerAdapter(AuthModelAdapter())
      ..registerAdapter(CustomerResponseAdapter())
      ..registerAdapter(SettingResponseAdapter())
      ..registerAdapter(SettingModelAdapter())
      ..registerAdapter(SettingItemAdapter())
      ..registerAdapter(CustomerLevelResponseAdapter());
    await Hive.openBox(box);
    await Hive.openBox(settingBox);
    await Hive.openBox(customerBox);
    boxAuth = Hive.box(box);
    boxSetting = Hive.box(settingBox);
    boxCustomer = Hive.box(customerBox);
  }
}
