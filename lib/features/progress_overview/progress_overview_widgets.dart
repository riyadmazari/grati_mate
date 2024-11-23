import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../data/models/progress_data_model.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}

class CalendarTracker extends StatelessWidget {
  final List<ProgressDataModel> progressData;
  final Function(DateTime) onDaySelected;

  const CalendarTracker({
    Key? key,
    required this.progressData,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appointments = progressData
        .map((e) => Appointment(
              startTime: e.date,
              endTime: e.date.add(const Duration(hours: 1)),
              subject: e.type,
              color: e.type == "affirmation" ? Colors.blue : Colors.green,
            ))
        .toList();

    return SfCalendar(
      view: CalendarView.month,
      dataSource: AppointmentDataSource(appointments),
      todayHighlightColor: Colors.purple,
      onTap: (CalendarTapDetails details) {
        if (details.date != null) {
          onDaySelected(details.date!);
        }
      },
    );
  }
}

class StreakTracker extends StatelessWidget {
  final int streak;

  const StreakTracker({Key? key, required this.streak}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Current Streak",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          "$streak Days",
          style: const TextStyle(fontSize: 24, color: Colors.orange),
        ),
        const Icon(Icons.local_fire_department, size: 50, color: Colors.red),
      ],
    );
  }
}

class WordCloudWidget extends StatelessWidget {
  final Map<String, int> wordFrequency;
  final List<Color> colors;
  final List<int> fontSizeRange;

  const WordCloudWidget({
    Key? key,
    required this.wordFrequency,
    this.colors = const [Colors.blue, Colors.green, Colors.purple],
    this.fontSizeRange = const [12, 40],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordList = wordFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)); // Sort by frequency

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: wordList.map((entry) {
        final word = entry.key;
        final frequency = entry.value;
        return Text(
          word,
          style: TextStyle(
            fontSize: _mapFrequencyToFontSize(frequency),
            color: colors[wordList.indexOf(entry) % colors.length],
          ),
        );
      }).toList(),
    );
  }

  double _mapFrequencyToFontSize(int frequency) {
    final minFrequency = wordFrequency.values.isEmpty
        ? 1
        : wordFrequency.values.reduce((a, b) => a < b ? a : b);
    final maxFrequency = wordFrequency.values.isEmpty
        ? 1
        : wordFrequency.values.reduce((a, b) => a > b ? a : b);

    if (minFrequency == maxFrequency) {
      return fontSizeRange[0].toDouble();
    }

    return fontSizeRange[0] +
        (frequency - minFrequency) *
            (fontSizeRange[1] - fontSizeRange[0]) /
            (maxFrequency - minFrequency);
  }
}

class SentimentBar extends StatelessWidget {
  final Map<String, int> sentimentFrequency;

  const SentimentBar({Key? key, required this.sentimentFrequency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: sentimentFrequency.entries.map((entry) {
        return Column(
          children: [
            Text(
              entry.key,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "${entry.value}",
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        );
      }).toList(),
    );
  }
}
