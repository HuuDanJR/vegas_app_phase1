import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? pref;

class SharePreferenceKey {
  static String isFirstLogin = "isFirstLogin";
}

class StoreConfig {
  StoreConfig._internal();

  static Future<void> initStore() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setConfigToStore<T>(String key, T value) async {
    pref = await SharedPreferences.getInstance();
    if (value is bool) {
      await pref!.setBool(key, value);
    } else if (value is String) {
      await pref!.setString(key, value);
    } else if (value is int) {
      await pref!.setInt(key, value);
    } else if (value is double) {
      await pref!.setDouble(key, value);
    } else {
      await pref!.setString(key, value as String);
    }

  }

  static Future<T?> getConfigFromStore<T>(String key) async {
    pref = await SharedPreferences.getInstance();
    // if (T is String) {
    //   return pref!.getString(key) as T;
    // } else if (T is int) {
    //   return pref!.getInt(key) as T;
    // } else if (T is double) {
    //   return pref!.getDouble(key) as T;
    // } else if (T is bool) {
    //   return pref!.getBool(key) as T;
    // }
    return pref!.get(key) as T;
  }

  static Future<void> clearConfigStore() async {
    pref = await SharedPreferences.getInstance();
    await pref!.clear();
  }
}
