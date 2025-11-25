import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TaskFormWidget extends StatefulWidget {
  final Map<String, dynamic>? taskData;
  final Function(Map<String, dynamic>) onSave;
  final Future<void> Function() onCancel;
  final VoidCallback onChanged;

  const TaskFormWidget({
    super.key,
    this.taskData,
    required this.onSave,
    required this.onCancel,
    required this.onChanged,
  });

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  DateTime? _selectedDate;
  String _selectedSubject = 'General';
  String _selectedPriority = 'Medium';
  bool _reminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);
  bool _isLoading = false;

  final List<Map<String, dynamic>> _subjects = [
    {'name': 'General', 'color': AppTheme.lightTheme.colorScheme.primary},
    {'name': 'Mathematics', 'color': const Color(0xFF2196F3)},
    {'name': 'Science', 'color': const Color(0xFF4CAF50)},
    {'name': 'English', 'color': const Color(0xFFFF9800)},
    {'name': 'History', 'color': const Color(0xFF9C27B0)},
    {'name': 'Art', 'color': const Color(0xFFE91E63)},
    {'name': 'Physical Education', 'color': const Color(0xFF795548)},
    {'name': 'Computer Science', 'color': const Color(0xFF607D8B)},
  ];

  final List<Map<String, dynamic>> _priorities = [
    {
      'name': 'High',
      'color': AppTheme.errorLight,
      'icon': 'priority_high',
    },
    {
      'name': 'Medium',
      'color': AppTheme.warningLight,
      'icon': 'remove',
    },
    {
      'name': 'Low',
      'color': AppTheme.successLight,
      'icon': 'keyboard_arrow_down',
    },
  ];

  bool get _isEditing => widget.taskData != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _initializeForm();
  }

  void _initializeForm() {
    final data = widget.taskData;

    if (data != null) {
      _titleController.text = (data['title'] ?? '').toString();
      _descriptionController.text = (data['description'] ?? '').toString();

      _selectedSubject = (data['subject'] ?? 'General').toString();
      if (!_subjects.any((s) => s['name'] == _selectedSubject)) {
        _selectedSubject = 'General';
      }

      _selectedPriority = (data['priority'] ?? 'Medium').toString();
      if (!_priorities.any((p) => p['name'] == _selectedPriority)) {
        _selectedPriority = 'Medium';
      }

      _reminderEnabled = (data['reminderEnabled'] ?? false) as bool;

      final dueDateValue = data['dueDate'];
      if (dueDateValue is String && dueDateValue.isNotEmpty) {
        try {
          _selectedDate = DateTime.parse(dueDateValue);
        } catch (_) {
          _selectedDate = null;
        }
      }

      final reminderTimeValue = data['reminderTime'];
      if (reminderTimeValue is String && reminderTimeValue.contains(':')) {
        final parts = reminderTimeValue.split(':');
        if (parts.length >= 2) {
          final hour = int.tryParse(parts[0]);
          final minute = int.tryParse(parts[1]);
          if (hour != null && minute != null) {
            _reminderTime = TimeOfDay(hour: hour, minute: minute);
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
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

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onChanged();
    }
  }

  Future<void> _pickReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
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

    if (picked != null) {
      setState(() {
        _reminderTime = picked;
      });
      widget.onChanged();
    }
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate async save (replace with your DB / API call)
    await Future.delayed(const Duration(milliseconds: 600));

    final now = DateTime.now();
    final existing = widget.taskData;

    final taskData = <String, dynamic>{
      'id': existing?['id'] ?? DateTime.now().millisecondsSinceEpoch,
      'title': _titleController.text.trim(),
      'description':
          _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
      'subject': _selectedSubject,
      'priority': _selectedPriority,
      'dueDate': _selectedDate?.toIso8601String(),
      'reminderEnabled': _reminderEnabled,
      'reminderTime':
          '${_reminderTime.hour.toString().padLeft(2, '0')}:${_reminderTime.minute.toString().padLeft(2, '0')}',
      'isCompleted': existing?['isCompleted'] ?? false,
      'createdAt': existing?['createdAt'] ?? now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    };

    setState(() => _isLoading = false);

    widget.onSave(taskData);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField(theme),
          SizedBox(height: 3.h),
          _buildDescriptionField(theme),
          SizedBox(height: 3.h),
          _buildSubjectSelector(theme),
          SizedBox(height: 3.h),
          _buildPrioritySelector(theme),
          SizedBox(height: 3.h),
          _buildDateSelector(theme),
          SizedBox(height: 3.h),
          _buildReminderSection(theme),
          SizedBox(height: 4.h),
          _buildActionButtons(theme),
        ],
      ),
    );
  }

  Widget _buildTitleField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Title',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _titleController,
          maxLength: 100,
          decoration: InputDecoration(
            hintText: 'Enter task title',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'task',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
          validator: (value) {
            final text = (value ?? '').trim();
            if (text.isEmpty) {
              return 'Please enter a task title';
            }
            if (text.length < 3) {
              return 'Title must be at least 3 characters long';
            }
            return null;
          },
          onChanged: (_) {
            setState(() {});
            widget.onChanged();
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _descriptionController,
          maxLines: 4,
          maxLength: 500,
          decoration: const InputDecoration(
            hintText: 'Enter task description (optional)',
            alignLabelWithHint: true,
          ),
          onChanged: (_) {
            setState(() {});
            widget.onChanged();
          },
        ),
      ],
    );
  }

  Widget _buildSubjectSelector(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subject',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSubject,
              isExpanded: true,
              icon: CustomIconWidget(
                iconName: 'keyboard_arrow_down',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              items: _subjects.map((subject) {
                return DropdownMenuItem<String>(
                  value: subject['name'].toString(),
                  child: Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                          color: subject['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(subject['name'].toString()),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedSubject = value;
                });
                widget.onChanged();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrioritySelector(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: _priorities.map((priority) {
            final name = priority['name'] as String;
            final color = priority['color'] as Color;
            final iconName = priority['icon'] as String;
            final isSelected = _selectedPriority == name;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPriority = name;
                  });
                  widget.onChanged();
                },
                child: Container(
                  margin: EdgeInsets.only(right: priority == _priorities.last ? 0 : 2.w),
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? color : AppTheme.lightTheme.colorScheme.outline,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: iconName,
                        color:
                            isSelected ? color : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color:
                              isSelected ? color : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateSelector(ThemeData theme) {
    final dateText = _selectedDate != null
        ? '${_selectedDate!.day.toString().padLeft(2, '0')}/'
            '${_selectedDate!.month.toString().padLeft(2, '0')}/'
            '${_selectedDate!.year}'
        : 'Select due date (optional)';

    final textColor = _selectedDate != null
        ? AppTheme.lightTheme.colorScheme.onSurface
        : AppTheme.lightTheme.colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        InkWell(
          onTap: _pickDate,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'calendar_today',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Text(
                  dateText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: textColor,
                  ),
                ),
                const Spacer(),
                if (_selectedDate != null)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = null;
                      });
                      widget.onChanged();
                    },
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 18,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Reminder',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            CupertinoSwitch(
              value: _reminderEnabled,
              activeColor: theme.colorScheme.primary,
              onChanged: (value) {
                setState(() => _reminderEnabled = value);
                widget.onChanged();
              },
            ),
          ],
        ),
        if (_reminderEnabled) ...[
          SizedBox(height: 1.h),
          InkWell(
            onTap: _pickReminderTime,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'access_time',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Remind me at ${_reminderTime.format(context)}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => widget.onCancel(),
            child: const Text('Cancel'),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveTask,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(_isEditing ? 'Update Task' : 'Save Task'),
          ),
        ),
      ],
    );
  }
}
