import 'package:flutter/material.dart';

import '../constraint.dart';
import '../presentation/main_dashboard/main_dashboard.dart';
import '../presentation/notes/notes.dart';
import '../presentation/progress_analytics/progress_analytics.dart';
import '../presentation/task_management/task_management.dart';
import '../presentation/weekly_schedule/weekly_schedule.dart';
import 'custom_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int _currentIndex = 0;

  late final List<Widget> _screens = [
    MainDashboard(
      onNavigate: (v) {
        setState(() {
          AppConstants.navIndexDashboard = v;
        });
      },
    ),
    TaskManagement(),
    WeeklySchedule(),
    Notes(),
    ProgressAnalytics(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: IndexedStack(
          index: AppConstants.navIndexDashboard,
          children: _screens,
        ),
        bottomNavigationBar: CustomBottomBar(
          currentIndex: AppConstants.navIndexDashboard,
          onTap: (i) {
            setState(() => AppConstants.navIndexDashboard = i);
          },
        ),
      ),
    );
  }
}
