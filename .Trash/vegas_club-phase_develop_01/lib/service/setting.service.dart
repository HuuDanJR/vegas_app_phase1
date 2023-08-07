import 'package:vegas_club/config/hive_config.dart';
import 'package:vegas_club/models/response/setting_model.dart';

class SettingService {
  // static Future<void> setSetting()

  static Future<SettingModel> getSetting() async {
    return await boxSetting!.get(settingKey);
  }
}
