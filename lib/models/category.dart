// lib/models/category.dart

import 'package:flutter/material.dart';

class Category {
  final String name;
  final String hint;
  final List<String> words;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final String emoji;
  final int difficulty; // 0=easy, 1=medium, 2=hard, 3=tricky

  const Category({
    required this.name,
    required this.hint,
    required this.words,
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.emoji,
    required this.difficulty,
  });
}

class Puzzle {
  final int number;
  final List<Category> categories;

  const Puzzle({
    required this.number,
    required this.categories,
  });
}
