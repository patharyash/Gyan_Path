import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class NoteEditorWidget extends StatefulWidget {
  final Map<String, dynamic>? note;
  final Function(Map<String, dynamic>) onSave;
  final VoidCallback onCancel;

  const NoteEditorWidget({
    super.key,
    this.note,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<NoteEditorWidget> createState() => _NoteEditorWidgetState();
}

class _NoteEditorWidgetState extends State<NoteEditorWidget> {
  late TextEditingController _titleController;
  late TextEditingController _subjectController;
  late QuillController _contentController;
  late FocusNode _titleFocusNode;
  late FocusNode _contentFocusNode;
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();

  bool _hasUnsavedChanges = false;
  int _wordCount = 0;
  int _characterCount = 0;
  DateTime? _lastAutoSave;

  final List<String> _subjects = [
    'Mathematics',
    'Science',
    'English',
    'History',
    'Geography',
    'Physics',
    'Chemistry',
    'Biology',
    'Computer Science',
    'Art',
    'Music',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupAutoSave();
  }

  void _initializeControllers() {
    _titleController = TextEditingController(
      text: widget.note?['title'] ?? '',
    );
    _subjectController = TextEditingController(
      text: widget.note?['subject'] ?? '',
    );

    final content = widget.note?['content'] ?? '';
    _contentController = QuillController.basic();
    if (content.isNotEmpty) {
      _contentController.document = Document()..insert(0, content);
    }

    _titleFocusNode = FocusNode();
    _contentFocusNode = FocusNode();

    // Add listeners for change detection
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onContentChanged);

    _updateWordCount();

    // Auto-focus title for new notes
    if (widget.note == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _titleFocusNode.requestFocus();
      });
    }
  }

  void _setupAutoSave() {
    // Auto-save every 30 seconds
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted && _hasUnsavedChanges) {
        _autoSave();
        _setupAutoSave();
      }
    });
  }

  void _onTextChanged() {
    setState(() {
      _hasUnsavedChanges = true;
    });
    _updateWordCount();
  }

  void _onContentChanged() {
    setState(() {
      _hasUnsavedChanges = true;
    });
    _updateWordCount();
  }

  void _updateWordCount() {
    final content = _contentController.document.toPlainText();
    final words = content.trim().isEmpty ? 0 : content.trim().split(RegExp(r'\s+')).length;
    setState(() {
      _wordCount = words;
      _characterCount = content.length;
    });
  }

  void _autoSave() {
    if (!_hasUnsavedChanges) return;

    final noteData = _buildNoteData();
    // In a real app, this would save to local storage
    setState(() {
      _lastAutoSave = DateTime.now();
      _hasUnsavedChanges = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Auto-saved'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Map<String, dynamic> _buildNoteData() {
    final content = _contentController.document.toPlainText();
    return {
      'id': widget.note?['id'] ?? DateTime.now().millisecondsSinceEpoch,
      'title':
          _titleController.text.trim().isEmpty ? 'Untitled Note' : _titleController.text.trim(),
      'content': content,
      'subject': _subjectController.text.trim(),
      'wordCount': _wordCount,
      'characterCount': _characterCount,
      'createdAt': widget.note?['createdAt'] ?? DateTime.now(),
      'updatedAt': DateTime.now(),
    };
  }

  void _saveNote() {
    final noteData = _buildNoteData();
    widget.onSave(noteData);
  }

  void _showDiscardDialog() {
    if (!_hasUnsavedChanges) {
      widget.onCancel();
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Changes?'),
        content: const Text('You have unsaved changes. Are you sure you want to discard them?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onCancel();
            },
            child: Text(
              'Discard',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        leading: IconButton(
          onPressed: _showDiscardDialog,
          icon: CustomIconWidget(
            iconName: 'close',
            color: theme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveNote,
            child: Text(
              'Save',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Column(
              children: [
                // Title Field
                TextField(
                  controller: _titleController,
                  focusNode: _titleFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Note title...',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintStyle: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),

                SizedBox(height: 2.h),

                // Subject Dropdown
                DropdownButtonFormField<String>(
                  value: _subjectController.text.isEmpty ? null : _subjectController.text,
                  decoration: InputDecoration(
                    labelText: 'Subject (Optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                  ),
                  items: _subjects
                      .map((subject) => DropdownMenuItem(
                            value: subject,
                            child: Text(subject),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _subjectController.text = value ?? '';
                    _onTextChanged();
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20), top: Radius.circular(5)),
                      child: Container(
                        color: theme.colorScheme.surface,
                        child: QuillEditor(
                          controller: _contentController,
                          scrollController: _scrollController,
                          focusNode: _focusNode,
                          config: QuillEditorConfig(
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                            placeholder: 'Start writing your note...',
                            paintCursorAboveText: true,
                            scrollPhysics: const BouncingScrollPhysics(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Status Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                if (_hasUnsavedChanges) ...[
                  CustomIconWidget(
                    iconName: 'circle',
                    size: 8,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Unsaved changes',
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ] else if (_lastAutoSave != null) ...[
                  CustomIconWidget(
                    iconName: 'check_circle',
                    size: 16,
                    color: theme.colorScheme.tertiary,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Auto-saved',
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  '$_wordCount words • $_characterCount characters',
                  style: theme.textTheme.labelSmall!.copyWith(
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
}
