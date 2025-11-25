import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> quickActions = [
      {
        "title": "Add Task",
        "subtitle": "Create new task or assignment",
        "icon": "add_task",
        "color": AppTheme.lightTheme.colorScheme.primary,
        "backgroundColor": AppTheme.lightTheme.colorScheme.primaryContainer,
        "route": "/add-edit-task"
      },
      {
        "title": "View Today's Schedule",
        "subtitle": "Check your class timetable",
        "icon": "today",
        "color": AppTheme.lightTheme.colorScheme.secondary,
        "backgroundColor": AppTheme.lightTheme.colorScheme.secondaryContainer,
        "route": "/weekly-schedule"
      },
      {
        "title": "Add Note",
        "subtitle": "Save important study notes",
        "icon": "note_add",
        "color": AppTheme.lightTheme.colorScheme.tertiary,
        "backgroundColor": AppTheme.lightTheme.colorScheme.tertiaryContainer,
        "route": "/notes"
      }
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
          ),
          SizedBox(height: 2.h),
          Column(
            children: quickActions
                .map((action) => Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(context, action["route"] as String),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3.w),
                                  decoration: BoxDecoration(
                                    color: action["backgroundColor"] as Color,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: CustomIconWidget(
                                    iconName: action["icon"] as String,
                                    color: action["color"] as Color,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        action["title"] as String,
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        action["subtitle"] as String,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color:
                                                  AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
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
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
