import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddTask;
  final bool isAssignment;

  const AddTaskBottomSheet({
    super.key,
    required this.onAddTask,
    this.isAssignment = false,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  String _selectedSubject = 'Mathematics';
  String _selectedPriority = 'medium';
  String _selectedType = 'Homework';

  final List<String> _subjects = [
    'Mathematics',
    'Science',
    'English',
    'History',
    'Physics',
    'Chemistry',
    'Biology',
    'Computer Science',
    'Art',
    'Music',
  ];

  final List<String> _priorities = ['low', 'medium', 'high'];
  final List<String> _assignmentTypes = [
    'Homework',
    'Project',
    'Essay',
    'Lab Report',
    'Presentation',
    'Quiz',
    'Exam',
    'Research',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppTheme.lightTheme.colorScheme.primary,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      final task = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'subject': _selectedSubject,
        'priority': _selectedPriority,
        'dueDate': _selectedDate,
        'isCompleted': false,
        'createdAt': DateTime.now(),
        if (widget.isAssignment) 'type': _selectedType,
      };

      widget.onAddTask(task);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 85.h,
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
                  widget.isAssignment ? 'Add Assignment' : 'Add Task',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
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

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title field
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: widget.isAssignment ? 'Assignment Title' : 'Task Title',
                        hintText: widget.isAssignment
                            ? 'Enter assignment title...'
                            : 'Enter task title...',
                        prefixIcon: CustomIconWidget(
                          iconName: widget.isAssignment ? 'assignment' : 'task',
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.sentences,
                    ),

                    SizedBox(height: 3.h),

                    // Description field
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description (Optional)',
                        hintText: 'Enter description...',
                        prefixIcon: CustomIconWidget(
                          iconName: 'description',
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                    ),

                    SizedBox(height: 3.h),

                    // Due date
                    InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.outline),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'calendar_today',
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Due Date',
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    _selectedDate != null
                                        ? '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}'
                                        : 'Select due date',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: _selectedDate != null
                                          ? theme.colorScheme.onSurface
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomIconWidget(
                              iconName: 'arrow_forward_ios',
                              color: theme.colorScheme.onSurfaceVariant,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Subject dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedSubject,
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        prefixIcon: CustomIconWidget(
                          iconName: 'school',
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      items: _subjects.map((subject) {
                        return DropdownMenuItem(
                          value: subject,
                          child: Text(subject),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedSubject = value;
                          });
                        }
                      },
                    ),

                    SizedBox(height: 3.h),

                    // Priority selection
                    Text(
                      'Priority',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: _priorities.map((priority) {
                        final isSelected = _selectedPriority == priority;
                        Color priorityColor;
                        switch (priority) {
                          case 'high':
                            priorityColor = AppTheme.lightTheme.colorScheme.error;
                            break;
                          case 'medium':
                            priorityColor = AppTheme.lightTheme.colorScheme.tertiary;
                            break;
                          case 'low':
                            priorityColor = AppTheme.lightTheme.colorScheme.primary;
                            break;
                          default:
                            priorityColor = AppTheme.lightTheme.colorScheme.primary;
                        }

                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: priority != _priorities.last ? 2.w : 0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedPriority = priority;
                                });
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? priorityColor.withValues(alpha: 0.1)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected ? priorityColor : theme.colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  priority.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: isSelected
                                        ? priorityColor
                                        : theme.colorScheme.onSurfaceVariant,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    if (widget.isAssignment) ...[
                      SizedBox(height: 3.h),

                      // Assignment type dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedType,
                        decoration: InputDecoration(
                          labelText: 'Assignment Type',
                          prefixIcon: CustomIconWidget(
                            iconName: 'category',
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                        ),
                        items: _assignmentTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedType = value;
                            });
                          }
                        },
                      ),
                    ],

                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ),

          // Submit button
          Container(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitTask,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
                child: Text(
                  widget.isAssignment ? 'Add Assignment' : 'Add Task',
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
