import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import '../data/models/affirmation_model.dart';
import '../data/models/weekly_data_model.dart';
import '../data/models/monthly_reflection_model.dart';
import '../data/models/progress_data_model.dart';
import '../data/models/inspiration_model.dart';

class SyncService {
  static final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Affirmations Sync
  static Future<void> syncAffirmations() async {
    final box = await Hive.openBox<AffirmationModel>('affirmations');
    final DatabaseReference affirmationsRef = _database.ref('affirmations');

    // Push local data to Firebase
    for (var affirmation in box.values) {
      final snapshot = await affirmationsRef.orderByChild('text').equalTo(affirmation.text).get();
      if (snapshot.value == null) {
        await affirmationsRef.push().set({
          'text': affirmation.text,
          'date': affirmation.date.toIso8601String(),
        });
      }
    }

    // Pull Firebase data to Hive
    final snapshot = await affirmationsRef.get();
    if (snapshot.value != null) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in data.values) {
        final affirmation = AffirmationModel(
          text: entry['text'] as String,
          date: DateTime.parse(entry['date'] as String),
        );
        if (!box.values.any((a) => a.text == affirmation.text && a.date == affirmation.date)) {
          await box.add(affirmation);
        }
      }
    }
  }

  // Weekly Data Sync
  static Future<void> syncWeeklyData() async {
    final box = await Hive.openBox<WeeklyDataModel>('weekly');
    final DatabaseReference weeklyRef = _database.ref('weekly');

    // Push local data to Firebase
    for (var weekly in box.values) {
      final snapshot = await weeklyRef.orderByChild('reflection').equalTo(weekly.reflection).get();
      if (snapshot.value == null) {
        await weeklyRef.push().set({
          'reflection': weekly.reflection,
          'favorite': weekly.favorite,
          'focus': weekly.focus,
          'date': weekly.date.toIso8601String(),
        });
      }
    }

    // Pull Firebase data to Hive
    final snapshot = await weeklyRef.get();
    if (snapshot.value != null) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in data.values) {
        final weekly = WeeklyDataModel(
          reflection: entry['reflection'] as String,
          favorite: entry['favorite'] as String,
          focus: entry['focus'] as String,
          date: DateTime.parse(entry['date'] as String),
        );
        if (!box.values.any((w) => w.reflection == weekly.reflection && w.date == weekly.date)) {
          await box.add(weekly);
        }
      }
    }
  }

  // Monthly Reflections Sync
  static Future<void> syncMonthlyReflections() async {
    final box = await Hive.openBox<MonthlyReflectionModel>('monthly_reflections');
    final DatabaseReference reflectionsRef = _database.ref('monthly_reflections');

    // Push local data to Firebase
    for (var reflection in box.values) {
      final snapshot = await reflectionsRef
          .orderByChild('biggestWin')
          .equalTo(reflection.wins)
          .get();
      if (snapshot.value == null) {
        await reflectionsRef.push().set({
          'biggestWin': reflection.wins,
          'improvement': reflection.improvements,
          'date': reflection.date.toIso8601String(),
        });
      }
    }

    // Pull Firebase data to Hive
    final snapshot = await reflectionsRef.get();
    if (snapshot.value != null) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in data.values) {
        final reflection = MonthlyReflectionModel(
          wins: entry['biggestWin'] as String,
          improvements: entry['improvement'] as String,
          inspiration: entry['inspiration'] as String,
          date: DateTime.parse(entry['date'] as String),
        );
        if (!box.values.any((m) => m.wins == reflection.wins && m.date == reflection.date)) {
          await box.add(reflection);
        }
      }
    }
  }

  // Progress Data Sync
  static Future<void> syncProgressData() async {
    final box = await Hive.openBox<ProgressDataModel>('progress');
    final DatabaseReference progressRef = _database.ref('progress');

    // Push local data to Firebase
    for (var progress in box.values) {
      final snapshot = await progressRef.orderByChild('content').equalTo(progress.content).get();
      if (snapshot.value == null) {
        await progressRef.push().set({
          'content': progress.content,
          'type': progress.type,
          'date': progress.date.toIso8601String(),
        });
      }
    }

    // Pull Firebase data to Hive
    final snapshot = await progressRef.get();
    if (snapshot.value != null) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in data.values) {
        final progress = ProgressDataModel(
          content: entry['content'] as String,
          type: entry['type'] as String,
          date: DateTime.parse(entry['date'] as String),
        );
        if (!box.values.any((p) => p.content == progress.content && p.date == progress.date)) {
          await box.add(progress);
        }
      }
    }
  }

  // Inspiration Wall Sync
  static Future<void> syncInspirationWall() async {
    final box = await Hive.openBox<InspirationModel>('inspirationWall');
    final DatabaseReference inspirationRef = _database.ref('inspirationWall');

    // Push local data to Firebase
    for (var inspiration in box.values) {
      final snapshot = await inspirationRef.orderByChild('text').equalTo(inspiration.text).get();
      if (snapshot.value == null) {
        await inspirationRef.push().set({
          'text': inspiration.text,
          'date': inspiration.date.toIso8601String(),
        });
      }
    }

    // Pull Firebase data to Hive
    final snapshot = await inspirationRef.get();
    if (snapshot.value != null) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      for (var entry in data.values) {
        final inspiration = InspirationModel(
          text: entry['text'] as String,
          date: DateTime.parse(entry['date'] as String),
        );
        if (!box.values.any((i) => i.text == inspiration.text && i.date == inspiration.date)) {
          await box.add(inspiration);
        }
      }
    }
  }

  // Global Synchronization
  static Future<void> syncAllData() async {
    await syncAffirmations();
    await syncWeeklyData();
    await syncMonthlyReflections();
    await syncProgressData();
    await syncInspirationWall();
  }
}
