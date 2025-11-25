import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_widget.dart';

class EmptyNotesWidget extends StatelessWidget {
  final VoidCallback onCreateNote;
  final bool isSearching;
  final String searchQuery;

  const EmptyNotesWidget({
    super.key,
    required this.onCreateNote,
    this.isSearching = false,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isSearching) {
      return _buildSearchEmptyState(theme);
    }

    return _buildMainEmptyState(theme);
  }

  Widget _buildSearchEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search_off',
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            SizedBox(height: 3.h),
            Text(
              'No notes found',
              style: theme.textTheme.headlineSmall!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'No notes match "$searchQuery".\nTry a different search term.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'note_add',
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),

            SizedBox(height: 4.h),

            // Title
            Text(
              'Start Taking Notes',
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),

            SizedBox(height: 2.h),

            // Description
            Text(
              'Capture your thoughts, ideas, and study materials.\nOrganize them by subject for easy access.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),

            SizedBox(height: 4.h),

            // Create Note Button
            ElevatedButton.icon(
              onPressed: onCreateNote,
              icon: CustomIconWidget(
                iconName: 'add',
                size: 20,
                color: Colors.white,
              ),
              label: const Text('Create Your First Note'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 1.5.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 4.h),

            // Tips Section
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'lightbulb',
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Quick Tips',
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  _buildTipItem(
                    theme,
                    'Swipe right on notes to quickly edit them',
                    'swipe_right',
                  ),
                  SizedBox(height: 1.h),
                  _buildTipItem(
                    theme,
                    'Use subjects to categorize your notes',
                    'category',
                  ),
                  SizedBox(height: 1.h),
                  _buildTipItem(
                    theme,
                    'Search through all your notes instantly',
                    'search',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(ThemeData theme, String text, String iconName) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
