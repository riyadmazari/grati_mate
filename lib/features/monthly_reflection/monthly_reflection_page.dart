import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../data/local_storage/hive_storage.dart';
import '../../data/models/weekly_data_model.dart';
import '../../data/models/monthly_reflection_model.dart';

class MonthlyReflectionPage extends StatefulWidget {
  @override
  _MonthlyReflectionPageState createState() => _MonthlyReflectionPageState();
}

class _MonthlyReflectionPageState extends State<MonthlyReflectionPage> {
  final TextEditingController _winsController = TextEditingController();
  final TextEditingController _improvementsController = TextEditingController();
  final TextEditingController _inspirationController = TextEditingController();

  List<WeeklyDataModel> _weeklyFavorites = [];
  List<MonthlyReflectionModel> _pastMonthlyReflections = [];
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _loadWeeklyFavorites();
    _loadMonthlyReflections();
  }

  Future<void> _loadWeeklyFavorites() async {
    final weeklyData = await HiveStorage.getAllWeeklyData();
    setState(() {
      _weeklyFavorites = weeklyData.where((data) => data.favorite.isNotEmpty).toList();
    });
  }

  Future<void> _loadMonthlyReflections() async {
    final reflections = await HiveStorage.getAllMonthlyReflections();
    setState(() {
      _pastMonthlyReflections = reflections;
    });
  }

  void _saveMonthlyReflection() async {
    final monthlyReflection = MonthlyReflectionModel(
      wins: _winsController.text,
      improvements: _improvementsController.text,
      inspiration: _inspirationController.text,
      date: DateTime.now(),
    );
    await HiveStorage.saveMonthlyReflection(monthlyReflection);
    _loadMonthlyReflections(); // Reload after saving
    setState(() {
      _isSaved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Reflection'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isSaved
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, size: 50, color: Colors.green),
                    const SizedBox(height: 16),
                    Text(
                      'Thank you for completing this month’s reflection!',
                      textAlign: TextAlign.center,
                      style: theme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'See you next month!',
                      textAlign: TextAlign.center,
                      style: theme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSaved = false;
                        });
                      },
                      child: const Text('Add More Reflections'),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Weekly Favorite Affirmations
                          if (_weeklyFavorites.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Weekly Favorite Affirmations:',
                                  style: theme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                ..._weeklyFavorites.map((weekly) {
                                  return Card(
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      title: Text(
                                        weekly.favorite,
                                        style: theme.bodyLarge,
                                      ),
                                      subtitle: Text(
                                        'Date: ${DateFormat('MMMM d, y').format(weekly.date)}',
                                        style: theme.bodySmall,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          const SizedBox(height: 16),
                          // Monthly Reflection Inputs
                          Text(
                            'Biggest Wins:',
                            style: theme.titleMedium,
                          ),
                          TextField(
                            controller: _winsController,
                            decoration: const InputDecoration(
                              hintText: 'What were your biggest wins this month?',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Improvements:',
                            style: theme.titleMedium,
                          ),
                          TextField(
                            controller: _improvementsController,
                            decoration: const InputDecoration(
                              hintText: 'What can you improve on?',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Inspiration:',
                            style: theme.titleMedium,
                          ),
                          TextField(
                            controller: _inspirationController,
                            decoration: const InputDecoration(
                              hintText: 'Write quotes, lessons, or motivations.',
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          // Past Monthly Reflections
                          if (_pastMonthlyReflections.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Past Monthly Reflections:',
                                  style: theme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                ..._pastMonthlyReflections.map((reflection) {
                                  return Card(
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      title: Text(
                                        'Wins: ${reflection.wins}',
                                        style: theme.bodyLarge,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (reflection.improvements.isNotEmpty)
                                            Text(
                                              'Improvements: ${reflection.improvements}',
                                              style: theme.bodyMedium,
                                            ),
                                          if (reflection.inspiration.isNotEmpty)
                                            Text(
                                              'Inspiration: ${reflection.inspiration}',
                                              style: theme.bodyMedium,
                                            ),
                                          Text(
                                            'Date: ${DateFormat('MMMM y').format(reflection.date)}',
                                            style: theme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            )
                          else
                            Center(
                              child: Text(
                                'No monthly reflections yet. Start now!',
                                textAlign: TextAlign.center,
                                style: theme.bodyLarge,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _saveMonthlyReflection,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text('Save Monthly Reflection'),
                  ),
                ],
              ),
      ),
    );
  }
}
