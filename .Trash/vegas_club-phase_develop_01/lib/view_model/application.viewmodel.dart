import 'dart:convert';

import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/config/store_setting.dart';
import 'package:vegas_club/models/response/setting_menu_response.dart';
import 'package:vegas_club/models/setting_value_model.dart';

class Setting {
  static const bookingSetting = "BOOKING_CONFIG";
  static const machineBookingConfig = "MACHINE_BOOKING_CONFIG";
  static const showFunctionDelete = "SHOW_FUNCTION_DELETE";
  static const notifcationTypeConfig = "NOTIFICATION_TYPE_MOBILE";
  static const systemStoreMobile = "SYSTEM_STORE_MOBILE";
  static const versionAppAndroid = "VERSION_APP_ANDROID";
  static const versionAppIos = "VERSION_APP_IOS";
  static const showMenu = "SHOW_MENU";
  static const customerLevel = "CUSTOMER_LEVEL";
  static const termOfService = "TERM_OF_SERVICE";
  static const mixpanelToken = "MIXPANEL_TOKEN";
  static const enableMixpanel = "ENALBLE_MIXPANEL";
  static const appNameNotificationAndroid = "APP_NAME_NOTIFICATION";
}

class ApplicationViewmodel extends ChangeNotifier with BaseFunction {
  List<SettingMenuResponse> listSetting = [];
  List<SettingValueModel> listSettingValueNotificationType = [];

  Future<void> setSettingMenu(List<SettingMenuResponse> list) async {
    listSetting = list;
    await StoreConfig.setConfigToStore<String>(
        settingMenuKey, json.encode(listSetting));

    notifyListeners();
  }

  Future<void> getSettingMenu() async {
    String? settingStore = await StoreConfig.getConfigFromStore(settingMenuKey);
    print("settings menu: $settingStore");
    List<SettingMenuResponse> listSettingTmp =
        settingMenuResponseFromJson(settingStore!);
    listSetting = listSettingTmp;
    notifyListeners();
  }

  Future<void> clearSettingMenu() async {}

  Future<void> getSettingValueNotificationType() async {
    var res = boxSetting!.get(settingNotifcationTypeConfig);
    listSettingValueNotificationType = settingValueModelFromJson(res);
    notifyListeners();
  }
}
