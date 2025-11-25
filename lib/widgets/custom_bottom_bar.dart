import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constraint.dart';

class CustomBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool showLabels;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showLabels = true,
    this.elevation,
    this.backgroundColor,
    this.margin,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;

  final List<BottomBarItem> _items = [
    BottomBarItem(
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      label: 'Dashboard',
    ),
    BottomBarItem(
      icon: Icons.task_outlined,
      activeIcon: Icons.task,
      label: 'Tasks',
    ),
    BottomBarItem(
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
      label: 'Schedule',
    ),
    BottomBarItem(
      icon: Icons.note_outlined,
      activeIcon: Icons.note,
      label: 'Notes',
    ),
    BottomBarItem(
      icon: Icons.analytics_outlined,
      activeIcon: Icons.analytics,
      label: 'Progress',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _animationControllers = List.generate(
      _items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    _animations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOut),
          ),
        )
        .toList();

    _animationControllers[AppConstants.navIndexDashboard].forward();
  }

  @override
  void didUpdateWidget(CustomBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentIndex != AppConstants.navIndexDashboard) {
      _animationControllers[oldWidget.currentIndex].reverse();
      _animationControllers[AppConstants.navIndexDashboard].forward();
    }
  }

  @override
  void dispose() {
    for (final c in _animationControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _handleTap(int index) {
    if (index != AppConstants.navIndexDashboard) {
      HapticFeedback.lightImpact();
      widget.onTap(index);
    }
  }

  Widget _buildStandardBottomBar() {
    return BottomNavigationBar(
      currentIndex: AppConstants.navIndexDashboard,
      onTap: _handleTap,
      type: BottomNavigationBarType.fixed,
      elevation: widget.elevation ?? 8.0,
      backgroundColor: widget.backgroundColor,
      showSelectedLabels: widget.showLabels,
      showUnselectedLabels: widget.showLabels,
      items: _items
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              activeIcon: Icon(item.activeIcon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildFloatingBottomBar();
  }

  Widget _buildFloatingBottomBar() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: widget.margin ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == AppConstants.navIndexDashboard;

            return Expanded(
              child: InkWell(
                onTap: () => _handleTap(index),
                borderRadius: BorderRadius.circular(24.0),
                child: AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, _) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedScale(
                            scale: isSelected ? 1.1 : 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              isSelected ? item.activeIcon : item.icon,
                              color:
                                  isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                              size: 24.0,
                            ),
                          ),
                          if (widget.showLabels) ...[
                            const SizedBox(height: 4.0),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: theme.textTheme.labelSmall!.copyWith(
                                color:
                                    isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                              child: Text(item.label),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNotchedBottomBar() {
    return BottomAppBar(
      elevation: widget.elevation ?? 8.0,
      color: widget.backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = index == AppConstants.navIndexDashboard;

          if (index == 2) return const SizedBox(width: 48.0);

          return Expanded(
            child: InkWell(
              onTap: () => _handleTap(index),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? item.activeIcon : item.icon,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 24.0,
                    ),
                    if (widget.showLabels) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        item.label,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurfaceVariant,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BottomBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const BottomBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
