import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AssignmentItemWidget extends StatelessWidget {
  final Map<String, dynamic> assignment;
  final VoidCallback onTap;
  final VoidCallback onComplete;
  final VoidCallback onDelete;
  final bool isCompleted;

  const AssignmentItemWidget({
    super.key,
    required this.assignment,
    required this.onTap,
    required this.onComplete,
    required this.onDelete,
    this.isCompleted = false,
  });

  Color _getPriorityColor() {
    final priority = assignment['priority'] as String? ?? 'medium';
    switch (priority.toLowerCase()) {
      case 'high':
        return AppTheme.lightTheme.colorScheme.error;
      case 'medium':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'low':
        return AppTheme.lightTheme.colorScheme.primary;
      default:
        return AppTheme.lightTheme.colorScheme.primary;
    }
  }

  bool _isOverdue() {
    if (assignment['dueDate'] == null) return false;
    final dueDate = assignment['dueDate'] as DateTime;
    return dueDate.isBefore(DateTime.now()) && !isCompleted;
  }

  String _formatDueDate() {
    if (assignment['dueDate'] == null) return 'No due date';
    final dueDate = assignment['dueDate'] as DateTime;
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    if (difference == 0) {
      return 'Due today';
    } else if (difference == 1) {
      return 'Due tomorrow';
    } else if (difference == -1) {
      return 'Due yesterday';
    } else if (difference > 1) {
      return 'Due in $difference days';
    } else {
      return 'Overdue by ${-difference} days';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverdue = _isOverdue();

    return Slidable(
      key: ValueKey(assignment['id']),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              HapticFeedback.lightImpact();
              onComplete();
            },
            backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
            foregroundColor: Colors.white,
            icon: Icons.check,
            label: isCompleted ? 'Undo' : 'Complete',
            borderRadius: BorderRadius.circular(12.0),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              HapticFeedback.mediumImpact();
              onDelete();
            },
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(12.0),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isCompleted
              ? theme.colorScheme.surface.withValues(alpha: 0.7)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border(
            left: BorderSide(
              color: _getPriorityColor(),
              width: 4.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          assignment['title'] as String? ?? 'Untitled Assignment',
                          style: theme.textTheme.titleMedium?.copyWith(
                            decoration: isCompleted ? TextDecoration.lineThrough : null,
                            color: isCompleted
                                ? theme.colorScheme.onSurfaceVariant
                                : isOverdue
                                    ? AppTheme.lightTheme.colorScheme.error
                                    : theme.colorScheme.onSurface,
                            fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isCompleted)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomIconWidget(
                                iconName: 'check_circle',
                                color: AppTheme.lightTheme.colorScheme.tertiary,
                                size: 16,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                'Submitted',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppTheme.lightTheme.colorScheme.tertiary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (assignment['description'] != null &&
                      (assignment['description'] as String).isNotEmpty) ...[
                    SizedBox(height: 1.h),
                    Text(
                      assignment['description'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      if (assignment['subject'] != null) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: _getPriorityColor().withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            assignment['subject'] as String,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: _getPriorityColor(),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                      ],
                      Expanded(
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'schedule',
                              color: isOverdue
                                  ? AppTheme.lightTheme.colorScheme.error
                                  : theme.colorScheme.onSurfaceVariant,
                              size: 16,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              _formatDueDate(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: isOverdue
                                    ? AppTheme.lightTheme.colorScheme.error
                                    : theme.colorScheme.onSurfaceVariant,
                                fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: _getPriorityColor().withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          (assignment['priority'] as String? ?? 'medium').toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _getPriorityColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (assignment['type'] != null) ...[
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'assignment',
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          assignment['type'] as String,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
