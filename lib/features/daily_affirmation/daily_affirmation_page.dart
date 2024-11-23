import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../data/local_storage/hive_storage.dart';
import '../../data/models/affirmation_model.dart';

class DailyAffirmationPage extends StatefulWidget {
  @override
  _DailyAffirmationPageState createState() => _DailyAffirmationPageState();
}

class _DailyAffirmationPageState extends State<DailyAffirmationPage> {
  final TextEditingController _affirmationController = TextEditingController();
  bool _isSubmitted = false;
  AffirmationModel? _todayAffirmation;
  Duration? _timeLeft;

  @override
  void initState() {
    super.initState();
    _loadTodayAffirmation();
  }

  Future<void> _loadTodayAffirmation() async {
    final today = DateTime.now();
    final allAffirmations = await HiveStorage.getAllAffirmations();
    AffirmationModel? todayAffirmation;
    try {
      todayAffirmation = allAffirmations.firstWhere(
        (affirmation) =>
            affirmation.date.year == today.year &&
            affirmation.date.month == today.month &&
            affirmation.date.day == today.day,
      );
      setState(() {
        _todayAffirmation = todayAffirmation;
        _isSubmitted = true;
        _calculateTimeLeft();
      });
    } catch (e) {
      // No affirmation found for today
    }
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    final nextDay = DateTime(now.year, now.month, now.day + 1);
    setState(() {
      _timeLeft = nextDay.difference(now);
    });
  }

  void _saveAffirmation() async {
    final affirmation = AffirmationModel(
      text: _affirmationController.text,
      date: DateTime.now(),
    );
    await HiveStorage.saveAffirmation(affirmation);
    setState(() {
      _todayAffirmation = affirmation;
      _isSubmitted = true;
      _calculateTimeLeft();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Affirmations'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isSubmitted
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, size: 50, color: Colors.green),
                    const SizedBox(height: 16),
                    Text(
                      'You have submitted your affirmation for today!',
                      textAlign: TextAlign.center,
                      style: theme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    if (_timeLeft != null)
                      Text(
                        'Come back in: ${_timeLeft!.inHours}h ${_timeLeft!.inMinutes % 60}m ${_timeLeft!.inSeconds % 60}s',
                        style: theme.bodyMedium,
                      ),
                    const SizedBox(height: 16),
                    if (_todayAffirmation != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Today\'s Reflection:',
                                  style: theme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _todayAffirmation!.text,
                                  style: theme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Date: ${DateFormat('MMMM d, y').format(_todayAffirmation!.date)}',
                                  style: theme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'What\'s your affirmation for today?',
                    textAlign: TextAlign.center,
                    style: theme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _affirmationController,
                    decoration: InputDecoration(
                      hintText: 'Write your affirmation here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveAffirmation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
      ),
    );
  }
}
