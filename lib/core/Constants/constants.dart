import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';

class Constants {
  static String version = 'V2';
  static String id = CashHelper.getString(key: 'id') ?? '';
  static String email = CashHelper.getString(key: 'email') ?? '';
  static String token = CashHelper.getString(key: 'token') ?? '';
  static String department = CashHelper.getString(key: 'department') ?? '';
  static String name = CashHelper.getString(key: 'name') ?? '';
  static String uid = CashHelper.getString(key: 'uid') ?? '';
  static String qrCode = CashHelper.getString(key: 'qrCode') ?? '';
  static String gender = CashHelper.getString(key: 'gender') ?? 'Male';
  static String today = CashHelper.getString(key: 'today') ?? '';
  static bool refreshed = CashHelper.getBool(key: 'refreshed') ?? false;
  static String cashedPasscode =
      CashHelper.getString(key: 'cashedPasscode') ?? '';
  static String image = CashHelper.getString(key: 'image') ?? '';
  static String badge = CashHelper.getString(key: 'badge') ?? '';
  static String level = CashHelper.getString(key: 'level') ?? '';

  static bool blocked = CashHelper.getBool(key: 'blocked') ?? false;
  static bool isAdmin = CashHelper.getBool(key: 'admin') ?? false;
  static String adminName = CashHelper.getString(key: 'adminName') ?? '';
  static String adminGender = CashHelper.getString(key: 'adminGender') ?? '';
  static String adminId = CashHelper.getString(key: 'adminId') ?? '';
  static String lecturerPasscode =
      CashHelper.getString(key: 'lecturerPasscode') ?? '';
  static int attendanceLength(String passcode) =>
      CashHelper.getInt(key: '${passcode}Length') ?? 0;
}
