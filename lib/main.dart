import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routes/bottom_navigation.dart';
import 'data/models/affirmation_model.dart';
import 'data/models/weekly_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(AffirmationModelAdapter());
  Hive.registerAdapter(WeeklyDataModelAdapter());

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grati Mate',
      theme: ThemeData(
        useMaterial3: true, // Ensure Material 3 Typography is enabled
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: BottomNavigation(),
    );
  }
}
