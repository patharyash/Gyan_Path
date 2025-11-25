import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentActivityWidget extends StatefulWidget {
  const RecentActivityWidget({super.key});

  @override
  State<RecentActivityWidget> createState() => _RecentActivityWidgetState();
}

class _RecentActivityWidgetState extends State<RecentActivityWidget> {
  List<Map<String, dynamic>> recentActivities = [
    // Your original 5
    {
      "id": 1,
      "type": "completed_task",
      "title": "Complete Math Assignment Chapter 5",
      "subtitle": "Mathematics • Due today",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
      "isCompleted": true,
      "priority": "high",
      "subject": "Mathematics"
    },
    {
      "id": 2,
      "type": "upcoming_deadline",
      "title": "Physics Lab Report",
      "subtitle": "Physics • Due tomorrow",
      "timestamp": DateTime.now().add(const Duration(days: 1)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Physics"
    },
    {
      "id": 3,
      "type": "completed_task",
      "title": "Read Chapter 3 - Romeo and Juliet",
      "subtitle": "English Literature • Due yesterday",
      "timestamp": DateTime.now().subtract(const Duration(hours: 5)),
      "isCompleted": true,
      "priority": "low",
      "subject": "English Literature"
    },
    {
      "id": 4,
      "type": "upcoming_deadline",
      "title": "Chemistry Quiz Preparation",
      "subtitle": "Chemistry • Due in 3 days",
      "timestamp": DateTime.now().add(const Duration(days: 3)),
      "isCompleted": false,
      "priority": "high",
      "subject": "Chemistry"
    },
    {
      "id": 5,
      "type": "upcoming_deadline",
      "title": "History Essay - World War II",
      "subtitle": "History • Due next week",
      "timestamp": DateTime.now().add(const Duration(days: 7)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "History"
    },

    // 55 more items
    {
      "id": 6,
      "type": "completed_task",
      "title": "Solve Algebra Worksheet",
      "subtitle": "Mathematics • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 1)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Mathematics"
    },
    {
      "id": 7,
      "type": "upcoming_deadline",
      "title": "Biology Diagram Practice",
      "subtitle": "Biology • Due in 2 days",
      "timestamp": DateTime.now().add(const Duration(days: 2)),
      "isCompleted": false,
      "priority": "low",
      "subject": "Biology"
    },
    {
      "id": 8,
      "type": "completed_task",
      "title": "Write English Poem",
      "subtitle": "English • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 8)),
      "isCompleted": true,
      "priority": "low",
      "subject": "English"
    },
    {
      "id": 9,
      "type": "upcoming_deadline",
      "title": "Geography Map Labelling",
      "subtitle": "Geography • Due tomorrow",
      "timestamp": DateTime.now().add(const Duration(days: 1)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Geography"
    },
    {
      "id": 10,
      "type": "completed_task",
      "title": "Physics Numerical Practice",
      "subtitle": "Physics • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 2)),
      "isCompleted": true,
      "priority": "high",
      "subject": "Physics"
    },
    {
      "id": 11,
      "type": "upcoming_deadline",
      "title": "Chemistry Organic Reactions Notes",
      "subtitle": "Chemistry • Due in 4 days",
      "timestamp": DateTime.now().add(const Duration(days: 4)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Chemistry"
    },
    {
      "id": 12,
      "type": "completed_task",
      "title": "History Chapter Summary",
      "subtitle": "History • Completed yesterday",
      "timestamp": DateTime.now().subtract(const Duration(days: 1)),
      "isCompleted": true,
      "priority": "low",
      "subject": "History"
    },
    {
      "id": 13,
      "type": "upcoming_deadline",
      "title": "Computer Science Coding Assignment",
      "subtitle": "Computer Science • Due next week",
      "timestamp": DateTime.now().add(const Duration(days: 7)),
      "isCompleted": false,
      "priority": "high",
      "subject": "Computer Science"
    },
    {
      "id": 14,
      "type": "completed_task",
      "title": "Music Practice Session (Piano)",
      "subtitle": "Music • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 3)),
      "isCompleted": true,
      "priority": "low",
      "subject": "Music"
    },
    {
      "id": 15,
      "type": "upcoming_deadline",
      "title": "Art Project – Watercolor Landscape",
      "subtitle": "Art • Due in 6 days",
      "timestamp": DateTime.now().add(const Duration(days: 6)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Art"
    },
    {
      "id": 16,
      "type": "completed_task",
      "title": "PE Fitness Log Update",
      "subtitle": "PE • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 3)),
      "isCompleted": true,
      "priority": "low",
      "subject": "Physical Education"
    },
    {
      "id": 17,
      "type": "upcoming_deadline",
      "title": "Mathematics Trigonometry Practice",
      "subtitle": "Mathematics • Due tomorrow",
      "timestamp": DateTime.now().add(const Duration(days: 1)),
      "isCompleted": false,
      "priority": "high",
      "subject": "Mathematics"
    },
    {
      "id": 18,
      "type": "completed_task",
      "title": "Science Lab Safety Notes",
      "subtitle": "Science • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 10)),
      "isCompleted": true,
      "priority": "low",
      "subject": "Science"
    },
    {
      "id": 19,
      "type": "upcoming_deadline",
      "title": "English Grammar Worksheet",
      "subtitle": "English • Due in 2 days",
      "timestamp": DateTime.now().add(const Duration(days: 2)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "English"
    },
    {
      "id": 20,
      "type": "completed_task",
      "title": "History Timeline Chart",
      "subtitle": "History • Completed today",
      "timestamp": DateTime.now().subtract(const Duration(hours: 1)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "History"
    },
    {
      "id": 21,
      "type": "upcoming_deadline",
      "title": "Computer Science Debugging Practice",
      "subtitle": "Computer Science • Due tomorrow",
      "timestamp": DateTime.now().add(const Duration(days: 1)),
      "isCompleted": false,
      "priority": "high",
      "subject": "Computer Science"
    },
    {
      "id": 22,
      "type": "completed_task",
      "title": "Biology Plant Cell Diagram",
      "subtitle": "Biology • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 2)),
      "isCompleted": true,
      "priority": "low",
      "subject": "Biology"
    },
    {
      "id": 23,
      "type": "upcoming_deadline",
      "title": "Science Chapter 4 Revision",
      "subtitle": "Science • Due next week",
      "timestamp": DateTime.now().add(const Duration(days: 6)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Science"
    },
    {
      "id": 24,
      "type": "completed_task",
      "title": "Draw Geography Physical Map",
      "subtitle": "Geography • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 4)),
      "isCompleted": true,
      "priority": "low",
      "subject": "Geography"
    },
    {
      "id": 25,
      "type": "upcoming_deadline",
      "title": "Physics Motion Experiment",
      "subtitle": "Physics • Due in 5 days",
      "timestamp": DateTime.now().add(const Duration(days: 5)),
      "isCompleted": false,
      "priority": "high",
      "subject": "Physics"
    },
    {
      "id": 26,
      "type": "completed_task",
      "title": "Chemistry Balancing Equations",
      "subtitle": "Chemistry • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 6)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Chemistry"
    },
    {
      "id": 27,
      "type": "upcoming_deadline",
      "title": "English Novel Reading – Chapter 7",
      "subtitle": "English • Due tomorrow",
      "timestamp": DateTime.now().add(const Duration(days: 1)),
      "isCompleted": false,
      "priority": "low",
      "subject": "English"
    },
    {
      "id": 28,
      "type": "completed_task",
      "title": "Computer Science – Write Pseudocode",
      "subtitle": "Computer Science • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 4)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Computer Science"
    },
    {
      "id": 29,
      "type": "upcoming_deadline",
      "title": "Chemistry Lab Manual Activity",
      "subtitle": "Chemistry • Due in 3 days",
      "timestamp": DateTime.now().add(const Duration(days: 3)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Chemistry"
    },
    {
      "id": 30,
      "type": "completed_task",
      "title": "Mathematics Calculus Worksheet",
      "subtitle": "Mathematics • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 3)),
      "isCompleted": true,
      "priority": "high",
      "subject": "Mathematics"
    },
    {
      "id": 31,
      "type": "upcoming_deadline",
      "title": "Science Practical Submission",
      "subtitle": "Science • Due in 2 days",
      "timestamp": DateTime.now().add(const Duration(days: 2)),
      "isCompleted": false,
      "priority": "high",
      "subject": "Science"
    },
    {
      "id": 32,
      "type": "completed_task",
      "title": "Solve English Grammar Exercises",
      "subtitle": "English • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 7)),
      "isCompleted": true,
      "priority": "low",
      "subject": "English"
    },
    {
      "id": 33,
      "type": "upcoming_deadline",
      "title": "Read History Chapter 6",
      "subtitle": "History • Due tomorrow",
      "timestamp": DateTime.now().add(const Duration(days: 1)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "History"
    },
    {
      "id": 34,
      "type": "completed_task",
      "title": "Write Physics Formula Chart",
      "subtitle": "Physics • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 2)),
      "isCompleted": true,
      "priority": "low",
      "subject": "Physics"
    },
    {
      "id": 35,
      "type": "upcoming_deadline",
      "title": "Biology Notes – Photosynthesis",
      "subtitle": "Biology • Due in 3 days",
      "timestamp": DateTime.now().add(const Duration(days: 3)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Biology"
    },
    {
      "id": 36,
      "type": "completed_task",
      "title": "Solve Math Trigonometry Set 2",
      "subtitle": "Mathematics • Completed today",
      "timestamp": DateTime.now().subtract(const Duration(hours: 1)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Mathematics"
    },
    {
      "id": 37,
      "type": "upcoming_deadline",
      "title": "Computer Science – Loops Practice",
      "subtitle": "Computer Science • Due soon",
      "timestamp": DateTime.now().add(const Duration(days: 2)),
      "isCompleted": false,
      "priority": "low",
      "subject": "Computer Science"
    },
    {
      "id": 38,
      "type": "completed_task",
      "title": "Prepare Geography Notes",
      "subtitle": "Geography • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 1)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Geography"
    },
    {
      "id": 39,
      "type": "upcoming_deadline",
      "title": "Science Lab Equipment Drawing",
      "subtitle": "Science • Due in 5 days",
      "timestamp": DateTime.now().add(const Duration(days: 5)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Science"
    },
    {
      "id": 40,
      "type": "completed_task",
      "title": "English Poem Explanation",
      "subtitle": "English • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 5)),
      "isCompleted": true,
      "priority": "low",
      "subject": "English"
    },
    {
      "id": 41,
      "type": "upcoming_deadline",
      "title": "Math Algebra Mock Test",
      "subtitle": "Mathematics • Due next week",
      "timestamp": DateTime.now().add(const Duration(days: 7)),
      "isCompleted": false,
      "priority": "high",
      "subject": "Mathematics"
    },
    {
      "id": 42,
      "type": "completed_task",
      "title": "Solve Chemistry Ionic Equations",
      "subtitle": "Chemistry • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 6)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Chemistry"
    },
    {
      "id": 43,
      "type": "upcoming_deadline",
      "title": "Physics Worksheet – Electricity",
      "subtitle": "Physics • Due in 4 days",
      "timestamp": DateTime.now().add(const Duration(days: 4)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Physics"
    },
    {
      "id": 44,
      "type": "completed_task",
      "title": "History Chapter 9 Notes",
      "subtitle": "History • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
      "isCompleted": true,
      "priority": "low",
      "subject": "History"
    },
    {
      "id": 45,
      "type": "upcoming_deadline",
      "title": "Geography Weather Diagram",
      "subtitle": "Geography • Due in 3 days",
      "timestamp": DateTime.now().add(const Duration(days: 3)),
      "isCompleted": false,
      "priority": "low",
      "subject": "Geography"
    },
    {
      "id": 46,
      "type": "completed_task",
      "title": "Complete English Comprehension",
      "subtitle": "English • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "English"
    },
    {
      "id": 47,
      "type": "upcoming_deadline",
      "title": "Mathematics Geometry Drawing",
      "subtitle": "Mathematics • Due in 2 days",
      "timestamp": DateTime.now().add(const Duration(days: 2)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Mathematics"
    },
    {
      "id": 48,
      "type": "completed_task",
      "title": "Computer Science Functions Worksheet",
      "subtitle": "Computer Science • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 3)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Computer Science"
    },
    {
      "id": 49,
      "type": "upcoming_deadline",
      "title": "Biology – Animal Cell Diagram",
      "subtitle": "Biology • Due next week",
      "timestamp": DateTime.now().add(const Duration(days: 6)),
      "isCompleted": false,
      "priority": "low",
      "subject": "Biology"
    },
    {
      "id": 50,
      "type": "completed_task",
      "title": "Physics – Solve Kinematics Problems",
      "subtitle": "Physics • Completed",
      "timestamp": DateTime.now().subtract(const Duration(days: 1)),
      "isCompleted": true,
      "priority": "high",
      "subject": "Physics"
    },
    {
      "id": 51,
      "type": "upcoming_deadline",
      "title": "Chemistry Electrolysis Worksheet",
      "subtitle": "Chemistry • Due tomorrow",
      "timestamp": DateTime.now().add(const Duration(days: 1)),
      "isCompleted": false,
      "priority": "high",
      "subject": "Chemistry"
    },
    {
      "id": 52,
      "type": "completed_task",
      "title": "English Vocabulary Test Revision",
      "subtitle": "English • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 9)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "English"
    },
    {
      "id": 53,
      "type": "upcoming_deadline",
      "title": "History – Cold War Notes",
      "subtitle": "History • Due in 4 days",
      "timestamp": DateTime.now().add(const Duration(days: 4)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "History"
    },
    {
      "id": 54,
      "type": "completed_task",
      "title": "Mathematics Practice Test (Algebra)",
      "subtitle": "Mathematics • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 12)),
      "isCompleted": true,
      "priority": "high",
      "subject": "Mathematics"
    },
    {
      "id": 55,
      "type": "upcoming_deadline",
      "title": "Geography Climate Assignment",
      "subtitle": "Geography • Due soon",
      "timestamp": DateTime.now().add(const Duration(days: 2)),
      "isCompleted": false,
      "priority": "low",
      "subject": "Geography"
    },
    {
      "id": 56,
      "type": "completed_task",
      "title": "Science – Light Chapter Questions",
      "subtitle": "Science • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Science"
    },
    {
      "id": 57,
      "type": "upcoming_deadline",
      "title": "Biology – Reproduction Notes",
      "subtitle": "Biology • Due in 5 days",
      "timestamp": DateTime.now().add(const Duration(days: 5)),
      "isCompleted": false,
      "priority": "medium",
      "subject": "Biology"
    },
    {
      "id": 58,
      "type": "completed_task",
      "title": "Computer Science Algorithm Analysis",
      "subtitle": "Computer Science • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 1)),
      "isCompleted": true,
      "priority": "high",
      "subject": "Computer Science"
    },
    {
      "id": 59,
      "type": "upcoming_deadline",
      "title": "Art Sketch Practice – Portrait",
      "subtitle": "Art • Due in 3 days",
      "timestamp": DateTime.now().add(const Duration(days: 3)),
      "isCompleted": false,
      "priority": "low",
      "subject": "Art"
    },
    {
      "id": 60,
      "type": "completed_task",
      "title": "Music Theory Lesson Practice",
      "subtitle": "Music • Completed",
      "timestamp": DateTime.now().subtract(const Duration(hours: 4)),
      "isCompleted": true,
      "priority": "medium",
      "subject": "Music"
    },
  ];

  String _getRelativeTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = timestamp.difference(now);

    if (difference.isNegative) {
      final absDifference = difference.abs();
      if (absDifference.inDays > 0) {
        return '${absDifference.inDays} day${absDifference.inDays > 1 ? 's' : ''} ago';
      } else if (absDifference.inHours > 0) {
        return '${absDifference.inHours} hour${absDifference.inHours > 1 ? 's' : ''} ago';
      } else {
        return '${absDifference.inMinutes} minute${absDifference.inMinutes > 1 ? 's' : ''} ago';
      }
    } else {
      if (difference.inDays > 0) {
        return 'in ${difference.inDays} day${difference.inDays > 1 ? 's' : ''}';
      } else if (difference.inHours > 0) {
        return 'in ${difference.inHours} hour${difference.inHours > 1 ? 's' : ''}';
      } else {
        return 'in ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
      }
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppTheme.lightTheme.colorScheme.error;
      case 'medium':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'low':
        return AppTheme.lightTheme.colorScheme.tertiary;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  IconData _getActivityIcon(String type, bool isCompleted) {
    if (isCompleted) {
      return Icons.check_circle;
    }

    switch (type) {
      case 'completed_task':
        return Icons.check_circle;
      case 'upcoming_deadline':
        return Icons.schedule;
      default:
        return Icons.assignment;
    }
  }

  void _toggleTaskCompletion(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      recentActivities[index]['isCompleted'] = !recentActivities[index]['isCompleted'];
      if (recentActivities[index]['isCompleted']) {
        recentActivities[index]['type'] = 'completed_task';
        recentActivities[index]['timestamp'] = DateTime.now();
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          recentActivities[index]['isCompleted']
              ? 'Task marked as completed!'
              : 'Task marked as pending',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
              ),
              // TextButton(
              //   onPressed: () => Navigator.pushNamed(context, '/task-management'),
              //   child: Text(
              //     'View All',
              //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //           color: AppTheme.lightTheme.colorScheme.primary,
              //           fontWeight: FontWeight.w500,
              //         ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 1.h),
          recentActivities.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recentActivities.length > 5 ? 7 : recentActivities.length,
                  separatorBuilder: (context, index) => SizedBox(height: 1.h),
                  itemBuilder: (context, index) {
                    final activity = recentActivities[index];
                    return Dismissible(
                      key: Key('activity_${activity["id"]}'),
                      direction: activity["isCompleted"] as bool
                          ? DismissDirection.none
                          : DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 4.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomIconWidget(
                          iconName: 'check',
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          _toggleTaskCompletion(index);
                          return false; // Don't actually dismiss
                        }
                        return false;
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
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: (activity["isCompleted"] as bool)
                                    ? AppTheme.lightTheme.colorScheme.tertiaryContainer
                                    : _getPriorityColor(activity["priority"] as String)
                                        .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomIconWidget(
                                iconName:
                                    (activity["isCompleted"] as bool) ? 'check_circle' : 'schedule',
                                color: (activity["isCompleted"] as bool)
                                    ? AppTheme.lightTheme.colorScheme.tertiary
                                    : _getPriorityColor(activity["priority"] as String),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity["title"] as String,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          decoration: (activity["isCompleted"] as bool)
                                              ? TextDecoration.lineThrough
                                              : null,
                                          color: (activity["isCompleted"] as bool)
                                              ? AppTheme.lightTheme.colorScheme.onSurfaceVariant
                                              : AppTheme.lightTheme.colorScheme.onSurface,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          activity["subtitle"] as String,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: AppTheme
                                                    .lightTheme.colorScheme.onSurfaceVariant,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor(activity["priority"] as String)
                                              .withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          (activity["priority"] as String).toUpperCase(),
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                color: _getPriorityColor(
                                                    activity["priority"] as String),
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    _getRelativeTime(activity["timestamp"] as DateTime),
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                                              .withValues(alpha: 0.7),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            if (!(activity["isCompleted"] as bool))
                              GestureDetector(
                                onTap: () => _toggleTaskCompletion(index),
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  child: CustomIconWidget(
                                    iconName: 'radio_button_unchecked',
                                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                                    size: 20,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.w),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: 'assignment_outlined',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            size: 48,
          ),
          SizedBox(height: 2.h),
          Text(
            'No Recent Activity',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Start by adding your first task or assignment',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/add-edit-task'),
            child: const Text('Add Your First Task'),
          ),
        ],
      ),
    );
  }
}
