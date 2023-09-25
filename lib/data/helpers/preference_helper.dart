import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const _reminderMe = 'REMINDER_ME';
  static const _isDarkTheme = 'DARK_THEME';
  static const _isFirstTime = 'FIRS_TIME';

  Future<bool> get isReminder async {
    final prefs = await sharedPreferences;
    return prefs.getBool(_reminderMe) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(_reminderMe, value);
  }

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(_isDarkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(_isDarkTheme, value);
  }

  Future<bool> get isFirstTime async {
    final prefs = await sharedPreferences;
    var value = prefs.getBool(_isFirstTime) ?? true;
    return value;
  }

  void setFirstTime(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(_isFirstTime, value);
  }
}
