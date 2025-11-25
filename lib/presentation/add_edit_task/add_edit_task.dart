import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/task_form_widget.dart';

class AddEditTask extends StatefulWidget {
  const AddEditTask({super.key});

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  Map<String, dynamic>? _initialTaskData;
  bool _hasUnsavedChanges = false;
  int _currentBottomBarIndex = 1; // If you use bottom bar

  bool get _isEditing => _initialTaskData != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Only set once (avoid resetting on rebuild)
    if (_initialTaskData != null) return;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _initialTaskData = args;
    }
  }

  /// Called whenever the form changes (title, description, etc.)
  void _handleFormChanged() {
    if (!_hasUnsavedChanges) {
      setState(() {
        _hasUnsavedChanges = true;
      });
    }
  }

  /// Called when the form successfully saves the task
  void _handleSave(Map<String, dynamic> taskData) {
    setState(() {
      _hasUnsavedChanges = false;
      _initialTaskData = taskData;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            _isEditing ? 'Task updated successfully!' : 'Task created successfully!',
          ),
          backgroundColor: AppTheme.successLight,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

    // Option 1: return to previous page with result
    Navigator.of(context).pop(taskData);

    // Option 2: go to a specific page
    // Navigator.pushReplacementNamed(context, '/task-management');
  }

  /// Back button in AppBar
  Future<void> _handleBackPressed() async {
    final shouldLeave = await _confirmDiscardIfNeeded();
    if (shouldLeave && mounted) {
      Navigator.of(context).pop();
    }
  }

  /// Called by "Cancel" button in the form
  Future<void> _handleCancel() async {
    final shouldLeave = await _confirmDiscardIfNeeded();
    if (shouldLeave && mounted) {
      Navigator.of(context).pop();
    }
  }

  /// Common logic for handling unsaved changes
  Future<bool> _confirmDiscardIfNeeded() async {
    if (!_hasUnsavedChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Unsaved Changes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          content: Text(
            'You have unsaved changes. Are you sure you want to discard them?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Continue Editing'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Discard',
                style: TextStyle(color: AppTheme.errorLight),
              ),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  void _onBottomBarTap(int index) {
    setState(() {
      _currentBottomBarIndex = index;
    });

    // TODO: handle navigation between tabs if you use a custom bottom bar
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle system back button
        return _confirmDiscardIfNeeded();
      },
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        appBar: _buildAppBar(),
        body: _buildBody(),
        // If you have a custom bottom nav, you can re-enable this:
        // bottomNavigationBar: CustomBottomBar(
        //   currentIndex: _currentBottomBarIndex,
        //   onTap: _onBottomBarTap,
        //   variant: BottomBarVariant.floating,
        // ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: _handleBackPressed,
        icon: CustomIconWidget(
          iconName: 'arrow_back',
          color: AppTheme.lightTheme.colorScheme.onSurface,
          size: 24,
        ),
      ),
      title: Text(
        _isEditing ? 'Edit Task' : 'Add New Task',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
      ),
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildHeaderCard(),
              // SizedBox(height: 3.h),
              _buildFormCard(),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    final theme = AppTheme.lightTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.08),
            theme.colorScheme.secondary.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: _isEditing ? 'edit' : 'add_task',
              color: theme.colorScheme.primary,
              size: 24,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEditing ? 'Edit Task' : 'Create New Task',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  _isEditing
                      ? 'Update your task details and save changes.'
                      : 'Fill in the details below to create a new task.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    final theme = AppTheme.lightTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TaskFormWidget(
        taskData: _initialTaskData,
        onSave: _handleSave,
        onCancel: _handleCancel,
        onChanged: _handleFormChanged,
      ),
    );
  }
}
