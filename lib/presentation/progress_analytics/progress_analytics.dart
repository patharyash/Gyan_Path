import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_icon_widget.dart';
import '../Profile/profile_screen.dart';
import './widgets/detailed_progress_modal.dart';
import './widgets/metric_card_widget.dart';
import './widgets/progress_chart_widget.dart';
import './widgets/subject_progress_widget.dart';

class ProgressAnalytics extends StatefulWidget {
  const ProgressAnalytics({super.key});

  @override
  State<ProgressAnalytics> createState() => _ProgressAnalyticsState();
}

class _ProgressAnalyticsState extends State<ProgressAnalytics> with TickerProviderStateMixin {
  int _currentBottomBarIndex = 4;
  String _selectedPeriod = 'Weekly';
  bool _isLoading = false;
  late AnimationController _refreshController;
  late Animation<double> _refreshAnimation;

  // Mock data for analytics
  final List<Map<String, dynamic>> _weeklyData = [
    {
      "label": "Mon",
      "value": 85.0,
      "completed": 17,
      "pending": 3,
      "total": 20,
      "tasks": [
        {
          "title": "Complete Math Assignment Chapter 5",
          "completed": true,
          "dueDate": "Nov 18, 2025",
          "priority": "High"
        },
        {
          "title": "Read History Chapter 12",
          "completed": true,
          "dueDate": "Nov 18, 2025",
          "priority": "Medium"
        },
        {
          "title": "Physics Lab Report",
          "completed": false,
          "dueDate": "Nov 19, 2025",
          "priority": "High"
        },
      ]
    },
    {
      "label": "Tue",
      "value": 92.0,
      "completed": 23,
      "pending": 2,
      "total": 25,
      "tasks": [
        {
          "title": "Chemistry Quiz Preparation",
          "completed": true,
          "dueDate": "Nov 19, 2025",
          "priority": "High"
        },
        {
          "title": "English Essay Draft",
          "completed": true,
          "dueDate": "Nov 20, 2025",
          "priority": "Medium"
        },
      ]
    },
    {
      "label": "Wed",
      "value": 78.0,
      "completed": 14,
      "pending": 4,
      "total": 18,
      "tasks": [
        {
          "title": "Biology Lab Worksheet",
          "completed": true,
          "dueDate": "Nov 20, 2025",
          "priority": "Medium"
        },
        {
          "title": "Spanish Vocabulary Review",
          "completed": false,
          "dueDate": "Nov 21, 2025",
          "priority": "Low"
        },
      ]
    },
    {
      "label": "Thu",
      "value": 95.0,
      "completed": 19,
      "pending": 1,
      "total": 20,
      "tasks": [
        {
          "title": "Computer Science Project",
          "completed": true,
          "dueDate": "Nov 21, 2025",
          "priority": "High"
        },
      ]
    },
    {
      "label": "Fri",
      "value": 88.0,
      "completed": 15,
      "pending": 2,
      "total": 17,
      "tasks": [
        {
          "title": "Art Portfolio Review",
          "completed": true,
          "dueDate": "Nov 22, 2025",
          "priority": "Medium"
        },
        {
          "title": "Music Theory Practice",
          "completed": false,
          "dueDate": "Nov 23, 2025",
          "priority": "Low"
        },
      ]
    },
    {
      "label": "Sat",
      "value": 50.0,
      "completed": 20,
      "pending": 2,
      "total": 30,
      "tasks": [
        {
          "title": "Art Portfolio Review",
          "completed": true,
          "dueDate": "Nov 22, 2025",
          "priority": "Medium"
        },
        {
          "title": "Music Theory Practice",
          "completed": false,
          "dueDate": "Nov 23, 2025",
          "priority": "Low"
        },
      ]
    },
  ];

  final List<Map<String, dynamic>> _monthlyData = [
    {"label": "Week 1", "value": 82.0, "completed": 164, "pending": 36, "total": 200, "tasks": []},
    {"label": "Week 2", "value": 89.0, "completed": 178, "pending": 22, "total": 200, "tasks": []},
    {"label": "Week 3", "value": 91.0, "completed": 182, "pending": 18, "total": 200, "tasks": []},
    {"label": "Week 4", "value": 87.0, "completed": 174, "pending": 26, "total": 200, "tasks": []},
    {
      "label": "Week 5",
      "value": 80.0,
      "completed": 156,
      "pending": 13,
      "total": 200,
      "tasks": ["ashish", "Yash"]
    },
  ];

