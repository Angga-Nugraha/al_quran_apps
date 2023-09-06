import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const reminderMe = 'REMINDER_ME';

  Future<bool> get isReminder async {
    final prefs = await sharedPreferences;
    return prefs.getBool(reminderMe) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(reminderMe, value);
  }
}
