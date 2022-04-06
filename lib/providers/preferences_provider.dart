import 'package:flutter/material.dart';

import '../helpers/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyReminderPreferences();
  }

  bool _isDailyReminderActive = false;
  bool get isDailyReminderActive => _isDailyReminderActive;

  void _getDailyReminderPreferences() async {
    _isDailyReminderActive = await preferencesHelper.isDailyScheduledActive;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyScheduled(value);
    _getDailyReminderPreferences();
  }
}
