import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/add_task_bottom_sheet.dart';
import './widgets/assignment_item_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_bottom_sheet.dart';
import './widgets/task_item_widget.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;
  String _searchQuery = '';
  SortOption _currentSort = SortOption.dueDate;
  FilterOption _currentFilter = FilterOption.all;

  final List<Map<String, dynamic>> _tasks = [
    {
      'id': 1,
      'title': 'Complete Math Homework',
      'description': 'Solve problems 1-20 from Chapter 5: Quadratic Equations',
      'subject': 'Mathematics',
      'priority': 'high',
      'dueDate': DateTime.now().add(const Duration(days: 1)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': 2,
      'title': 'Read History Chapter',
      'description': 'Read Chapter 12: World War II and take notes',
      'subject': 'History',
      'priority': 'medium',
      'dueDate': DateTime.now().add(const Duration(days: 3)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 3,
      'title': 'Study for Physics Quiz',
      'description': 'Review chapters on motion and forces',
      'subject': 'Physics',
      'priority': 'high',
      'dueDate': DateTime.now().subtract(const Duration(days: 1)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': 4,
      'title': 'Practice Piano',
      'description': 'Practice scales and new song',
      'subject': 'Music',
      'priority': 'low',
      'dueDate': DateTime.now().add(const Duration(days: 2)),
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 4)),
    },

    // New tasks
    {
      'id': 5,
      'title': 'Biology Notes Revision',
      'description': 'Revise diagrams and definitions from Chapter 6',
      'subject': 'Biology',
      'priority': 'medium',
      'dueDate': DateTime.now().add(const Duration(days: 2)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 6,
      'title': 'Chemistry Formula Practice',
      'description': 'Memorize important formulas for upcoming test',
      'subject': 'Chemistry',
      'priority': 'high',
      'dueDate': DateTime.now().add(const Duration(days: 4)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      'id': 7,
      'title': 'English Poem Summary',
      'description': 'Write summary for the poem "Daffodils"',
      'subject': 'English',
      'priority': 'low',
      'dueDate': DateTime.now().add(const Duration(days: 1)),
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(hours: 8)),
    },
    {
      'id': 8,
      'title': 'Geography Map Practice',
      'description': 'Label the countries in South America',
      'subject': 'Geography',
      'priority': 'medium',
      'dueDate': DateTime.now().add(const Duration(days: 5)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': 9,
      'title': 'Computer Science Debugging Practice',
      'description': 'Debug the Python programs provided by the teacher',
      'subject': 'Computer Science',
      'priority': 'high',
      'dueDate': DateTime.now().add(const Duration(days: 2)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(hours: 12)),
    },
    {
      'id': 10,
      'title': 'Art Sketch Practice',
      'description': 'Draw 3 still-life sketches',
      'subject': 'Art',
      'priority': 'low',
      'dueDate': DateTime.now().add(const Duration(days: 6)),
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 6)),
    },
    {
      'id': 11,
      'title': 'PE Workout Log',
      'description': 'Update weekly workout and cardio activity log',
      'subject': 'Physical Education',
      'priority': 'low',
      'dueDate': DateTime.now().add(const Duration(days: 3)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 12,
      'title': 'French Vocabulary Practice',
      'description': 'Learn 20 new French words and phrases',
      'subject': 'French',
      'priority': 'medium',
      'dueDate': DateTime.now().add(const Duration(days: 2)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    },
  ];

  final List<Map<String, dynamic>> _assignments = [
    {
      'id': 1,
      'title': 'Science Lab Report',
      'description': 'Write a detailed report on the chemical reactions experiment',
      'subject': 'Chemistry',
      'priority': 'high',
      'type': 'Lab Report',
      'dueDate': DateTime.now().add(const Duration(days: 5)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 2,
      'title': 'English Essay',
      'description': 'Write a 1000-word essay on Shakespeare\'s Hamlet',
      'subject': 'English',
      'priority': 'medium',
      'type': 'Essay',
      'dueDate': DateTime.now().add(const Duration(days: 7)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': 3,
      'title': 'Math Project',
      'description': 'Create a presentation on real-world applications of calculus',
      'subject': 'Mathematics',
      'priority': 'high',
      'type': 'Project',
      'dueDate': DateTime.now().subtract(const Duration(days: 2)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 10)),
    },
    {
      'id': 4,
      'title': 'Computer Science Assignment',
      'description': 'Implement a sorting algorithm in Python',
      'subject': 'Computer Science',
      'priority': 'medium',
      'type': 'Homework',
      'dueDate': DateTime.now().add(const Duration(days: 4)),
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      'id': 5,
      'title': 'Biology Presentation',
      'description': 'Prepare slides on Human Digestive System',
      'subject': 'Biology',
      'priority': 'high',
      'type': 'Presentation',
      'dueDate': DateTime.now().add(const Duration(days: 3)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': 6,
      'title': 'History Research Paper',
      'description': 'Research on the causes of the French Revolution',
      'subject': 'History',
      'priority': 'high',
      'type': 'Research Paper',
      'dueDate': DateTime.now().add(const Duration(days: 6)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 7,
      'title': 'Geography Field Study Report',
      'description': 'Write a report on soil types observed in the field trip',
      'subject': 'Geography',
      'priority': 'medium',
      'type': 'Report',
      'dueDate': DateTime.now().add(const Duration(days: 4)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 4)),
    },
    {
      'id': 8,
      'title': 'Music Composition Task',
      'description': 'Compose a 30-second melody using three instruments',
      'subject': 'Music',
      'priority': 'low',
      'type': 'Composition',
      'dueDate': DateTime.now().add(const Duration(days: 2)),
      'isCompleted': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 9,
      'title': 'Art Portfolio Submission',
      'description': 'Submit your 5 best sketches and 2 paintings',
      'subject': 'Art',
      'priority': 'medium',
      'type': 'Portfolio',
      'dueDate': DateTime.now().add(const Duration(days: 1)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 6)),
    },
    {
      'id': 10,
      'title': 'Physics Practical Assignment',
      'description': 'Complete experiments on Optics and Document Observations',
      'subject': 'Physics',
      'priority': 'high',
      'type': 'Practical',
      'dueDate': DateTime.now().add(const Duration(days: 5)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(hours: 10)),
    },
    {
      'id': 11,
      'title': 'Computer Science Mini Project',
      'description': 'Develop a simple calculator app using Python GUI',
      'subject': 'Computer Science',
      'priority': 'high',
      'type': 'Project',
      'dueDate': DateTime.now().add(const Duration(days: 8)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': 12,
      'title': 'Economics Assignment',
      'description': 'Write a detailed report on supply and demand curves',
      'subject': 'Economics',
      'priority': 'medium',
      'type': 'Homework',
      'dueDate': DateTime.now().add(const Duration(days: 6)),
      'isCompleted': false,
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredTasks() {
    List<Map<String, dynamic>> filtered = List.from(_tasks);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((task) {
        final title = (task['title'] as String? ?? '').toLowerCase();
        final description = (task['description'] as String? ?? '').toLowerCase();
        final subject = (task['subject'] as String? ?? '').toLowerCase();
        final query = _searchQuery.toLowerCase();

        return title.contains(query) || description.contains(query) || subject.contains(query);
      }).toList();
    }

    // Apply completion filter
    switch (_currentFilter) {
      case FilterOption.completed:
        filtered = filtered.where((task) => task['isCompleted'] == true).toList();
        break;
      case FilterOption.pending:
        filtered = filtered.where((task) => task['isCompleted'] == false).toList();
        break;
      case FilterOption.overdue:
        filtered = filtered.where((task) {
          if (task['dueDate'] == null || task['isCompleted'] == true) return false;
          return (task['dueDate'] as DateTime).isBefore(DateTime.now());
        }).toList();
        break;
      case FilterOption.all:
      default:
        break;
    }

    // Apply sorting
    switch (_currentSort) {
      case SortOption.dueDate:
        filtered.sort((a, b) {
          final aDate = a['dueDate'] as DateTime?;
          final bDate = b['dueDate'] as DateTime?;
          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;
          return aDate.compareTo(bDate);
        });
        break;
      case SortOption.priority:
        filtered.sort((a, b) {
          final priorities = {'high': 3, 'medium': 2, 'low': 1};
          final aPriority = priorities[a['priority']] ?? 1;
          final bPriority = priorities[b['priority']] ?? 1;
          return bPriority.compareTo(aPriority);
        });
        break;
      case SortOption.subject:
        filtered.sort(
            (a, b) => (a['subject'] as String? ?? '').compareTo(b['subject'] as String? ?? ''));
        break;
      case SortOption.completion:
        filtered.sort((a, b) => (a['isCompleted'] as bool? ?? false) ? 1 : -1);
        break;
      case SortOption.alphabetical:
        filtered
            .sort((a, b) => (a['title'] as String? ?? '').compareTo(b['title'] as String? ?? ''));
        break;
    }

    return filtered;
  }

  List<Map<String, dynamic>> _getFilteredAssignments() {
    List<Map<String, dynamic>> filtered = List.from(_assignments);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((assignment) {
        final title = (assignment['title'] as String? ?? '').toLowerCase();
        final description = (assignment['description'] as String? ?? '').toLowerCase();
        final subject = (assignment['subject'] as String? ?? '').toLowerCase();
        final type = (assignment['type'] as String? ?? '').toLowerCase();
        final query = _searchQuery.toLowerCase();

        return title.contains(query) ||
            description.contains(query) ||
            subject.contains(query) ||
            type.contains(query);
      }).toList();
    }

    // Apply completion filter
    switch (_currentFilter) {
      case FilterOption.completed:
        filtered = filtered.where((assignment) => assignment['isCompleted'] == true).toList();
        break;
      case FilterOption.pending:
        filtered = filtered.where((assignment) => assignment['isCompleted'] == false).toList();
        break;
      case FilterOption.overdue:
        filtered = filtered.where((assignment) {
          if (assignment['dueDate'] == null || assignment['isCompleted'] == true) return false;
          return (assignment['dueDate'] as DateTime).isBefore(DateTime.now());
        }).toList();
        break;
      case FilterOption.all:
      default:
        break;
    }

    // Apply sorting
    switch (_currentSort) {
      case SortOption.dueDate:
        filtered.sort((a, b) {
          final aDate = a['dueDate'] as DateTime?;
          final bDate = b['dueDate'] as DateTime?;
          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;
          return aDate.compareTo(bDate);
        });
        break;
      case SortOption.priority:
        filtered.sort((a, b) {
          final priorities = {'high': 3, 'medium': 2, 'low': 1};
          final aPriority = priorities[a['priority']] ?? 1;
          final bPriority = priorities[b['priority']] ?? 1;
          return bPriority.compareTo(aPriority);
        });
        break;
      case SortOption.subject:
        filtered.sort(
            (a, b) => (a['subject'] as String? ?? '').compareTo(b['subject'] as String? ?? ''));
        break;
      case SortOption.completion:
        filtered.sort((a, b) => (a['isCompleted'] as bool? ?? false) ? 1 : -1);
        break;
      case SortOption.alphabetical:
        filtered
            .sort((a, b) => (a['title'] as String? ?? '').compareTo(b['title'] as String? ?? ''));
        break;
    }

    return filtered;
  }

  void _toggleTaskCompletion(Map<String, dynamic> task) {
    setState(() {
      final index = _tasks.indexWhere((t) => t['id'] == task['id']);
      if (index != -1) {
        _tasks[index]['isCompleted'] = !(_tasks[index]['isCompleted'] as bool);
      }
    });

    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _tasks.firstWhere((t) => t['id'] == task['id'])['isCompleted']
              ? 'Task marked as completed!'
              : 'Task marked as pending',
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => _toggleTaskCompletion(task),
        ),
      ),
    );
  }

  void _toggleAssignmentCompletion(Map<String, dynamic> assignment) {
    setState(() {
      final index = _assignments.indexWhere((a) => a['id'] == assignment['id']);
      if (index != -1) {
        _assignments[index]['isCompleted'] = !(_assignments[index]['isCompleted'] as bool);
      }
    });

    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _assignments.firstWhere((a) => a['id'] == assignment['id'])['isCompleted']
              ? 'Assignment marked as submitted!'
              : 'Assignment marked as pending',
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => _toggleAssignmentCompletion(assignment),
        ),
      ),
    );
  }

  void _deleteTask(Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _tasks.removeWhere((t) => t['id'] == task['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task deleted')),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppTheme.lightTheme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAssignment(Map<String, dynamic> assignment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Assignment'),
        content: Text('Are you sure you want to delete "${assignment['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _assignments.removeWhere((a) => a['id'] == assignment['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Assignment deleted')),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppTheme.lightTheme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _addTask(Map<String, dynamic> task) {
    setState(() {
      if (task.containsKey('type')) {
        _assignments.add(task);
      } else {
        _tasks.add(task);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          task.containsKey('type') ? 'Assignment added successfully!' : 'Task added successfully!',
        ),
      ),
    );
  }

  void _showAddTaskBottomSheet({bool isAssignment = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTaskBottomSheet(
        onAddTask: _addTask,
        isAssignment: isAssignment,
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        currentSort: _currentSort,
        currentFilter: _currentFilter,
        onApplyFilter: (sort, filter) {
          setState(() {
            _currentSort = sort;
            _currentFilter = filter;
          });
        },
      ),
    );
  }

  void _onItemTap(Map<String, dynamic> item) {
    Navigator.pushNamed(context, '/add-edit-task', arguments: item);
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Simulate data refresh
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredTasks = _getFilteredTasks();
    final filteredAssignments = _getFilteredAssignments();

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search tasks and assignments...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              )
            : const Text('Task Management'),
        actions: [
          if (_isSearching)
            IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchQuery = '';
                  _searchController.clear();
                });
              },
              icon: CustomIconWidget(
                iconName: 'close',
                color: theme.colorScheme.onSurface,
                size: 24,
              ),
            )
          else ...[
            IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
              icon: CustomIconWidget(
                iconName: 'search',
                color: theme.colorScheme.onSurface,
                size: 24,
              ),
            ),
            IconButton(
              onPressed: _showFilterBottomSheet,
              icon: CustomIconWidget(
                iconName: 'filter_list',
                color: theme.colorScheme.onSurface,
                size: 24,
              ),
            ),
          ],
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tasks'),
            Tab(text: 'Assignments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tasks tab
          filteredTasks.isEmpty
              ? EmptyStateWidget(
                  isAssignment: false,
                  onAddPressed: () => _showAddTaskBottomSheet(isAssignment: false),
                )
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskItemWidget(
                        task: task,
                        isCompleted: task['isCompleted'] as bool? ?? false,
                        onTap: () => _onItemTap(task),
                        onComplete: () => _toggleTaskCompletion(task),
                        onDelete: () => _deleteTask(task),
                      );
                    },
                  ),
                ),

          // Assignments tab
          filteredAssignments.isEmpty
              ? EmptyStateWidget(
                  isAssignment: true,
                  onAddPressed: () => _showAddTaskBottomSheet(isAssignment: true),
                )
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    itemCount: filteredAssignments.length,
                    itemBuilder: (context, index) {
                      final assignment = filteredAssignments[index];
                      return AssignmentItemWidget(
                        assignment: assignment,
                        isCompleted: assignment['isCompleted'] as bool? ?? false,
                        onTap: () => _onItemTap(assignment),
                        onComplete: () => _toggleAssignmentCompletion(assignment),
                        onDelete: () => _deleteAssignment(assignment),
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskBottomSheet(
          isAssignment: _tabController.index == 1,
        ),
        child: CustomIconWidget(
          iconName: 'add',
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
