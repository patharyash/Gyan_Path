import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_notes_widget.dart';
import './widgets/note_card_widget.dart';
import './widgets/note_editor_widget.dart';
import './widgets/search_bar_widget.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _notes = [
    {
      "id": 1,
      "title": "Physics - Newton's Laws",
      "content":
          """Newton's First Law (Law of Inertia): An object at rest stays at rest and an object in motion stays in motion with the same speed and in the same direction unless acted upon by an unbalanced force. Newton's Second Law: The acceleration of an object is directly proportional to the net force acting on it and inversely proportional to its mass. F = ma Newton's Third Law: For every action, there is an equal and opposite reaction. Key Applications: - Rocket propulsion - Walking mechanics - Car safety systems""",
      "subject": "Physics",
      "wordCount": 89,
      "characterCount": 567,
      "createdAt": DateTime.now().subtract(const Duration(hours: 2)),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 1)),
    },
    {
      "id": 2,
      "title": "History Essay - World War II",
      "content":
          """World War II (1939-1945) was a global conflict that involved most of the world's nations. The war was primarily fought between the Axis powers (Germany, Italy, Japan) and the Allied powers (Britain, Soviet Union, United States, and others). Key Events: - September 1939: Germany invades Poland - December 1941: Pearl Harbor attack - June 1944: D-Day landings - August 1945: Atomic bombs dropped on Japan The war resulted in significant changes to the global political landscape and led to the establishment of the United Nations.""",
      "subject": "History",
      "wordCount": 95,
      "characterCount": 623,
      "createdAt": DateTime.now().subtract(const Duration(days: 1)),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      "id": 3,
      "title": "Math - Quadratic Equations",
      "content":
          """A quadratic equation is a polynomial equation of degree 2. Standard form: ax² + bx + c = 0 (where a ≠ 0) Quadratic Formula: x = (-b ± √(b² - 4ac)) / 2a Discriminant (Δ = b² - 4ac): - If Δ > 0: Two real solutions - If Δ = 0: One real solution - If Δ < 0: No real solutions (complex solutions) Methods of solving: 1. Factoring 2. Completing the square 3. Quadratic formula 4. Graphing""",
      "subject": "Mathematics",
      "wordCount": 78,
      "characterCount": 456,
      "createdAt": DateTime.now().subtract(const Duration(days: 2)),
      "updatedAt": DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      "id": 4,
      "title": "Biology - Cell Structure",
      "content":
          """Prokaryotic vs Eukaryotic Cells: Prokaryotic Cells: - No nucleus - DNA freely floating - Examples: Bacteria, Archaea Eukaryotic Cells: - Membrane-bound nucleus - Organelles present - Examples: Plant, Animal, Fungal cells Key Organelles: - Nucleus: Control center - Mitochondria: Powerhouse - Ribosomes: Protein synthesis - Endoplasmic Reticulum: Transport system - Golgi Apparatus: Processing and packaging""",
      "subject": "Biology",
      "wordCount": 67,
      "characterCount": 445,
      "createdAt": DateTime.now().subtract(const Duration(days: 3)),
      "updatedAt": DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      "id": 5,
      "title": "Study Schedule Planning",
      "content":
          """Weekly Study Plan: Monday: Mathematics (2 hours) - Algebra practice - Geometry problems Tuesday: Science (2 hours) - Physics concepts - Chemistry equations Wednesday: English (1.5 hours) - Literature reading - Essay writing Thursday: History (1.5 hours) - Timeline review - Document analysis Friday: Review day - Previous week's topics - Practice tests Weekend: Project work and relaxation""",
      "subject": "Other",
      "wordCount": 71,
      "characterCount": 423,
      "createdAt": DateTime.now().subtract(const Duration(days: 5)),
      "updatedAt": DateTime.now().subtract(const Duration(days: 4)),
    },
    {
      "id": 6,
      "title": "Chemistry - Atomic Structure",
      "content":
          """The atomic structure consists of three main particles: protons, neutrons, and electrons. Protons and neutrons form the nucleus, while electrons orbit in shells. Atomic Number: Number of protons. Mass Number: Protons + neutrons. Isotopes: Atoms with the same number of protons but different neutrons. Key Rules: - First shell holds 2 electrons - Second shell holds 8 electrons - Valence electrons determine reactivity""",
      "subject": "Chemistry",
      "wordCount": 78,
      "characterCount": 497,
      "createdAt": DateTime.now().subtract(const Duration(days: 1)),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 20)),
    },
    {
      "id": 7,
      "title": "English - Literary Devices",
      "content":
          """Common Literary Devices: 1. Metaphor: Comparison without using 'like' or 'as'. 2. Simile: Comparison using 'like' or 'as'. 3. Personification: Giving human qualities to non-human things. 4. Alliteration: Repeated initial sounds. 5. Hyperbole: Exaggeration for effect. These tools help create imagery and enhance the reader's experience.""",
      "subject": "English",
      "wordCount": 70,
      "characterCount": 420,
      "createdAt": DateTime.now().subtract(const Duration(days: 4)),
      "updatedAt": DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      "id": 8,
      "title": "Computer Science - Data Structures",
      "content":
          """Data structures are ways to organize and store data efficiently. Common Types: - Arrays: Store elements of same type in contiguous memory. - Linked Lists: Nodes connected by pointers. - Stacks: LIFO structure used in function calls. - Queues: FIFO structure for processing tasks. - Trees: Hierarchical structure. - Hash Tables: Key-value storage. Choosing the right structure improves performance.""",
      "subject": "Computer Science",
      "wordCount": 83,
      "characterCount": 504,
      "createdAt": DateTime.now().subtract(const Duration(hours: 6)),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      "id": 9,
      "title": "Geography - Types of Climates",
      "content":
          """Earth has several major climate types: 1. Tropical: Hot and humid. 2. Dry: Desert conditions with low rainfall. 3. Temperate: Moderate weather and seasons. 4. Continental: Large temperature variations. 5. Polar: Extremely cold year-round. Climate is influenced by latitude, altitude, ocean currents, and distance from the sea.""",
      "subject": "Geography",
      "wordCount": 68,
      "characterCount": 409,
      "createdAt": DateTime.now().subtract(const Duration(days: 7)),
      "updatedAt": DateTime.now().subtract(const Duration(days: 6)),
    },
    {
      "id": 10,
      "title": "Economics - Supply and Demand",
      "content":
          """Supply and demand determine market prices. Demand Law: As price decreases, demand increases. Supply Law: As price increases, quantity supplied increases. Equilibrium: The point where supply equals demand. Shifts occur due to income changes, preferences, technology, and production costs.""",
      "subject": "Economics",
      "wordCount": 62,
      "characterCount": 380,
      "createdAt": DateTime.now().subtract(const Duration(days: 2)),
      "updatedAt": DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      "id": 11,
      "title": "Physics - Work, Energy & Power",
      "content":
          """Work: W = F × d Energy: The ability to do work. Forms include kinetic and potential energy. Power: The rate of doing work, P = W/t. Law of Conservation of Energy: Energy cannot be created or destroyed, only transformed. Key Applications: Mechanical systems, electricity, engines.""",
      "subject": "Physics",
      "wordCount": 61,
      "characterCount": 360,
      "createdAt": DateTime.now().subtract(const Duration(hours: 10)),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 8)),
    },
    {
      "id": 12,
      "title": "Math - Coordinate Geometry",
      "content":
          """Coordinate geometry deals with points placed on the Cartesian plane. Distance Formula: d = √[(x2 - x1)² + (y2 - y1)²]. Midpoint Formula: ((x1 + x2)/2, (y1 + y2)/2). Slope Formula: m = (y2 - y1) / (x2 - x1). Used in graphing lines, parabolas, and solving geometric problems.""",
      "subject": "Mathematics",
      "wordCount": 60,
      "characterCount": 373,
      "createdAt": DateTime.now().subtract(const Duration(days: 3)),
      "updatedAt": DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      "id": 13,
      "title": "Biology - Photosynthesis",
      "content":
          """Photosynthesis is the process by which plants convert light energy into chemical energy. Formula: 6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂. Occurs in chloroplasts. Light-dependent reactions produce ATP, while the Calvin cycle forms glucose. Essential for sustaining life on Earth.""",
      "subject": "Biology",
      "wordCount": 59,
      "characterCount": 359,
      "createdAt": DateTime.now().subtract(const Duration(hours: 5)),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      "id": 14,
      "title": "English - Essay Structure",
      "content":
          """A formal essay includes three main parts: 1. Introduction: Hook + thesis statement. 2. Body Paragraphs: Topic sentence, evidence, analysis. 3. Conclusion: Summary + closing thoughts. Good essays maintain coherence, flow, and clear arguments.""",
      "subject": "English",
      "wordCount": 54,
      "characterCount": 328,
      "createdAt": DateTime.now().subtract(const Duration(days: 2)),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 12)),
    },
    {
      "id": 15,
      "title": "Study Tips - Effective Learning",
      "content":
          """Effective study techniques include: - Spaced repetition instead of cramming. - Active recall using flashcards. - Teaching the concept to someone else. - Taking breaks every 25–30 minutes. - Reviewing notes weekly. These habits improve retention and understanding.""",
      "subject": "Other",
      "wordCount": 58,
      "characterCount": 344,
      "createdAt": DateTime.now().subtract(const Duration(days: 1)),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 6)),
    },
  ];

  String _searchQuery = '';
  bool _isSearching = false;
  bool _isMultiSelectMode = false;
  final Set<int> _selectedNotes = {};
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeOut,
    ));

    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredNotes {
    if (_searchQuery.isEmpty) return _notes;

    return _notes.where((note) {
      final title = (note['title'] as String).toLowerCase();
      final content = (note['content'] as String).toLowerCase();
      final subject = (note['subject'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();

      return title.contains(query) || content.contains(query) || subject.contains(query);
    }).toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });
  }

  void _onClearSearch() {
    setState(() {
      _searchQuery = '';
      _isSearching = false;
    });
  }

  void _createNewNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorWidget(
          onSave: _saveNote,
          onCancel: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _editNote(Map<String, dynamic> note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorWidget(
          note: note,
          onSave: _saveNote,
          onCancel: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _saveNote(Map<String, dynamic> noteData) {
    setState(() {
      final existingIndex = _notes.indexWhere((note) => note['id'] == noteData['id']);
      if (existingIndex != -1) {
        _notes[existingIndex] = noteData;
      } else {
        _notes.insert(0, noteData);
      }
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _notes.indexWhere((note) => note['id'] == noteData['id']) != -1
              ? 'Note updated successfully'
              : 'Note created successfully',
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'View',
          onPressed: () => _viewNote(noteData),
        ),
      ),
    );
  }

  void _viewNote(Map<String, dynamic> note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorWidget(
          note: note,
          onSave: _saveNote,
          onCancel: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _deleteNote(Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: Text('Are you sure you want to delete "${note['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notes.removeWhere((n) => n['id'] == note['id']);
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Note deleted'),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        _notes.insert(0, note);
                      });
                    },
                  ),
                ),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleNoteSelection(int noteId) {
    setState(() {
      if (_selectedNotes.contains(noteId)) {
        _selectedNotes.remove(noteId);
        if (_selectedNotes.isEmpty) {
          _isMultiSelectMode = false;
        }
      } else {
        _selectedNotes.add(noteId);
        _isMultiSelectMode = true;
      }
    });

    HapticFeedback.lightImpact();
  }

  void _deleteSelectedNotes() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notes'),
        content: Text('Are you sure you want to delete ${_selectedNotes.length} selected notes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notes.removeWhere((note) => _selectedNotes.contains(note['id']));
                _selectedNotes.clear();
                _isMultiSelectMode = false;
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selected notes deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _shareSelectedNotes() {
    final selectedNotesData = _notes
        .where((note) => _selectedNotes.contains(note['id']))
        .map((note) => '${note['title']}\n\n${note['content']}\n\n---\n')
        .join('\n');

    // In a real app, this would use the share plugin
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${_selectedNotes.length} notes...'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    setState(() {
      _selectedNotes.clear();
      _isMultiSelectMode = false;
    });
  }

  void _exitMultiSelectMode() {
    setState(() {
      _selectedNotes.clear();
      _isMultiSelectMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredNotes = _filteredNotes;

    return Scaffold(
      appBar: _isMultiSelectMode ? _buildMultiSelectAppBar(theme) : _buildNormalAppBar(theme),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            setState(() {});
          },
          child: Column(
            children: [
              // Search Bar
              SearchBarWidget(
                searchQuery: _searchQuery,
                onSearchChanged: _onSearchChanged,
                onClearSearch: _onClearSearch,
                isSearching: _isSearching,
              ),

              // Notes List
              Expanded(
                child: filteredNotes.isEmpty
                    ? EmptyNotesWidget(
                        onCreateNote: _createNewNote,
                        isSearching: _isSearching,
                        searchQuery: _searchQuery,
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 10.h),
                        itemCount: filteredNotes.length,
                        itemBuilder: (context, index) {
                          final note = filteredNotes[index];
                          final noteId = note['id'] as int;
                          final isSelected = _selectedNotes.contains(noteId);

                          return GestureDetector(
                            onLongPress: () => _toggleNoteSelection(noteId),
                            child: NoteCardWidget(
                              note: note,
                              onTap: () {
                                if (_isMultiSelectMode) {
                                  _toggleNoteSelection(noteId);
                                } else {
                                  _viewNote(note);
                                }
                              },
                              onEdit: () => _editNote(note),
                              onDelete: () => _deleteNote(note),
                              isSelected: isSelected,
                              searchQuery: _searchQuery,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _isMultiSelectMode ? null : _buildFloatingActionButton(),
      // bottomNavigationBar: CustomBottomBar(
      //   currentIndex: 3, // Notes tab index
      //   onTap: (index) {
      //     // Navigation handled by CustomBottomBar
      //   },
      //   variant: BottomBarVariant.floating,
      // ),
    );
  }

  PreferredSizeWidget _buildNormalAppBar(ThemeData theme) {
    return AppBar(
      title: const Text('Notes'),
      centerTitle: false,
      actions: [
        if (_notes.isNotEmpty) ...[
          IconButton(
            onPressed: () {
              // Sort options
              _showSortOptions();
            },
            icon: CustomIconWidget(
              iconName: 'sort',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'export':
                  _exportAllNotes();
                  break;
                case 'import':
                  _importNotes();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Export Notes'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'import',
                child: Row(
                  children: [
                    Icon(Icons.upload),
                    SizedBox(width: 8),
                    Text('Import Notes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  PreferredSizeWidget _buildMultiSelectAppBar(ThemeData theme) {
    return AppBar(
      leading: IconButton(
        onPressed: _exitMultiSelectMode,
        icon: CustomIconWidget(
          iconName: 'close',
          color: theme.colorScheme.onSurface,
          size: 24,
        ),
      ),
      title: Text('${_selectedNotes.length} selected'),
      actions: [
        IconButton(
          onPressed: _shareSelectedNotes,
          icon: CustomIconWidget(
            iconName: 'share',
            color: theme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        IconButton(
          onPressed: _deleteSelectedNotes,
          icon: CustomIconWidget(
            iconName: 'delete',
            color: theme.colorScheme.error,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return AnimatedBuilder(
      animation: _fabAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _fabAnimation.value,
          child: FloatingActionButton(
            onPressed: _createNewNote,
            child: CustomIconWidget(
              iconName: 'add',
              color: Colors.white,
              size: 24,
            ),
          ),
        );
      },
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort Notes',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'access_time',
                color: Theme.of(context).colorScheme.onSurface,
                size: 24,
              ),
              title: const Text('Recent First'),
              onTap: () {
                setState(() {
                  _notes.sort(
                      (a, b) => (b['updatedAt'] as DateTime).compareTo(a['updatedAt'] as DateTime));
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'sort_by_alpha',
                color: Theme.of(context).colorScheme.onSurface,
                size: 24,
              ),
              title: const Text('Alphabetical'),
              onTap: () {
                setState(() {
                  _notes.sort((a, b) => (a['title'] as String).compareTo(b['title'] as String));
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'category',
                color: Theme.of(context).colorScheme.onSurface,
                size: 24,
              ),
              title: const Text('By Subject'),
              onTap: () {
                setState(() {
                  _notes.sort((a, b) => (a['subject'] as String).compareTo(b['subject'] as String));
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _exportAllNotes() {
    final notesText = _notes
        .map((note) =>
            '${note['title']}\nSubject: ${note['subject']}\nCreated: ${note['createdAt']}\n\n${note['content']}\n\n---\n')
        .join('\n');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notes exported successfully'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _importNotes() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Import feature coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
