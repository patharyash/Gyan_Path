import 'package:flutter/material.dart';
import 'package:studyplanner/presentation/splash/splash.dart';

import '../presentation/Login/login_screen.dart';
import '../presentation/Registration/registration_screen.dart';
import '../presentation/add_edit_task/add_edit_task.dart';
import '../presentation/main_dashboard/main_dashboard.dart';
import '../presentation/notes/notes.dart';
import '../presentation/progress_analytics/progress_analytics.dart';
import '../presentation/task_management/task_management.dart';
import '../presentation/weekly_schedule/weekly_schedule.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String progressAnalytics = '/progress-analytics';
  static const String mainDashboard = '/main-dashboard';
  static const String weeklySchedule = '/weekly-schedule';
  static const String addEditTask = '/add-edit-task';
  static const String notes = '/notes';
  static const String taskManagement = '/task-management';
  static const String login = '/login';
  static const String registration = '/registration';

  // TODO: Add your other routes here

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const Splash(),
    // initial: (context) => const MainDashboard(),
    progressAnalytics: (context) => const ProgressAnalytics(),
    mainDashboard: (context) => const MainDashboard(),
    weeklySchedule: (context) => const WeeklySchedule(),
    addEditTask: (context) => const AddEditTask(),
    notes: (context) => const Notes(),
    taskManagement: (context) => const TaskManagement(),
    login: (context) => const Login(),
    registration: (context) => const Registration(),
    // TODO: Add your other routes here
  };
}
