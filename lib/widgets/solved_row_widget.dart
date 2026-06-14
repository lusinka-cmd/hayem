// lib/widgets/solved_row_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/category.dart';

class SolvedRowWidget extends StatelessWidget {
  final Category category;
  const SolvedRowWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: category.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: category.borderColor, width: 0.5),
      ),
      child: Column(
        children: [
          Text(
            category.name.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: category.textColor,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            category.words.join(' · '),
            style: TextStyle(fontSize: 13, color: category.textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.2, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}
