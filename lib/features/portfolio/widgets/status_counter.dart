import 'package:flutter/material.dart';

Widget statusCounter(
  BuildContext context,
  String count,
  String label,
  IconData icon,
) {
  return SliverToBoxAdapter(
    child: Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        SelectableText(
          count,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SelectableText(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
