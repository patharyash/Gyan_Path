import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_icon_widget.dart';

// Assuming these are your imports

class DetailedProgressModal extends StatelessWidget {
  final Map<String, dynamic> data;
  final String type; // 'chart' or 'subject'

  const DetailedProgressModal({
    super.key,
    required this.data,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      // Ensure specific height for the bottom sheet
      height: 70.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(theme, context),
          // Expanded ensures the list takes up the remaining space inside the 70.h container
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
              child: type == 'chart' ? _buildChartDetails(theme) : _buildSubjectDetails(theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3), // Lighter background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 12.w,
              height: 0.6.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  type == 'chart' ? '${data["label"]} Details' : '${data["name"]} Progress',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: CustomIconWidget(
                  iconName: 'close',
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartDetails(ThemeData theme) {
    // FIX: Safely convert List<dynamic> to List<Map>
    final rawList = data["tasks"] as List?;
    final List<Map<String, dynamic>> tasks = rawList?.map((item) {
          if (item is Map<String, dynamic>) return item;
          if (item is Map) return Map<String, dynamic>.from(item);
          // Fallback for your "ashish", "Yash" string data so it doesn't crash
          return {
            "title": item.toString(),
            "completed": false,
            "priority": "Low",
            "dueDate": "N/A"
          };
        }).toList() ??
        [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        _buildSummaryCard(theme),
        SizedBox(height: 3.h),
        Text(
          'Task Breakdown',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 2.h),
        tasks.isEmpty
            ? _buildEmptyTasks(theme)
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return _buildTaskItem(theme, task);
                },
              ),
        // Add safe area spacing at bottom
        SizedBox(height: 4.h),
      ],
    );
  }

  Widget _buildSubjectDetails(ThemeData theme) {
    // FIX: Safely convert List<dynamic>
    final rawList = data["taskList"] as List?;
    final List<Map<String, dynamic>> tasks = rawList?.map((item) {
          if (item is Map<String, dynamic>) return item;
          if (item is Map) return Map<String, dynamic>.from(item);
          return {"title": "Unknown Task", "completed": false};
        }).toList() ??
        [];

    final colorVal = data["color"];
    final color = (colorVal is int) ? Color(colorVal) : theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        _buildSubjectSummaryCard(theme, color),
        SizedBox(height: 3.h),
        Text(
          'Recent Tasks',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 2.h),
        tasks.isEmpty
            ? _buildEmptyTasks(theme)
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return _buildTaskItem(theme, task);
                },
              ),
        SizedBox(height: 4.h),
      ],
    );
  }

  Widget _buildSummaryCard(ThemeData theme) {
    // Safety checks for values
    final value = data["value"]?.toStringAsFixed(0) ?? "0";
    final completed = data["completed"]?.toString() ?? "0";
    final pending = data["pending"]?.toString() ?? "0";
    final total = data["total"]?.toString() ?? "0";

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            '$value%',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Completion Rate',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                  theme, 'Completed', completed, 'check_circle', theme.colorScheme.tertiary),
              Container(
                  width: 1,
                  height: 4.h,
                  color: theme.colorScheme.onPrimaryContainer.withOpacity(0.2)),
              _buildStatItem(theme, 'Pending', pending, 'schedule', theme.colorScheme.secondary),
              Container(
                  width: 1,
                  height: 4.h,
                  color: theme.colorScheme.onPrimaryContainer.withOpacity(0.2)),
              _buildStatItem(
                  theme, 'Total', total, 'assignment', theme.colorScheme.onPrimaryContainer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectSummaryCard(ThemeData theme, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            '${data["progress"]}%',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Subject Progress',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(theme, 'Completed', '${data["completed"]}', 'check_circle',
                  theme.colorScheme.tertiary),
              _buildStatItem(theme, 'Total', '${data["total"]}', 'assignment', color),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(ThemeData theme, String label, String value, String iconName, Color color) {
    return Column(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: color,
          size: 24,
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(ThemeData theme, Map<String, dynamic> task) {
    final isCompleted = task["completed"] as bool? ?? false;

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: isCompleted ? 'check_circle' : 'radio_button_unchecked',
            color: isCompleted ? theme.colorScheme.tertiary : theme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task["title"]?.toString() ?? 'Untitled Task',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withOpacity(isCompleted ? 0.7 : 1.0),
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (task["dueDate"] != null && task["dueDate"] != "N/A") ...[
                  SizedBox(height: 0.5.h),
                  Text(
                    'Due: ${task["dueDate"]}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (task["priority"] != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: _getPriorityColor(task["priority"]?.toString() ?? "Low", theme),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                task["priority"]?.toString() ?? "Low",
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 8.sp),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyTasks(ThemeData theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Column(
          children: [
            Opacity(
              opacity: 0.5,
              child: CustomIconWidget(
                iconName: 'assignment',
                color: theme.colorScheme.onSurfaceVariant,
                size: 48,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'No Tasks Available',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Tasks will appear here once added',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority, ThemeData theme) {
    switch (priority.toLowerCase()) {
      case 'high':
        return theme.colorScheme.error;
      case 'medium':
        return Colors.orange;
      case 'low':
        return theme.colorScheme.tertiary;
      default:
        return theme.colorScheme.primary;
    }
  }
}
