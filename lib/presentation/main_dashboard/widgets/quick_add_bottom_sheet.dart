import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickAddBottomSheet extends StatelessWidget {
  const QuickAddBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuickAddBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> quickAddOptions = [
      {
        "title": "Add Task",
        "subtitle": "Create a new task or assignment",
        "icon": "add_task",
        "color": AppTheme.lightTheme.colorScheme.primary,
        "backgroundColor": AppTheme.lightTheme.colorScheme.primaryContainer,
        "route": "/add-edit-task"
      },
      {
        "title": "Add Assignment",
        "subtitle": "Create homework with deadline",
        "icon": "assignment_add",
        "color": AppTheme.lightTheme.colorScheme.secondary,
        "backgroundColor": AppTheme.lightTheme.colorScheme.secondaryContainer,
        "route": "/add-edit-task"
      },
      {
        "title": "Add Note",
        "subtitle": "Save study notes and summaries",
        "icon": "note_add",
        "color": AppTheme.lightTheme.colorScheme.tertiary,
        "backgroundColor": AppTheme.lightTheme.colorScheme.tertiaryContainer,
        "route": "/notes"
      }
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 2.h),
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Quick Add',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Options
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: quickAddOptions
                    .map((option) => Container(
                          margin: EdgeInsets.only(bottom: 2.h),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, option["route"] as String);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color:
                                      (option["backgroundColor"] as Color).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        (option["backgroundColor"] as Color).withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3.w),
                                      decoration: BoxDecoration(
                                        color: option["backgroundColor"] as Color,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: CustomIconWidget(
                                        iconName: option["icon"] as String,
                                        color: option["color"] as Color,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            option["title"] as String,
                                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            option["subtitle"] as String,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: AppTheme
                                                      .lightTheme.colorScheme.onSurfaceVariant,
                                                ),
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
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
