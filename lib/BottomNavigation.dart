import 'package:flutter/material.dart';
import 'features/weekly_checkin/ui/weekly_checkin_page.dart';
import 'features/monthly_reflection/ui/monthly_reflection_page.dart';
import 'features/dummy/dummy_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // List of pages for each bottom navigation tab
  static final List<Widget> _pages = <Widget>[
    DummyPage(title: 'Daily Affirmation', color: Colors.orange),
    WeeklyCheckInPage(),
    MonthlyReflectionPage(),
    DummyPage(title: 'Progress Overview', color: Colors.blue),
    DummyPage(title: 'Custom Prompts', color: Colors.green),
  ];

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
            icon: Icon(Icons.calendar_month),
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
