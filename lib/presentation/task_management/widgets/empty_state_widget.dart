import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool isAssignment;
  final VoidCallback onAddPressed;

  const EmptyStateWidget({
    super.key,
    required this.isAssignment,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: isAssignment ? 'assignment' : 'task_alt',
                  color: theme.colorScheme.primary,
                  size: 60,
                ),
              ),
            ),

            SizedBox(height: 4.h),

            // Title
            Text(
              isAssignment ? 'No Assignments Yet' : 'No Tasks Yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 2.h),

            // Description
            Text(
              isAssignment
                  ? 'Start organizing your academic life by adding your first assignment. Track deadlines and never miss a submission!'
                  : 'Get organized and boost your productivity! Add your first task to start managing your daily activities.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 4.h),

            // Action button
            ElevatedButton.icon(
              onPressed: onAddPressed,
              icon: CustomIconWidget(
                iconName: 'add',
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                isAssignment ? 'Add Assignment' : 'Add Task',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Tips
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'lightbulb',
                        color: theme.colorScheme.tertiary,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Pro Tips',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    isAssignment
                        ? '• Set due dates to track deadlines\n• Use priority levels to focus on important work\n• Add detailed descriptions for complex assignments'
                        : '• Swipe right to mark tasks complete\n• Use priority levels to stay focused\n• Set due dates for better time management',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
