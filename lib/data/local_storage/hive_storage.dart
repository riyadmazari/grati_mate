import 'package:hive/hive.dart';
import '../models/affirmation_model.dart';
import '../models/weekly_data_model.dart';
import '../models/monthly_reflection_model.dart';
import '../models/progress_data_model.dart';
import '../models/inspiration_model.dart';

class HiveStorage {
  static const String affirmationBoxName = "affirmations";
  static const String weeklyDataBoxName = "weekly";

  // Affirmations
  static Future<void> saveAffirmation(AffirmationModel affirmation) async {
    final box = await Hive.openBox<AffirmationModel>(affirmationBoxName);
    await box.add(affirmation);
  }

  static Future<AffirmationModel?> getLatestAffirmation() async {
    final box = await Hive.openBox<AffirmationModel>(affirmationBoxName);
    if (box.isNotEmpty) {
      return box.values.last;
    }
    return null;
  }

  static Future<List<AffirmationModel>> getAllAffirmations() async {
    final box = await Hive.openBox<AffirmationModel>(affirmationBoxName);
    return box.values.toList();
  }

  // Weekly Data
  static Future<void> saveWeeklyData(WeeklyDataModel weeklyData) async {
    final box = await Hive.openBox<WeeklyDataModel>(weeklyDataBoxName);
    await box.add(weeklyData);
  }

  static Future<List<WeeklyDataModel>> getAllWeeklyData() async {
    final box = await Hive.openBox<WeeklyDataModel>(weeklyDataBoxName);
    return box.values.toList();
  }

  static Future<WeeklyDataModel?> getLatestWeeklyData() async {
    final box = await Hive.openBox<WeeklyDataModel>(weeklyDataBoxName);
    if (box.isNotEmpty) {
      return box.values.last;
    }
    return null;
  }

  static const String monthlyReflectionBoxName = "monthly_reflections";

  static Future<void> saveMonthlyReflection(MonthlyReflectionModel reflection) async {
    final box = await Hive.openBox<MonthlyReflectionModel>(monthlyReflectionBoxName);
    await box.add(reflection);
  }

  static Future<List<MonthlyReflectionModel>> getAllMonthlyReflections() async {
    final box = await Hive.openBox<MonthlyReflectionModel>(monthlyReflectionBoxName);
    return box.values.toList();
  }

  static const String progressBoxName = "progress";

  static Future<void> saveProgress(ProgressDataModel progress) async {
    final box = await Hive.openBox<ProgressDataModel>(progressBoxName);
    await box.add(progress);
  }

  static Future<List<ProgressDataModel>> getProgressData() async {
    final box = await Hive.openBox<ProgressDataModel>(progressBoxName);
    return box.values.toList();
  }

  static Future<List<ProgressDataModel>> getProgressByType(String type) async {
    final box = await Hive.openBox<ProgressDataModel>(progressBoxName);
    return box.values.where((item) => item.type == type).toList();
  }

  static const String inspirationBoxName = "inspirationWall";

  static Future<void> saveInspiration(InspirationModel inspiration) async {
    final box = await Hive.openBox<InspirationModel>(inspirationBoxName);
    await box.add(inspiration);
  }

  static Future<List<InspirationModel>> getAllInspirations() async {
    final box = await Hive.openBox<InspirationModel>(inspirationBoxName);
    return box.values.toList();
  }

  static Future<void> deleteInspiration(InspirationModel inspiration) async {
    await inspiration.delete();
  }


}
