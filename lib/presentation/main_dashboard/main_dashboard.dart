import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:studyplanner/presentation/main_dashboard/widgets/greeting_header_widget.dart';
import 'package:studyplanner/presentation/main_dashboard/widgets/quick_add_bottom_sheet.dart';

import '../../core/app_export.dart';
import './widgets/recent_activity_widget.dart';
import './widgets/today_overview_widget.dart';

class MainDashboard extends StatefulWidget {
  final Function(int)? onNavigate;
  const MainDashboard({super.key, this.onNavigate});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Handle scroll position persistence if needed
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    // Haptic feedback for refresh
    HapticFeedback.lightImpact();

    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });

    // Show refresh completion feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dashboard updated successfully!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showQuickAddBottomSheet() {
    HapticFeedback.lightImpact();
    QuickAddBottomSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          color: AppTheme.lightTheme.colorScheme.primary,
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Greeting Header
              const SliverToBoxAdapter(
                child: GreetingHeaderWidget(),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    TodayOverviewWidget(
                      onNavigate: (v) {
                        widget.onNavigate?.call(v);
                      },
                    ),
                  ],
                ),
              ),

              // // Quick Actions
              // SliverToBoxAdapter(
              //   child: Column(
              //     children: [
              //       SizedBox(height: 3.h),
              //       const QuickActionsWidget(),
              //     ],
              //   ),
              // ),

              // Recent Activity
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 3.h),
                    const RecentActivityWidget(),
                    SizedBox(height: 10.h), // Extra space for FAB
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      // bottomNavigationBar: CustomBottomBar(
      //   currentIndex: _currentBottomNavIndex,
      //   onTap: _onBottomNavTap,
      //   variant: BottomBarVariant.floating,
      //   showLabels: true,
      // ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuickAddBottomSheet,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 6.0,
        child: CustomIconWidget(
          iconName: 'add',
          color: Colors.white,
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
