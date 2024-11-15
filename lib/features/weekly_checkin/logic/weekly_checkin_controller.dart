import 'package:flutter/material.dart';
import '../data/weekly_checkin_provider.dart';

class WeeklyCheckInController {
  final TextEditingController favoriteEntryController = TextEditingController();
  final TextEditingController progressReflectionController = TextEditingController();
  final TextEditingController weeklyFocusController = TextEditingController();

  final WeeklyCheckInProvider _provider = WeeklyCheckInProvider();

  Future<void> saveWeeklyCheckIn() async {
    final data = {
      "favoriteEntry": favoriteEntryController.text,
      "progressReflection": progressReflectionController.text,
      "weeklyFocus": weeklyFocusController.text,
      "timestamp": DateTime.now().toIso8601String(),
    };
    await _provider.saveWeeklyCheckIn(data);
  }
}
