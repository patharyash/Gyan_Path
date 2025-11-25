import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class ProgressChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> chartData;
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const ProgressChartWidget({
    super.key,
    required this.chartData,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  State<ProgressChartWidget> createState() => _ProgressChartWidgetState();
}

class _ProgressChartWidgetState extends State<ProgressChartWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Overview',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 1.h),
          _buildPeriodSelector(theme),
          SizedBox(height: 3.h),
          SizedBox(
            height: 30.h,
            child: widget.chartData.isEmpty ? _buildEmptyState(theme) : _buildChart(theme),
          ),
          SizedBox(height: 2.h),
          _buildLegend(theme),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(ThemeData theme) {
    final periods = ['Weekly', 'Monthly', 'Subject'];

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: periods.map((period) {
          final isSelected = widget.selectedPeriod == period;
          return GestureDetector(
            onTap: () => widget.onPeriodChanged(period),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                period,
                style: theme.textTheme.labelMedium?.copyWith(
                  color:
                      isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChart(ThemeData theme) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Semantics(
          label:
              "Progress Analytics Bar Chart showing ${widget.selectedPeriod.toLowerCase()} completion data",
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 100,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: theme.colorScheme.inverseSurface,
                  tooltipRoundedRadius: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final data = widget.chartData[groupIndex];
                    return BarTooltipItem(
                      '${data["label"]}\n${rod.toY.round()}% completed',
                      theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onInverseSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        barTouchResponse == null ||
                        barTouchResponse.spot == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                  });
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < widget.chartData.length) {
                        return Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Text(
                            widget.chartData[index]["label"] as String,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 30,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 25,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return Text(
                        '${value.toInt()}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                    reservedSize: 40,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: widget.chartData.asMap().entries.map((entry) {
                final index = entry.key;
                final data = entry.value;
                final isTouched = index == touchedIndex;

                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: (data["value"] as double) * _animation.value,
                      color: isTouched
                          ? theme.colorScheme.primary.withValues(alpha: 0.8)
                          : theme.colorScheme.primary,
                      width: isTouched ? 22 : 18,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 100,
                        color: theme.colorScheme.surfaceContainerHighest,
                      ),
                    ),
                  ],
                );
              }).toList(),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 25,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'analytics',
            color: theme.colorScheme.onSurfaceVariant,
            size: 48,
          ),
          SizedBox(height: 2.h),
          Text(
            'No Progress Data Yet',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Complete some tasks to see your progress analytics',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          'Completion Rate',
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
