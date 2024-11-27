import 'package:flutter/material.dart';
import '../features/daily_affirmation/daily_affirmation_page.dart';
import '../features/weekly_checkin/weekly_checkin_page.dart';
import '../features/monthly_reflection/monthly_reflection_page.dart';
import '../features/progress_overview/progress_overview_page.dart';
import '../features/inspiration_wall/inspiration_wall_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    DailyAffirmationPage(),
    WeeklyCheckInPage(),
    MonthlyReflectionPage(),
    ProgressOverviewPage(),
    InspirationWallPage(),
  ];

  void _onItemTapped(int index) {
    if (index < _pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'Daily',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Weekly',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Monthly',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Inspiration',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
