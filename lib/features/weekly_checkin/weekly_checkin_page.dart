import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../data/local_storage/hive_storage.dart';
import '../../data/models/weekly_data_model.dart';
import '../../data/models/affirmation_model.dart';

class WeeklyCheckInPage extends StatefulWidget {
  @override
  _WeeklyCheckInPageState createState() => _WeeklyCheckInPageState();
}

class _WeeklyCheckInPageState extends State<WeeklyCheckInPage> {
  final TextEditingController _focusController = TextEditingController();
  final TextEditingController _reflectionController = TextEditingController();
  final TextEditingController _favoriteController = TextEditingController();
  bool _isSaved = false;
  WeeklyDataModel? _currentWeekReflection;

  List<WeeklyDataModel> _pastWeeklyData = [];
  List<AffirmationModel> _weekAffirmations = [];

  @override
  void initState() {
    super.initState();
    _checkCurrentWeekSaved();
    _loadWeeklyData();
    _loadWeeklyAffirmations();
  }

  Future<void> _checkCurrentWeekSaved() async {
    final latestWeekly = await HiveStorage.getLatestWeeklyData();
    if (latestWeekly != null) {
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
      final endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

      setState(() {
        if (latestWeekly.date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            latestWeekly.date.isBefore(endOfWeek.add(const Duration(days: 1)))) {
          _currentWeekReflection = latestWeekly;
          _isSaved = true;
        }
      });
    }
  }

  Future<void> _loadWeeklyData() async {
    final data = await HiveStorage.getAllWeeklyData();
    setState(() {
      _pastWeeklyData = data;
    });
  }

  Future<void> _loadWeeklyAffirmations() async {
    final allAffirmations = await HiveStorage.getAllAffirmations();
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
    final endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

    setState(() {
      _weekAffirmations = allAffirmations.where((affirmation) {
        final date = affirmation.date;
        return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            date.isBefore(endOfWeek.add(const Duration(days: 1)));
      }).toList();
    });
  }

  void _saveWeeklyData() async {
    final weeklyData = WeeklyDataModel(
      focus: _focusController.text,
      reflection: _reflectionController.text,
      favorite: _favoriteController.text,
      date: DateTime.now(),
    );
    await HiveStorage.saveWeeklyData(weeklyData);
    _loadWeeklyData(); // Reload after saving
    setState(() {
      _isSaved = true;
      _currentWeekReflection = weeklyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Check-In'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!_isSaved) ...[
                  if (_weekAffirmations.isNotEmpty) ...[
                    Text(
                      'Daily Affirmations This Week:',
                      style: theme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ..._weekAffirmations.map((affirmation) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            affirmation.text,
                            style: theme.bodyLarge,
                          ),
                          subtitle: Text(
                            'Date: ${DateFormat('MMMM d, y').format(affirmation.date)}',
                            style: theme.bodySmall,
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    'Highlight a Favorite:',
                    style: theme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    controller: _favoriteController,
                    decoration: const InputDecoration(
                      hintText: 'What was your favorite affirmation?',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Reflect:',
                    style: theme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    controller: _reflectionController,
                    decoration: const InputDecoration(
                      hintText: 'What progress have you made this week?',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Focus for Next Week:',
                    style: theme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    controller: _focusController,
                    decoration: const InputDecoration(
                      hintText: 'Set your focus or theme for next week',
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _saveWeeklyData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text('Save Weekly Check-In'),
                  ),
                ],
                if (_isSaved) ...[
                  const SizedBox(height: 16),
                  const Icon(Icons.check_circle, size: 50, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    'Thank you for completing this week’s check-in!',
                    textAlign: TextAlign.center,
                    style: theme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Check back next week!',
                    textAlign: TextAlign.center,
                    style: theme.bodyLarge,
                  ),
                ],
                if (_currentWeekReflection != null) ...[
                  const SizedBox(height: 32),
                  Text(
                    'Your Weekly Reflection:',
                    style: theme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    color: Colors.blue[50],
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Favorite: ${_currentWeekReflection?.favorite ?? "No favorite noted"}',
                            style: theme.bodyLarge,
                          ),
                          Text(
                            'Reflection: ${_currentWeekReflection?.reflection ?? "No reflection"}',
                            style: theme.bodyLarge,
                          ),
                          Text(
                            'Focus: ${_currentWeekReflection?.focus ?? "No focus set"}',
                            style: theme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
