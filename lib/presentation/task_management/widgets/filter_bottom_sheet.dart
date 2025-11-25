import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

enum SortOption {
  dueDate,
  priority,
  subject,
  completion,
  alphabetical,
}

enum FilterOption {
  all,
  completed,
  pending,
  overdue,
}

class FilterBottomSheet extends StatefulWidget {
  final SortOption currentSort;
  final FilterOption currentFilter;
  final Function(SortOption, FilterOption) onApplyFilter;

  const FilterBottomSheet({
    super.key,
    required this.currentSort,
    required this.currentFilter,
    required this.onApplyFilter,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late SortOption _selectedSort;
  late FilterOption _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.currentSort;
    _selectedFilter = widget.currentFilter;
  }

  String _getSortTitle(SortOption option) {
    switch (option) {
      case SortOption.dueDate:
        return 'Due Date';
      case SortOption.priority:
        return 'Priority';
      case SortOption.subject:
        return 'Subject';
      case SortOption.completion:
        return 'Completion Status';
      case SortOption.alphabetical:
        return 'Alphabetical';
    }
  }

  String _getSortDescription(SortOption option) {
    switch (option) {
      case SortOption.dueDate:
        return 'Sort by due date (earliest first)';
      case SortOption.priority:
        return 'Sort by priority (high to low)';
      case SortOption.subject:
        return 'Sort by subject name';
      case SortOption.completion:
        return 'Sort by completion status';
      case SortOption.alphabetical:
        return 'Sort alphabetically by title';
    }
  }

  IconData _getSortIcon(SortOption option) {
    switch (option) {
      case SortOption.dueDate:
        return Icons.schedule;
      case SortOption.priority:
        return Icons.priority_high;
      case SortOption.subject:
        return Icons.school;
      case SortOption.completion:
        return Icons.check_circle;
      case SortOption.alphabetical:
        return Icons.sort_by_alpha;
    }
  }

  String _getFilterTitle(FilterOption option) {
    switch (option) {
      case FilterOption.all:
        return 'All Items';
      case FilterOption.completed:
        return 'Completed';
      case FilterOption.pending:
        return 'Pending';
      case FilterOption.overdue:
        return 'Overdue';
    }
  }

  String _getFilterDescription(FilterOption option) {
    switch (option) {
      case FilterOption.all:
        return 'Show all tasks and assignments';
      case FilterOption.completed:
        return 'Show only completed items';
      case FilterOption.pending:
        return 'Show only pending items';
      case FilterOption.overdue:
        return 'Show only overdue items';
    }
  }

  IconData _getFilterIcon(FilterOption option) {
    switch (option) {
      case FilterOption.all:
        return Icons.list;
      case FilterOption.completed:
        return Icons.check_circle;
      case FilterOption.pending:
        return Icons.pending;
      case FilterOption.overdue:
        return Icons.warning;
    }
  }

  Color _getFilterColor(FilterOption option) {
    switch (option) {
      case FilterOption.all:
        return AppTheme.lightTheme.colorScheme.primary;
      case FilterOption.completed:
        return AppTheme.lightTheme.colorScheme.tertiary;
      case FilterOption.pending:
        return AppTheme.lightTheme.colorScheme.secondary;
      case FilterOption.overdue:
        return AppTheme.lightTheme.colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 75.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Text(
                  'Sort & Filter',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedSort = SortOption.dueDate;
                      _selectedFilter = FilterOption.all;
                    });
                  },
                  child: Text(
                    'Reset',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
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
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sort section
                  Text(
                    'Sort By',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  ...SortOption.values.map((option) {
                    final isSelected = _selectedSort == option;
                    return Container(
                      margin: EdgeInsets.only(bottom: 1.h),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedSort = option;
                          });
                        },
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.outline.withValues(alpha: 0.3),
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? theme.colorScheme.primary.withValues(alpha: 0.2)
                                      : theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: CustomIconWidget(
                                  iconName: _getSortIcon(option).codePoint.toString(),
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getSortTitle(option),
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        color: isSelected
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.onSurface,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _getSortDescription(option),
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                CustomIconWidget(
                                  iconName: 'check_circle',
                                  color: theme.colorScheme.primary,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  SizedBox(height: 4.h),

                  // Filter section
                  Text(
                    'Filter By',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  ...FilterOption.values.map((option) {
                    final isSelected = _selectedFilter == option;
                    final filterColor = _getFilterColor(option);

                    return Container(
                      margin: EdgeInsets.only(bottom: 1.h),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedFilter = option;
                          });
                        },
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? filterColor.withValues(alpha: 0.1)
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? filterColor
                                  : theme.colorScheme.outline.withValues(alpha: 0.3),
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? filterColor.withValues(alpha: 0.2)
                                      : theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: CustomIconWidget(
                                  iconName: _getFilterIcon(option).codePoint.toString(),
                                  color:
                                      isSelected ? filterColor : theme.colorScheme.onSurfaceVariant,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getFilterTitle(option),
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        color:
                                            isSelected ? filterColor : theme.colorScheme.onSurface,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _getFilterDescription(option),
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                CustomIconWidget(
                                  iconName: 'check_circle',
                                  color: filterColor,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),

          // Apply button
          Container(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApplyFilter(_selectedSort, _selectedFilter);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
                child: Text(
                  'Apply Filter',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
