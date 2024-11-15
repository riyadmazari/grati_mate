import 'package:flutter/material.dart';
import '../data/monthly_reflection_provider.dart';

class MonthlyReflectionController {
  final TextEditingController winsController = TextEditingController();
  final TextEditingController improvementsController = TextEditingController();
  final TextEditingController quotesController = TextEditingController();
  final TextEditingController lessonsController = TextEditingController();

  final MonthlyReflectionProvider _provider = MonthlyReflectionProvider();

  Future<void> saveMonthlyReflection() async {
    final data = {
      "wins": winsController.text,
      "improvements": improvementsController.text,
      "quotes": quotesController.text,
      "lessons": lessonsController.text,
      "timestamp": DateTime.now().toIso8601String(),
    };
    await _provider.saveMonthlyReflection(data);
  }
}
