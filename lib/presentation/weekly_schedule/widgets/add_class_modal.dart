import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AddClassModal extends StatefulWidget {
  final String? initialTime;
  final Map<String, dynamic>? existingClass;
  final Function(Map<String, dynamic>) onSave;

  const AddClassModal({
    super.key,
    this.initialTime,
    this.existingClass,
    required this.onSave,
  });

  @override
  State<AddClassModal> createState() => _AddClassModalState();
}

class _AddClassModalState extends State<AddClassModal> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _locationController = TextEditingController();
  final _instructorController = TextEditingController();
  final _notesController = TextEditingController();

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _selectedDuration = '1h';
  List<String> _selectedDays = [];
  Color _selectedColor = AppTheme.lightTheme.colorScheme.primary;

  final List<String> _durations = ['30min', '1h', '1h 30min', '2h', '2h 30min', '3h'];
  final List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<Color> _colors = [
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

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.existingClass != null) {
      final classData = widget.existingClass!;
      _subjectController.text = classData['subject'] as String? ?? '';
      _locationController.text = classData['location'] as String? ?? '';
      _instructorController.text = classData['instructor'] as String? ?? '';
      _notesController.text = classData['notes'] as String? ?? '';
      _selectedDuration = classData['duration'] as String? ?? '1h';
      _selectedDays = List<String>.from(classData['days'] as List? ?? []);

      // Parse time if available
      if (classData['startTime'] != null) {
        final timeParts = (classData['startTime'] as String).split(':');
        _startTime = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1]),
        );
      }
    } else if (widget.initialTime != null) {
      final timeParts = widget.initialTime!.split(':');
      _startTime = TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  widget.existingClass != null ? 'Edit Class' : 'Add Class',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: _saveClass,
                  child: Text(
                    'Save',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Form content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubjectField(),
                    SizedBox(height: 3.h),
                    _buildTimeSection(),
                    SizedBox(height: 3.h),
                    _buildDurationSection(),
                    SizedBox(height: 3.h),
                    _buildLocationField(),
                    SizedBox(height: 3.h),
                    _buildInstructorField(),
                    SizedBox(height: 3.h),
                    _buildRepeatSection(),
                    SizedBox(height: 3.h),
                    _buildColorSection(),
                    SizedBox(height: 3.h),
                    _buildNotesField(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subject',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _subjectController,
          decoration: const InputDecoration(
            hintText: 'Enter subject name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a subject name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTimeSection() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(true),
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'access_time',
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        _startTime?.format(context) ?? 'Start time',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Text('to', style: theme.textTheme.bodySmall),
            SizedBox(width: 2.w),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(false),
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'access_time',
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        _endTime?.format(context) ?? 'End time',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDurationSection() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duration',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _durations.map((duration) {
            final isSelected = _selectedDuration == duration;
            return GestureDetector(
              onTap: () => setState(() => _selectedDuration = duration),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
                  border: Border.all(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  duration,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _locationController,
          decoration: const InputDecoration(
            hintText: 'Enter location (optional)',
          ),
        ),
      ],
    );
  }

  Widget _buildInstructorField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructor',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _instructorController,
          decoration: const InputDecoration(
            hintText: 'Enter instructor name (optional)',
          ),
        ),
      ],
    );
  }

  Widget _buildRepeatSection() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Repeat',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _weekDays.map((day) {
            final isSelected = _selectedDays.contains(day);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedDays.remove(day);
                  } else {
                    _selectedDays.add(day);
                  }
                });
              },
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
                  border: Border.all(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    day,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorSection() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _colors.map((color) {
            final isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      isSelected ? Border.all(color: theme.colorScheme.onSurface, width: 2) : null,
                ),
                child: isSelected
                    ? Center(
                        child: CustomIconWidget(
                          iconName: 'check',
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Add notes (optional)',
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? (_startTime ?? TimeOfDay.now()) : (_endTime ?? TimeOfDay.now()),
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _saveClass() {
    if (_formKey.currentState!.validate()) {
      final classData = {
        'id': widget.existingClass?['id'] ?? DateTime.now().millisecondsSinceEpoch,
        'subject': _subjectController.text,
        'location': _locationController.text.isEmpty ? null : _locationController.text,
        'instructor': _instructorController.text.isEmpty ? null : _instructorController.text,
        'notes': _notesController.text.isEmpty ? null : _notesController.text,
        'startTime': _startTime != null
            ? '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}'
            : null,
        'endTime': _endTime != null
            ? '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}'
            : null,
        'duration': _selectedDuration,
        'days': _selectedDays,
        'color': _selectedColor.value,
      };

      widget.onSave(classData);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _locationController.dispose();
    _instructorController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
