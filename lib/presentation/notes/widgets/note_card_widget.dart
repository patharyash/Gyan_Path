import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NoteCardWidget extends StatelessWidget {
  final Map<String, dynamic> note;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isSelected;
  final String searchQuery;

  const NoteCardWidget({
    super.key,
    required this.note,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    this.isSelected = false,
    this.searchQuery = '',
  });

  String _highlightSearchText(String text, String query) {
    if (query.isEmpty) return text;
    return text.replaceAllMapped(
      RegExp(query, caseSensitive: false),
      (match) => '**${match.group(0)}**',
    );
  }

  Widget _buildHighlightedText(String text, TextStyle style) {
    if (searchQuery.isEmpty) {
      return Text(text, style: style);
    }

    final parts = text.split(RegExp(searchQuery, caseSensitive: false));
    final matches = RegExp(searchQuery, caseSensitive: false).allMatches(text);

    List<TextSpan> spans = [];
    int index = 0;

    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(text: parts[i], style: style));
      }

      if (i < matches.length) {
        spans.add(TextSpan(
          text: matches.elementAt(i).group(0),
          style: style.copyWith(
            backgroundColor: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
            fontWeight: FontWeight.w600,
          ),
        ));
      }
    }

    return RichText(text: TextSpan(children: spans));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = (note['title'] as String?) ?? 'Untitled Note';
    final content = (note['content'] as String?) ?? '';
    final subject = (note['subject'] as String?) ?? '';
    final createdAt = note['createdAt'] as DateTime? ?? DateTime.now();
    final wordCount = (note['wordCount'] as int?) ?? 0;

    // Extract preview text (first 2-3 lines)
    final previewLines = content.split('\n').take(3).join('\n');
    final preview =
        previewLines.length > 100 ? '${previewLines.substring(0, 100)}...' : previewLines;

    return Slidable(
      key: ValueKey(note['id']),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: AppTheme.lightTheme.colorScheme.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Card(
        elevation: isSelected ? 4 : 2,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side:
              isSelected ? BorderSide(color: theme.colorScheme.primary, width: 2) : BorderSide.none,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and subject tag
                Row(
                  children: [
                    Expanded(
                      child: _buildHighlightedText(
                        title,
                        theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (subject.isNotEmpty) ...[
                      SizedBox(width: 2.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          subject,
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                if (preview.isNotEmpty) ...[
                  SizedBox(height: 1.h),
                  _buildHighlightedText(
                    preview,
                    theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],

                SizedBox(height: 2.h),

                // Footer with timestamp and word count
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'access_time',
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      _formatDate(createdAt),
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    if (wordCount > 0) ...[
                      CustomIconWidget(
                        iconName: 'text_fields',
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '$wordCount words',
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
