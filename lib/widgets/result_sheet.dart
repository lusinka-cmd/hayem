// lib/widgets/result_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/category.dart';

class ResultSheet extends StatelessWidget {
  final bool won;
  final dynamic puzzle;
  final List<String> guessHistory;
  final int mistakes;
  final int streak;
  final VoidCallback onShare;

  const ResultSheet({
    super.key,
    required this.won,
    required this.puzzle,
    required this.guessHistory,
    required this.mistakes,
    required this.streak,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40, height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Text(
            won ? 'Բоlorı gtiр! 🎉' : 'Аvаgh...',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ).animate().fadeIn(duration: 400.ms).scale(),
          const SizedBox(height: 4),

          Text(
            won
                ? mistakes == 0 ? 'Аntеri! 0 sxal' : '$mistakes sxalov'
                : 'Vahъ nоr katеgorianer kan',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          // Emoji grid
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(
              children: guessHistory.map((row) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(row, style: const TextStyle(fontSize: 22, letterSpacing: 4)),
                );
              }).toList(),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
          const SizedBox(height: 16),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatBox(label: 'Streak', value: '$streak 🔥'),
              _StatBox(label: 'Sxalner', value: '$mistakes'),
              _StatBox(label: 'Ev′r', value: '#${puzzle.number}'),
            ],
          ),
          const SizedBox(height: 20),

          // Share button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onShare,
              icon: const Icon(Icons.share_rounded, size: 18),
              label: const Text('Kisvel ardyunkov'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3C3489),
                foregroundColor: const Color(0xFFCECBF6),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
          const SizedBox(height: 8),

          Text(
            'Vahъ nоr xаghard',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
