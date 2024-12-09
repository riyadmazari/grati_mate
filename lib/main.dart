import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grati_mate/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes/bottom_navigation.dart';
import 'data/models/affirmation_model.dart';
import 'data/models/weekly_data_model.dart';
import 'data/models/progress_data_model.dart';
import 'data/models/inspiration_model.dart';
import 'data/models/monthly_reflection_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ); // Initialize Firebase
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  await Hive.initFlutter();
  print('Hive initialized successfully');

  // Register Hive Adapters
  Hive.registerAdapter(AffirmationModelAdapter());
  Hive.registerAdapter(WeeklyDataModelAdapter());
  Hive.registerAdapter(ProgressDataModelAdapter());
  Hive.registerAdapter(InspirationModelAdapter());
  Hive.registerAdapter(MonthlyReflectionModelAdapter());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grati Mate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BottomNavigation(),
    );
  }
}
