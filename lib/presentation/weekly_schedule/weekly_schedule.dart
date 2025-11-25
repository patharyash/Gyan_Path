import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_icon_widget.dart';
import './widgets/add_class_modal.dart';
import './widgets/time_slot_widget.dart';
import './widgets/week_header_widget.dart';

class WeeklySchedule extends StatefulWidget {
  const WeeklySchedule({super.key});

  @override
  State<WeeklySchedule> createState() => _WeeklyScheduleState();
}

class _WeeklyScheduleState extends State<WeeklySchedule> with TickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now(); // Changed from _currentWeek to _selectedDate
  int _currentBottomIndex = 2; // Weekly Schedule tab
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  // Mock schedule data
  final List<Map<String, dynamic>> _scheduleData = [
    {
      'id': 1,
      'subject': 'Mathematics',
      'startTime': '09:00',
      'endTime': '10:30',
      'duration': '1h 30min',
      'location': 'Room 101',
      'instructor': 'Dr. Sarah Johnson',
      'days': ['Mon', 'Wed', 'Fri'],
      'color': 0xFF2563EB,
      'notes': 'Bring calculator and textbook',
    },
    {
      'id': 2,
      'subject': 'Physics',
      'startTime': '11:00',
      'endTime': '12:30',
      'duration': '1h 30min',
      'location': 'Lab 205',
      'instructor': 'Prof. Michael Chen',
      'days': ['Tue', 'Thu'],
      'color': 0xFF7C3AED,
      'notes': 'Lab session - wear safety goggles',
    },
    {
      'id': 3,
      'subject': 'English Literature',
      'startTime': '14:00',
      'endTime': '15:00',
      'duration': '1h',
      'location': 'Room 302',
      'instructor': 'Ms. Emily Davis',
      'days': ['Mon', 'Wed', 'Fri'],
      'color': 0xFF059669,
      'notes': 'Read Chapter 5 before class',
    },
    {
      'id': 4,
      'subject': 'Chemistry',
      'startTime': '10:00',
      'endTime': '11:30',
      'duration': '1h 30min',
      'location': 'Lab 103',
      'instructor': 'Dr. Robert Wilson',
      'days': ['Tue', 'Thu'],
      'color': 0xFFD97706,
      'notes': 'Practical session on organic compounds',
    },
    {
      'id': 5,
      'subject': 'History',
      'startTime': '15:30',
      'endTime': '16:30',
      'duration': '1h',
      'location': 'Room 201',
      'instructor': 'Prof. Lisa Anderson',
      'days': ['Mon', 'Wed'],
      'color': 0xFFDC2626,
      'notes': 'Essay due next week',
    },
    {
      'id': 6,
      'subject': 'Computer Science',
      'startTime': '13:00',
      'endTime': '14:30',
      'duration': '1h 30min',
      'location': 'Computer Lab',
      'instructor': 'Mr. David Kim',
      'days': ['Tue', 'Thu', 'Fri'],
      'color': 0xFF2196F3,
      'notes': 'Bring laptop for coding practice',
    },
  ];

  final List<String> _timeSlots = [
    '07:00',
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00'
  ];

  @override
  void initState() {
    super.initState();
    _scrollToCurrentTime();
  }

  void _scrollToCurrentTime() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = DateTime.now();
      final currentHour = now.hour;
      final currentMinute = now.minute;

      // Find the closest time slot
      int targetIndex = 0;
      for (int i = 0; i < _timeSlots.length; i++) {
        final timeParts = _timeSlots[i].split(':');
        final slotHour = int.parse(timeParts[0]);
        final slotMinute = int.parse(timeParts[1]);

        if (slotHour > currentHour || (slotHour == currentHour && slotMinute >= currentMinute)) {
          targetIndex = i;
          break;
        }
      }

      // Scroll to the target position
      if (_scrollController.hasClients) {
        final targetPosition = targetIndex * 9.h; // Approximate height per slot
        _scrollController.animateTo(
          targetPosition,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            WeekHeaderWidget(
              currentWeek: _selectedDate,
              onWeekChanged: _onWeekChanged,
              onTodayTap: _onTodayTap,
              onDateSelected: _onDateSelected, // Add this callback
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final timeSlot = _timeSlots[index];
                          final classesForSlot = _getClassesForTimeSlot(timeSlot);

                          return TimeSlotWidget(
                            time: timeSlot,
                            classes: classesForSlot,
                            onClassTap: _onClassTap,
                            onEmptySlotTap: _onEmptySlotTap,
                          );
                        },
                        childCount: _timeSlots.length,
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 10.h),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddClassModal,
        child: CustomIconWidget(
          iconName: 'add',
          color: theme.colorScheme.onPrimary,
          size: 24,
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(
      //   currentIndex: _currentBottomIndex,
      //   onTap: _onBottomNavTap,
      //   variant: BottomBarVariant.floating,
      // ),
    );
  }

  List<Map<String, dynamic>> _getClassesForTimeSlot(String timeSlot) {
    final currentDayName = _getCurrentDayName();

    return _scheduleData.where((classData) {
      final days = classData['days'] as List<String>;
      final startTime = classData['startTime'] as String;

      return days.contains(currentDayName) && startTime == timeSlot;
    }).toList();
  }

  String _getCurrentDayName() {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return dayNames[_selectedDate.weekday - 1];
  }

  // New method to handle date selection
  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });

    // Haptic feedback
    HapticFeedback.lightImpact();
  }

  void _onWeekChanged(DateTime newWeek) {
    setState(() {
      _selectedDate = newWeek;
    });

    // Haptic feedback
    HapticFeedback.lightImpact();
  }

  void _onTodayTap() {
    setState(() {
      _selectedDate = DateTime.now();
    });

    _scrollToCurrentTime();
    HapticFeedback.lightImpact();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onClassTap(Map<String, dynamic> classData) {
    _showAddClassModal(existingClass: classData);
  }

  void _onEmptySlotTap(String timeSlot) {
    _showAddClassModal(initialTime: timeSlot);
  }

  void _showAddClassModal({String? initialTime, Map<String, dynamic>? existingClass}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddClassModal(
        initialTime: initialTime,
        existingClass: existingClass,
        onSave: _onClassSaved,
      ),
    );
  }

  void _onClassSaved(Map<String, dynamic> classData) {
    final existingIndex = _scheduleData.indexWhere(
      (item) => item['id'] == classData['id'],
    );

    setState(() {
      if (existingIndex != -1) {
        _scheduleData[existingIndex] = classData;
      } else {
        _scheduleData.add(classData);
      }
    });

    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existingIndex != -1 ? 'Class updated successfully' : 'Class added successfully',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentBottomIndex) return;

    setState(() {
      _currentBottomIndex = index;
    });

    // Navigate to different screens based on index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/main-dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/task-management');
        break;
      case 2:
        // Current screen - Weekly Schedule
        break;
      case 3:
        Navigator.pushNamed(context, '/notes');
        break;
      case 4:
        Navigator.pushNamed(context, '/progress-analytics');
        break;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
