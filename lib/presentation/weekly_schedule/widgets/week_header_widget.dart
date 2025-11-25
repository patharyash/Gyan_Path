import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WeekHeaderWidget extends StatelessWidget {
  final DateTime currentWeek;
  final Function(DateTime) onWeekChanged;
  final VoidCallback onTodayTap;
  final Function(DateTime)? onDateSelected; // Add this parameter

  const WeekHeaderWidget({
    Key? key,
    required this.currentWeek,
    required this.onWeekChanged,
    required this.onTodayTap,
    this.onDateSelected, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weekDays = _getWeekDays(currentWeek);
    final today = DateTime.now();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Month and navigation row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  final previousWeek = currentWeek.subtract(const Duration(days: 7));
                  onWeekChanged(previousWeek);
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(currentWeek),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  final nextWeek = currentWeek.add(const Duration(days: 7));
                  onWeekChanged(nextWeek);
                },
              ),
            ],
          ),
          SizedBox(height: 1.h),
          // Week days row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: weekDays.map((date) {
              final isToday =
                  date.year == today.year && date.month == today.month && date.day == today.day;
              final isSelected = date.year == currentWeek.year &&
                  date.month == currentWeek.month &&
                  date.day == currentWeek.day;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Call onDateSelected when a date is tapped
                    if (onDateSelected != null) {
                      onDateSelected!(date);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : isToday
                              ? theme.colorScheme.primary.withOpacity(0.1)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('E').format(date).substring(0, 3),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.textTheme.bodySmall?.color,
                            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          date.day.toString(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.textTheme.titleMedium?.color,
                            fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 1.h),
          OutlinedButton(
            onPressed: onTodayTap,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            ),
            child: const Text('Today'),
          ),
        ],
      ),
    );
  }

  List<DateTime> _getWeekDays(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }
}
