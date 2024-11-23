import 'package:flutter/material.dart';
import 'progress_overview_widgets.dart';
import '../../data/local_storage/hive_storage.dart';
import '../../data/models/affirmation_model.dart';
import '../../data/models/weekly_data_model.dart';
import '../../data/models/progress_data_model.dart';
import 'package:sentiment_dart/sentiment_dart.dart';

class ProgressOverviewPage extends StatefulWidget {
  @override
  _ProgressOverviewPageState createState() => _ProgressOverviewPageState();
}

class _ProgressOverviewPageState extends State<ProgressOverviewPage> {
  List<AffirmationModel> _affirmations = [];
  List<WeeklyDataModel> _weeklyData = [];
  Map<String, int> _wordFrequency = {};
  Map<String, int> _sentimentFrequency = {"Positive": 0, "Neutral": 0, "Negative": 0};
  String _monthlyBiggestWin = "No wins recorded yet";
  String _selectedReflection = "No reflection selected";
  int _currentStreak = 0;

  final List<String> _stopWords = [
    "i", "am", "to", "be", "today", "the", "and", "is", "a", "of", "in", "on", "for", "at", "this",
    "it", "with", "as", "that", "have", "has", "do", "does", "did", "will", "would", "can", "could",
    "shall", "should", "may", "might", "you", "me", "we", "they", "he", "she", "was", "were", "are",
    "an", "my", "your", "their", "his", "her", "its", "our", "us", "what", "which", "when", "where",
    "who", "whom", "why", "how", "had", "been", "being", "all", "any", "some", "no", "not", "yes",
    "also", "just", "but", "if", "or", "because", "so", "up", "down", "into", "out", "by", "from",
    "about", "over", "under", "again", "then", "there", "here", "after", "before", "during",
    "while", "both", "each", "few", "more", "most", "other", "such", "only", "own", "same",
    "tell", "say", "said", "go", "went", "gone", "make", "made", "know", "knew", "known",
    "think", "thought", "see", "saw", "seen", "look", "looked", "feel", "felt", "like", "liked", "want", "wanted",
    "use", "used", "find", "found", "give", "gave", "work", "worked", "call", "called", "try", "tried",
    "need", "needed", "feel", "felt", "become", "became", "leave", "left", "put", "put", "mean", "meant",
    "keep", "kept", "let", "let", "begin", "began", "show", "showed", "hear", "heard", "play", "played",
    "run", "ran", "move", "moved", "live", "lived", "believe", "believed", "bring", "brought", "happen", "happened",
    "write", "wrote", "sit", "sat", "stand", "stood", "lose", "lost", "pay", "paid", "meet", "met", "include", "included",
    "continue", "continued", "set", "set", "learn", "learned", "change", "changed", "lead", "led", "understand", "understood",
    "watch", "watched", "follow", "followed", "stop", "stopped", "create", "created", "speak", "spoke", "read", "read", "allow", "allowed",
    "add", "added", "spend", "spent", "grow", "grew", "open", "opened", "walk", "walked", "win", "won", "offer", "offered", "remember", "remembered",
    "consider", "considered", "appear", "appeared", "buy", "bought", "wait", "waited", "serve", "served", "die", "died", "send", "sent",

  ];


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final affirmations = await HiveStorage.getAllAffirmations();
    final weeklyData = await HiveStorage.getAllWeeklyData();

    setState(() {
      _affirmations = affirmations;
      _weeklyData = weeklyData;

      _wordFrequency = _calculateWordFrequency();
      _sentimentFrequency = _calculateSentimentFrequency();
      _monthlyBiggestWin = _calculateMonthlyBiggestWin();
      _currentStreak = _calculateStreak();
    });
  }

  Map<String, int> _calculateWordFrequency() {
    final Map<String, int> wordCount = {};
    for (var affirmation in _affirmations) {
      final words = affirmation.text.toLowerCase().split(RegExp(r'\s+')).where((word) => !_stopWords.contains(word));
      for (var word in words) {
        wordCount[word] = (wordCount[word] ?? 0) + 1;
      }
    }
    return wordCount;
  }

  Map<String, int> _calculateSentimentFrequency() {
    final Map<String, int> sentimentCount = {"Positive": 0, "Neutral": 0, "Negative": 0};
    for (var affirmation in _affirmations) {
      final result = Sentiment.analysis(affirmation.text, emoji: true);
      final score = result.score;
      if (score > 0) {
        sentimentCount["Positive"] = sentimentCount["Positive"]! + 1;
      } else if (score == 0) {
        sentimentCount["Neutral"] = sentimentCount["Neutral"]! + 1;
      } else {
        sentimentCount["Negative"] = sentimentCount["Negative"]! + 1;
      }
    }
    return sentimentCount;
  }

  String _calculateMonthlyBiggestWin() {
    final now = DateTime.now();
    final monthlyAffirmations = _affirmations.where((affirmation) =>
        affirmation.date.year == now.year && affirmation.date.month == now.month);

    if (monthlyAffirmations.isEmpty) {
      return "No wins recorded yet";
    }

    return monthlyAffirmations
        .reduce((a, b) => a.text.length > b.text.length ? a : b)
        .text;
  }

  int _calculateStreak() {
    if (_affirmations.isEmpty) return 0;

    _affirmations.sort((a, b) => b.date.compareTo(a.date));
    int streak = 1;
    for (int i = 1; i < _affirmations.length; i++) {
      if (_affirmations[i - 1].date.difference(_affirmations[i].date).inDays == 1) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  void _onDaySelected(DateTime date) {
    final dailyReflection = _affirmations.firstWhere(
      (affirmation) =>
          affirmation.date.year == date.year &&
          affirmation.date.month == date.month &&
          affirmation.date.day == date.day,
      orElse: () => AffirmationModel(text: "No daily reflection", date: date),
    );

    final weeklyReflection = _weeklyData.firstWhere(
      (weekly) =>
          weekly.date.year == date.year &&
          weekly.date.month == date.month &&
          (date.difference(weekly.date).inDays >= 0 &&
              date.difference(weekly.date).inDays <= 6),
      orElse: () => WeeklyDataModel(
        reflection: "No weekly reflection",
        favorite: "",
        focus: "",
        date: date,
      ),
    );

    setState(() {
      _selectedReflection = """
Daily Reflection: ${dailyReflection.text}

Weekly Reflection: ${weeklyReflection.reflection}
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress Overview"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StreakTracker(streak: _currentStreak),
              const SizedBox(height: 20),
              WordCloudWidget(wordFrequency: _wordFrequency),
              const SizedBox(height: 20),
              SentimentBar(sentimentFrequency: _sentimentFrequency),
              const SizedBox(height: 20),
              Text(
                "Monthly Biggest Win:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                _monthlyBiggestWin,
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
              const SizedBox(height: 20),
              CalendarTracker(
                progressData: _affirmations
                    .map((e) =>
                        ProgressDataModel(type: "affirmation", date: e.date, content: e.text))
                    .toList(),
                onDaySelected: _onDaySelected,
              ),
              const SizedBox(height: 20),
              Text(
                "Reflection for Selected Day:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                color: Colors.blue[50],
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _selectedReflection,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}