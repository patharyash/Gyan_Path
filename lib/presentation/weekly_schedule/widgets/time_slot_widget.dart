import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TimeSlotWidget extends StatelessWidget {
  final String time;
  final List<Map<String, dynamic>> classes;
  final Function(Map<String, dynamic>) onClassTap;
  final Function(String) onEmptySlotTap;

  const TimeSlotWidget({
    super.key,
    required this.time,
    required this.classes,
    required this.onClassTap,
    required this.onEmptySlotTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time label
          SizedBox(
            width: 15.w,
            child: Text(
              time,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 2.w),
          // Class content
          Expanded(
            child: Container(
              constraints: BoxConstraints(minHeight: 8.h),
              child: classes.isEmpty ? _buildEmptySlot(context) : _buildClassCards(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySlot(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onEmptySlotTap(time),
      child: Container(
        height: 8.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: 'add',
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildClassCards(BuildContext context) {
    return Column(
      children: classes.map((classData) => _buildClassCard(context, classData)).toList(),
    );
  }

  Widget _buildClassCard(BuildContext context, Map<String, dynamic> classData) {
    final theme = Theme.of(context);
    final subjectColor = _getSubjectColor(classData['subject'] as String? ?? '');

    return GestureDetector(
      onTap: () => onClassTap(classData),
      onLongPress: () => _showContextMenu(context, classData),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: subjectColor.withValues(alpha: 0.1),
          border: Border.all(color: subjectColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    classData['subject'] as String? ?? 'Unknown Subject',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: subjectColor,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${classData['duration'] as String? ?? '1h'}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            if (classData['location'] != null) ...[
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'location_on',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 14,
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: Text(
                      classData['location'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            if (classData['instructor'] != null) ...[
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'person',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 14,
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: Text(
                      classData['instructor'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context, Map<String, dynamic> classData) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'edit',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: const Text('Edit Class'),
              onTap: () {
                Navigator.pop(context);
                onClassTap(classData);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'content_copy',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: const Text('Duplicate'),
              onTap: () {
                Navigator.pop(context);
                // Handle duplicate
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'note_add',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: const Text('Add Note'),
              onTap: () {
                Navigator.pop(context);
                // Handle add note
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'delete',
                color: Theme.of(context).colorScheme.error,
                size: 24,
              ),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                // Handle delete
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getSubjectColor(String subject) {
    final colors = [
      AppTheme.lightTheme.colorScheme.primary,
      AppTheme.lightTheme.colorScheme.secondary,
      AppTheme.lightTheme.colorScheme.tertiary,
      const Color(0xFFE91E63),
      const Color(0xFF9C27B0),
      const Color(0xFF673AB7),
      const Color(0xFF3F51B5),
      const Color(0xFF2196F3),
      const Color(0xFF00BCD4),
      const Color(0xFF009688),
    ];

    final index = subject.hashCode.abs() % colors.length;
    return colors[index];
  }
}
