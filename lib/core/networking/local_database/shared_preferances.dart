import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putString(
      {required String key, required String value}) async {
    return await sharedPreferences?.setString(key, value);
  }

  static String? getString({
    required String key,
  }) {
    return sharedPreferences?.getString(key);
  }

  static Future<bool?> putInt({required String key, required int value}) async {
    return await sharedPreferences?.setInt(key, value);
  }

  static int? getInt({
    required String key,
  }) {
    return sharedPreferences?.getInt(key);
  }

  static Future<bool?> putBool(
      {required String key, required bool value}) async {
    return await sharedPreferences?.setBool(key, value);
  }

  static bool? getBool({
    required String key,
  }) {
    return sharedPreferences?.getBool(key);
  }

  static void remove({
    required String key,
  }) {
    sharedPreferences?.remove(key);
  }
}
