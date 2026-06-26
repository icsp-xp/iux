import 'package:flutter/material.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';
import 'package:iux/ui/core/ui/button/button.dart';

class ProjectView extends StatelessWidget {
  final String name;
  final String path;
  // final VoidCallback onChangePath;
  final VoidCallback? onDelete;

  const ProjectView({
    required this.name,
    required this.path,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typography = ThemeProvider.of(context).typography;
    final colorScheme = ThemeProvider.of(context).colorScheme;
    final spacing = ThemeProvider.of(context).spacing;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: colorScheme.primary, width: 4.0),
        ),
      ),
      child: Row(
        spacing: spacing.medium,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
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
          ),
          Button.error(onPressed: onDelete, child: const Text('delete')),
        ],
      ),
    );
  }
}
