import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const _reminderMe = 'REMINDER_ME';
  static const _isDarkTheme = 'DARK_THEME';

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
}
