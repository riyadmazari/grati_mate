import 'package:flutter/material.dart';
import '../logic/weekly_checkin_controller.dart';

class WeeklyCheckInPage extends StatelessWidget {
  final WeeklyCheckInController _controller = WeeklyCheckInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Check-In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Highlight a Favorite Entry:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _controller.favoriteEntryController,
              decoration: const InputDecoration(
                hintText: 'Select your favorite entry from the week',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Reflection:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _controller.progressReflectionController,
              decoration: const InputDecoration(
                hintText: 'What progress have you made this week?',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text(
              'Set a Weekly Focus:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _controller.weeklyFocusController,
              decoration: const InputDecoration(
                hintText: 'What is your focus for the upcoming week?',
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _controller.saveWeeklyCheckIn();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Weekly Check-In Saved!')),
                  );
                },
                child: const Text('Save Weekly Check-In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
