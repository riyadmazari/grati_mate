import 'package:hive/hive.dart';
import '../models/affirmation_model.dart';
import '../models/weekly_data_model.dart';
import '../models/monthly_reflection_model.dart';
import '../models/progress_data_model.dart';
import '../models/inspiration_model.dart';
import '/services/sync_service.dart';

// Now you can use SyncService in this file

class HiveStorage {
  static const String affirmationBoxName = "affirmations";
  static const String weeklyDataBoxName = "weekly";
  static const String monthlyReflectionBoxName = "monthly_reflections";
  static const String progressBoxName = "progress";
  static const String inspirationBoxName = "inspirationWall";

  // Affirmations
  static Future<void> saveAffirmation(AffirmationModel affirmation) async {
    final box = await Hive.openBox<AffirmationModel>(affirmationBoxName);
    await box.add(affirmation);
    await SyncService.syncAffirmations(); // Sync with Firebase
  }

  static Future<List<AffirmationModel>> getAllAffirmations() async {
    final box = await Hive.openBox<AffirmationModel>(affirmationBoxName);
    return box.values.toList();
  }

  static Future<AffirmationModel?> getLatestAffirmation() async {
    final box = await Hive.openBox<AffirmationModel>(affirmationBoxName);
    return box.isNotEmpty ? box.values.last : null;
  }

  // Weekly Data
  static Future<void> saveWeeklyData(WeeklyDataModel weeklyData) async {
    final box = await Hive.openBox<WeeklyDataModel>(weeklyDataBoxName);
    await box.add(weeklyData);
    await SyncService.syncWeeklyData(); // Sync with Firebase
  }

  static Future<List<WeeklyDataModel>> getAllWeeklyData() async {
    final box = await Hive.openBox<WeeklyDataModel>(weeklyDataBoxName);
    return box.values.toList();
  }

  static Future<WeeklyDataModel?> getLatestWeeklyData() async {
    final box = await Hive.openBox<WeeklyDataModel>(weeklyDataBoxName);
    return box.isNotEmpty ? box.values.last : null;
  }

  // Monthly Reflections
  static Future<void> saveMonthlyReflection(MonthlyReflectionModel reflection) async {
    final box = await Hive.openBox<MonthlyReflectionModel>(monthlyReflectionBoxName);
    await box.add(reflection);
    await SyncService.syncMonthlyReflections(); // Sync with Firebase
  }

  static Future<List<MonthlyReflectionModel>> getAllMonthlyReflections() async {
    final box = await Hive.openBox<MonthlyReflectionModel>(monthlyReflectionBoxName);
    return box.values.toList();
  }

  // Progress Data
  static Future<void> saveProgress(ProgressDataModel progress) async {
    final box = await Hive.openBox<ProgressDataModel>(progressBoxName);
    await box.add(progress);
    await SyncService.syncProgressData(); // Sync with Firebase
  }

  static Future<List<ProgressDataModel>> getProgressData() async {
    final box = await Hive.openBox<ProgressDataModel>(progressBoxName);
    return box.values.toList();
  }

  // Inspiration Wall
  static Future<void> saveInspiration(InspirationModel inspiration) async {
    final box = await Hive.openBox<InspirationModel>(inspirationBoxName);
    await box.add(inspiration);
    await SyncService.syncInspirationWall(); // Sync with Firebase
  }

  static Future<List<InspirationModel>> getAllInspirations() async {
    final box = await Hive.openBox<InspirationModel>(inspirationBoxName);
    return box.values.toList();
  }

  static Future<void> deleteInspiration(InspirationModel inspiration) async {
    await inspiration.delete();
    await SyncService.syncInspirationWall(); // Sync with Firebase after deletion
  }

  // Global Synchronization
  static Future<void> syncAllData() async {
    await SyncService.syncAffirmations();
    await SyncService.syncWeeklyData();
    await SyncService.syncMonthlyReflections();
    await SyncService.syncProgressData();
    await SyncService.syncInspirationWall();
  }
}
