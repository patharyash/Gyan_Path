import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class TodayOverviewWidget extends StatefulWidget {
  final ValueChanged<int> onNavigate;

  const TodayOverviewWidget({super.key, required this.onNavigate});

  static final List<Map<String, dynamic>> upcomingClasses = [
    {"id": 1, "subject": "Mathematics", "time": "10:00 AM", "room": "Room 201", "type": "Lecture"},
    {"id": 2, "subject": "Physics", "time": "2:00 PM", "room": "Lab 105", "type": "Lab"},
    {
      "id": 3,
      "subject": "English Literature",
      "time": "4:00 PM",
      "room": "Room 301",
      "type": "Discussion"
    }
  ];
  static const int pendingTasksCount = 5;
  static const int highPriorityTasks = 2;
  static const double completionPercentage = 0.65;

  @override
  State<TodayOverviewWidget> createState() => _TodayOverviewWidgetState();
}

class _TodayOverviewWidgetState extends State<TodayOverviewWidget> {
  final List<Map<String, dynamic>> upcomingClasses = TodayOverviewWidget.upcomingClasses;
  final int pendingTasksCount = TodayOverviewWidget.pendingTasksCount;
  final int highPriorityTasks = TodayOverviewWidget.highPriorityTasks;
  final double completionPercentage = TodayOverviewWidget.completionPercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Overview',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
          ),
          SizedBox(height: 1.h),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      widget.onNavigate(2);
                    },
                    onLongPress: () => _showClassesDetails(context, upcomingClasses),
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'schedule',
                                color: AppTheme.lightTheme.colorScheme.primary,
                                size: 20,
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Text(
                                  'Upcoming Classes',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            '${upcomingClasses.length} classes today',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.lightTheme.colorScheme.primary,
                                ),
                          ),
                          SizedBox(height: 0.5.h),
                          if (upcomingClasses.isNotEmpty)
                            Text(
                              'Next: ${upcomingClasses[0]["subject"]} at ${upcomingClasses[0]["time"]}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onNavigate(4);
                    },
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircularPercentIndicator(
                            radius: 8.w,
                            lineWidth: 6.0,
                            percent: completionPercentage,
                            center: Text(
                              '${(completionPercentage * 100).toInt()}%',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.lightTheme.colorScheme.primary,
                                  ),
                            ),
                            progressColor: AppTheme.lightTheme.colorScheme.primary,
                            backgroundColor:
                                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Today\'s Progress',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          GestureDetector(
            onTap: () => widget.onNavigate(1),
            onLongPress: () => _showTasksDetails(context, pendingTasksCount, highPriorityTasks),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: 'assignment',
                      color: AppTheme.borderLight,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pending Tasks',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            Text(
                              '$pendingTasksCount tasks remaining',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.lightTheme.colorScheme.onSurface,
                                  ),
                            ),
                            if (highPriorityTasks > 0) ...[
                              SizedBox(width: 2.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                decoration: BoxDecoration(
                                  color: AppTheme.lightTheme.colorScheme.error,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '$highPriorityTasks high priority',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'chevron_right',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClassesDetails(BuildContext context, List<Map<String, dynamic>> classes) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Classes',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 2.h),
            ...classes.map((classItem) => Container(
                  margin: EdgeInsets.only(bottom: 1.h),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              classItem["subject"] as String,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              '${classItem["time"]} • ${classItem["room"]} • ${classItem["type"]}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showTasksDetails(BuildContext context, int pendingTasks, int highPriority) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$pendingTasks',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.lightTheme.colorScheme.primary,
                              ),
                        ),
                        Text(
                          'Total Pending',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$highPriority',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.primaryLight,
                              ),
                        ),
                        Text(
                          'High Priority',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/task-management');
                },
                child: const Text('View All Tasks'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