  final List<Map<String, dynamic>> _subjectData = [
    {
      "name": "Mathematics",
      "progress": 92.0,
      "completed": 46,
      "total": 50,
      "color": 0xFF2563EB,
      "lastUpdated": "2 hours ago",
      "taskList": [
        {
          "title": "Calculus Problem Set 12",
          "completed": true,
          "dueDate": "Nov 20, 2025",
          "priority": "High"
        },
        {
          "title": "Statistics Assignment",
          "completed": true,
          "dueDate": "Nov 21, 2025",
          "priority": "Medium"
        },
        {
          "title": "Geometry Proofs Practice",
          "completed": false,
          "dueDate": "Nov 22, 2025",
          "priority": "Medium"
        },
      ]
    },
    {
      "name": "Physics",
      "progress": 88.0,
      "completed": 44,
      "total": 50,
      "color": 0xFF059669,
      "lastUpdated": "4 hours ago",
      "taskList": [
        {
          "title": "Thermodynamics Lab Report",
          "completed": true,
          "dueDate": "Nov 19, 2025",
          "priority": "High"
        },
        {
          "title": "Optics Problem Solving",
          "completed": false,
          "dueDate": "Nov 23, 2025",
          "priority": "Medium"
        },
      ]
    },
    {
      "name": "Chemistry",
      "progress": 85.0,
      "completed": 34,
      "total": 40,
      "color": 0xFF7C3AED,
      "lastUpdated": "1 day ago",
      "taskList": [
        {
          "title": "Organic Chemistry Quiz Prep",
          "completed": true,
          "dueDate": "Nov 18, 2025",
          "priority": "High"
        },
        {
          "title": "Chemical Bonding Review",
          "completed": false,
          "dueDate": "Nov 24, 2025",
          "priority": "Low"
        },
      ]
    },
    {
      "name": "Biology",
      "progress": 79.0,
      "completed": 31,
      "total": 39,
      "color": 0xFFD97706,
      "lastUpdated": "6 hours ago",
      "taskList": [
        {
          "title": "Cell Biology Worksheet",
          "completed": true,
          "dueDate": "Nov 20, 2025",
          "priority": "Medium"
        },
        {
          "title": "Genetics Problem Set",
          "completed": false,
          "dueDate": "Nov 25, 2025",
          "priority": "High"
        },
      ]
    },
    {
      "name": "English",
      "progress": 94.0,
      "completed": 47,
      "total": 50,
      "color": 0xFFDC2626,
      "lastUpdated": "3 hours ago",
      "taskList": [
        {
          "title": "Shakespeare Essay Final Draft",
          "completed": true,
          "dueDate": "Nov 19, 2025",
          "priority": "High"
        },
        {
          "title": "Poetry Analysis Assignment",
          "completed": true,
          "dueDate": "Nov 21, 2025",
          "priority": "Medium"
        },
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _refreshAnimation = CurvedAnimation(
      parent: _refreshController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _currentChartData {
    switch (_selectedPeriod) {
      case 'Monthly':
        return _monthlyData;
      case 'Subject':
        return _subjectData
            .map((subject) => {
                  "label": subject["name"],
                  "value": subject["progress"],
                  "completed": subject["completed"],
                  "total": subject["total"],
                  "tasks": subject["taskList"],
                })
            .toList();
      default:
        return _weeklyData;
    }
  }

  double get _averageCompletion {
    if (_currentChartData.isEmpty) return 0.0;
    final total = _currentChartData.fold<double>(
      0.0,
      (sum, item) => sum + (item["value"] as double),
    );
    return total / _currentChartData.length;
  }

  int get _totalTasksCompleted {
    return _currentChartData.fold<int>(
      0,
      (sum, item) => sum + ((item["completed"] as int?) ?? 0),
    );
  }

  int get _currentStreak {
    // Calculate streak based on consecutive days with >80% completion
    int streak = 0;
    for (final data in _weeklyData.reversed) {
      if ((data["value"] as double) >= 80.0) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  Future<void> _handleRefresh() async {
    setState(() => _isLoading = true);
    _refreshController.forward();

    // Simulate data refresh
    await Future.delayed(const Duration(milliseconds: 1500));

    _refreshController.reverse();
    setState(() => _isLoading = false);

    if (mounted) {
      HapticFeedback.lightImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Analytics updated successfully'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showDetailedModal(Map<String, dynamic> data, String type) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DetailedProgressModal(
        data: data,
        type: type,
      ),
    );
  }

  void _onBottomBarTap(int index) {
    setState(() => _currentBottomBarIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen())),
          icon: CustomIconWidget(
            iconName: 'account_circle',
            color: theme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        title: Text(
          'Progress Analytics',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _handleRefresh,
            icon: AnimatedBuilder(
              animation: _refreshAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _refreshAnimation.value * 2 * 3.14159,
                  child: CustomIconWidget(
                    iconName: 'refresh',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Metrics Cards Section
              Text(
                'Overview',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 2.h),
              _buildMetricsSection(theme),
              SizedBox(height: 4.h),

              // Progress Chart Section
              ProgressChartWidget(
                chartData: _currentChartData,
                selectedPeriod: _selectedPeriod,
                onPeriodChanged: (period) {
                  setState(() => _selectedPeriod = period);
                  HapticFeedback.selectionClick();
                },
              ),
              SizedBox(height: 4.h),

              if (_selectedPeriod != 'Subject') ...[
                SubjectProgressWidget(
                  subjectData: _subjectData,
                  onSubjectTap: (subject) => _showDetailedModal(subject, 'subject'),
                ),
                SizedBox(height: 4.h),
              ],

              // Tips Section
              _buildTipsSection(theme),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(
      //   currentIndex: _currentBottomBarIndex,
      //   onTap: _onBottomBarTap,
      //   variant: BottomBarVariant.standard,
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     HapticFeedback.lightImpact();
      //     Navigator.pushNamed(context, '/add-edit-task');
      //   },
      //   icon: CustomIconWidget(
      //     iconName: 'add',
      //     color: theme.colorScheme.onPrimary,
      //     size: 24,
      //   ),
      //   label: Text(
      //     'Add Task',
      //     style: theme.textTheme.labelLarge?.copyWith(
      //       color: theme.colorScheme.onPrimary,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildMetricsSection(ThemeData theme) {
    return Wrap(
      spacing: 3.w,
      runSpacing: 2.h,
      children: [
        MetricCardWidget(
          title: 'Tasks Completed',
          value: '$_totalTasksCompleted',
          iconName: 'check_circle',
          iconColor: theme.colorScheme.tertiary,
          onTap: () => _showDetailedModal({
            "label": "Total Tasks",
            "value": _averageCompletion,
            "completed": _totalTasksCompleted,
            "total":
                _currentChartData.fold<int>(0, (sum, item) => sum + ((item["total"] as int?) ?? 0)),
            "tasks": _currentChartData.expand((item) => (item["tasks"] as List?) ?? []).toList(),
          }, 'chart'),
        ),
        MetricCardWidget(
          title: 'Completion Rate',
          value: '${_averageCompletion.round()}%',
          iconName: 'analytics',
          iconColor: theme.colorScheme.primary,
          onTap: () => _showDetailedModal({
            "label": "Completion Rate",
            "value": _averageCompletion,
            "completed": _totalTasksCompleted,
            "total":
                _currentChartData.fold<int>(0, (sum, item) => sum + ((item["total"] as int?) ?? 0)),
            "tasks": [],
          }, 'chart'),
        ),
        MetricCardWidget(
          title: 'Current Streak',
          value: '$_currentStreak days',
          iconName: 'local_fire_department',
          iconColor: Colors.orange,
          onTap: () => _showDetailedModal({
            "label": "Study Streak",
            "value": _currentStreak.toDouble(),
            "completed": _currentStreak,
            "total": 7,
            "tasks": [],
          }, 'chart'),
        ),
        MetricCardWidget(
          title: 'Daily Average',
          value: '${(_totalTasksCompleted / 7).round()}',
          iconName: 'today',
          iconColor: theme.colorScheme.secondary,
          onTap: () => _showDetailedModal({
            "label": "Daily Average",
            "value": (_totalTasksCompleted / 7),
            "completed": _totalTasksCompleted,
            "total":
                _currentChartData.fold<int>(0, (sum, item) => sum + ((item["total"] as int?) ?? 0)),
            "tasks": [],
          }, 'chart'),
        ),
      ],
    );
  }

  Widget _buildTipsSection(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'lightbulb',
                color: theme.colorScheme.onPrimaryContainer,
                size: 24,
              ),
              SizedBox(width: 2.w),
              Text(
                'Study Tips',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _averageCompletion >= 90
              ? Text(
                  'Excellent work! You\'re maintaining a high completion rate. Keep up the momentum!',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                )
              : _averageCompletion >= 70
                  ? Text(
                      'Good progress! Try to complete tasks earlier in the day to improve your completion rate.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    )
                  : Text(
                      'Focus on building consistent study habits. Start with smaller, manageable tasks to build momentum.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
        ],
      ),
    );
  }
}
