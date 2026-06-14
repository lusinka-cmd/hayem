// lib/widgets/tile_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TileWidget extends StatelessWidget {
  final String word;
  final bool isSelected;
  final bool isShaking;
  final VoidCallback onTap;

  const TileWidget({
    super.key,
    required this.word,
    required this.isSelected,
    required this.isShaking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget tile = GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEEDFE) : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF3C3489) : theme.dividerColor,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        child: Text(
          word,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: isSelected ? const Color(0xFF3C3489) : theme.colorScheme.onSurface,
            fontSize: word.length > 6 ? 11 : 13,
          ),
        ),
      ),
    );

    if (isShaking) {
      tile = tile
          .animate()
          .shake(duration: 400.ms, hz: 4, offset: const Offset(4, 0));
    }

    if (isSelected) {
      tile = tile.animate().scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), duration: 100.ms);
    }

    return tile;
  }
}
