import 'package:flutter/material.dart';
import '../features/daily_affirmation/daily_affirmation_page.dart';
import '../features/weekly_checkin/weekly_checkin_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/daily': (context) => DailyAffirmationPage(),
    '/weekly': (context) => WeeklyCheckInPage(),
  };
}
