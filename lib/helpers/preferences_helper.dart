import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyScheduled = "DAILY_REMINDER";

  Future<bool> get isDailyScheduledActive async {
    final prefs = await sharedPreferences;

    return prefs.getBool(dailyScheduled) ?? false;
  }

  void setDailyScheduled(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyScheduled, value);
  }
}
