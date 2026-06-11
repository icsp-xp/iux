import 'package:flutter/material.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';

class Project extends StatelessWidget {
  final String name;
  final String path;
  // final VoidCallback onChangePath;
  // final VoidCallback onDelete;

  const Project({required this.name, required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    final typography = ThemeProvider.of(context).typography;
    final colorScheme = ThemeProvider.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: colorScheme.primary, width: 4.0),
        ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                name,
                style: typography.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                path,
                style: typography.bodyMedium.copyWith(
                  color: colorScheme.outline,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
