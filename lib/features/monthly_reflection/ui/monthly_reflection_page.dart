import 'package:flutter/material.dart';
import '../logic/monthly_reflection_controller.dart';

class MonthlyReflectionPage extends StatelessWidget {
  final MonthlyReflectionController _controller = MonthlyReflectionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Reflection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Biggest Wins:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _controller.winsController,
                decoration: const InputDecoration(
                  hintText: 'What were your biggest wins this month?',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              const Text(
                'Areas to Improve:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _controller.improvementsController,
                decoration: const InputDecoration(
                  hintText: 'What areas can you improve on?',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              const Text(
                'Inspirational Quotes:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _controller.quotesController,
                decoration: const InputDecoration(
                  hintText: 'Add any quotes or motivational thoughts.',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              const Text(
                'Lessons Learned:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _controller.lessonsController,
                decoration: const InputDecoration(
                  hintText: 'Write any key lessons from this month.',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _controller.saveMonthlyReflection();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Monthly Reflection Saved!')),
                    );
                  },
                  child: const Text('Save Monthly Reflection'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
