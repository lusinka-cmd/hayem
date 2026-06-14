// lib/screens/game_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/haptic_feedback.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../data/puzzles.dart';
import '../widgets/tile_widget.dart';
import '../widgets/solved_row_widget.dart';
import '../widgets/lives_widget.dart';
import '../widgets/result_sheet.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late Puzzle puzzle;
  late List<Map<String, dynamic>> tiles; // {word, catIndex, isVisible}
  List<int> selected = [];
  List<Category> solved = [];
  List<String> guessHistory = [];
  int mistakes = 0;
  int streak = 0;
  bool isDone = false;
  String message = '';
  bool messageIsGood = false;
  Set<int> shakeTiles = {};

  @override
  void initState() {
    super.initState();
    puzzle = getTodayPuzzle();
    _buildTiles();
    _loadStreak();
  }

  void _buildTiles() {
    tiles = [];
    for (int i = 0; i < puzzle.categories.length; i++) {
      for (final word in puzzle.categories[i].words) {
        tiles.add({'word': word, 'catIndex': i, 'visible': true});
      }
    }
    tiles.shuffle(Random());
  }

  Future<void> _loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      streak = prefs.getInt('streak') ?? 0;
    });
  }

  Future<void> _saveStreak(bool won) async {
    final prefs = await SharedPreferences.getInstance();
    if (won) {
      await prefs.setInt('streak', streak + 1);
    } else {
      await prefs.setInt('streak', 0);
    }
  }

  void _toggleTile(int index) {
    if (isDone) return;
    if (!tiles[index]['visible']) return;
    HapticFeedback.selectionClick();
    setState(() {
      if (selected.contains(index)) {
        selected.remove(index);
      } else {
        if (selected.length < 4) {
          selected.add(index);
        }
      }
      message = '';
    });
  }

  void _clearSelection() {
    setState(() {
      selected.clear();
      message = '';
    });
  }

  void _shuffleTiles() {
    setState(() {
      final visible = tiles.where((t) => t['visible'] == true).toList()..shuffle(Random());
      int vi = 0;
      for (int i = 0; i < tiles.length; i++) {
        if (tiles[i]['visible']) tiles[i] = visible[vi++];
      }
      selected.clear();
    });
  }

  void _submitGuess() {
    if (selected.length != 4 || isDone) return;
    HapticFeedback.mediumImpact();

    final selectedCats = selected.map((i) => tiles[i]['catIndex'] as int).toList();
    final catCounts = <int, int>{};
    for (final c in selectedCats) catCounts[c] = (catCounts[c] ?? 0) + 1;

    final emojiRow = selected.map((i) {
      return puzzle.categories[tiles[i]['catIndex']].emoji;
    }).toList()
      ..sort();
    guessHistory.add(emojiRow.join());

    final allSame = selectedCats.every((c) => c == selectedCats.first);

    if (allSame) {
      HapticFeedback.heavyImpact();
      final catIndex = selectedCats.first;
      final cat = puzzle.categories[catIndex];
      setState(() {
        solved.add(cat);
        for (final i in selected) tiles[i]['visible'] = false;
        selected.clear();
        message = solved.length < 4 ? 'Ճի՜շտ է! Շарунакir' : '';
        messageIsGood = true;
      });

      if (solved.length == puzzle.categories.length) {
        setState(() => isDone = true);
        _saveStreak(true);
        Future.delayed(const Duration(milliseconds: 600), () {
          _showResult(true);
        });
      }
    } else {
      // Check one-away
      final maxCount = catCounts.values.reduce(max);
      setState(() {
        mistakes++;
        shakeTiles = selected.toSet();
        message = maxCount == 3 ? 'Meк бар sxal e... mot es!' : 'Prbotr norits';
        messageIsGood = false;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          shakeTiles.clear();
          selected.clear();
        });
      });

      if (mistakes >= 4) {
        setState(() => isDone = true);
        _saveStreak(false);
        Future.delayed(const Duration(milliseconds: 600), () {
          _showResult(false);
        });
      }
    }
  }

  void _showResult(bool won) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ResultSheet(
        won: won,
        puzzle: puzzle,
        guessHistory: guessHistory,
        mistakes: mistakes,
        streak: streak + (won ? 1 : 0),
        onShare: _shareResult,
      ),
    );
  }

  void _shareResult() {
    final won = solved.length == puzzle.categories.length;
    final text = 'Կаpеr #${puzzle.number}\n'
        '${won ? "✅ ${guessHistory.length}/4" : "❌"}\n\n'
        '${guessHistory.join("\n")}\n\n'
        'hayakankaper.app';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleTiles = tiles.asMap().entries.where((e) => e.value['visible'] == true).toList();

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Կаpеr', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500)),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: Text('#${puzzle.number}', style: theme.textTheme.bodySmall),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department, size: 18, color: Colors.deepOrange[400]),
                          const SizedBox(width: 3),
                          Text('$streak', style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            const SizedBox(height: 8),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '4 бар — 1 катeгория։ Yntrіr 4, hastатir.',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),

            // Lives
            LivesWidget(total: 4, remaining: 4 - mistakes),
            const SizedBox(height: 8),

            // Solved rows
            ...solved.map((cat) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
              child: SolvedRowWidget(category: cat),
            )),

            // Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1,
                  ),
                  itemCount: visibleTiles.length,
                  itemBuilder: (ctx, idx) {
                    final entry = visibleTiles[idx];
                    final tileIndex = entry.key;
                    final isSelected = selected.contains(tileIndex);
                    final isShaking = shakeTiles.contains(tileIndex);
                    return TileWidget(
                      word: entry.value['word'] as String,
                      isSelected: isSelected,
                      isShaking: isShaking,
                      onTap: () => _toggleTile(tileIndex),
                    );
                  },
                ),
              ),
            ),

            // Message
            SizedBox(
              height: 24,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: message.isNotEmpty
                    ? Text(
                        message,
                        key: ValueKey(message),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: messageIsGood ? const Color(0xFF1D9E75) : const Color(0xFFD85A30),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 6),

            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(label: 'Хаrnel', onTap: _shuffleTiles),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ActionButton(
                      label: 'Маkrel',
                      onTap: selected.isNotEmpty ? _clearSelection : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ActionButton(
                      label: 'Hastatel',
                      isPrimary: true,
                      onTap: selected.length == 4 ? _submitGuess : null,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isPrimary;

  const _ActionButton({required this.label, this.onTap, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: onTap == null ? 0.35 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: isPrimary ? const Color(0xFF3C3489) : theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isPrimary ? const Color(0xFF3C3489) : theme.dividerColor),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isPrimary ? const Color(0xFFCECBF6) : theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
