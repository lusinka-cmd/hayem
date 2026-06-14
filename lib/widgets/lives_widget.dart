// lib/widgets/lives_widget.dart

import 'package:flutter/material.dart';

class LivesWidget extends StatelessWidget {
  final int total;
  final int remaining;
  const LivesWidget({super.key, required this.total, required this.remaining});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Փорձ՝ ', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(width: 4),
        ...List.generate(total, (i) {
          final active = i < remaining;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 11,
            height: 11,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? const Color(0xFF3C3489) : Theme.of(context).dividerColor,
            ),
          );
        }),
      ],
    );
  }
}
