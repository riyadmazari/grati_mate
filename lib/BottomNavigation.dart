import 'package:flutter/material.dart';
import 'features/daily_affirmation/ui/daily_affirmation_page.dart';
import 'features/weekly_checkin/ui/weekly_checkin_page.dart';
import 'features/monthly_reflection/ui/monthly_reflection_page.dart';
import 'features/progress_overview/ui/progress_overview_page.dart';
import 'features/custom_prompts/ui/custom_prompts_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // List of pages for each bottom nav item
  static const List<Widget> _pages = <Widget>[
    DailyAffirmationPage(),
    WeeklyCheckInPage(),
    MonthlyReflectionPage(),
    ProgressOverviewPage(),
    CustomPromptsPage(),
  ];

  // Updates the index when a bottom nav item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            icon: Icon(Icons.monthly_calendar),
            label: 'Monthly',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: 'Prompts',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
