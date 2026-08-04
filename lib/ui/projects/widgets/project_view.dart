import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:iux/ui/core/constants/spacing.dart';

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
    final theme = FTheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: theme.colors.primary, width: 4.0),
        ),
      ),
      child: Row(
        spacing: Spacing.md,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  name,
                  style: theme.typography.body.md.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  path,
                  style: theme.typography.body.md.copyWith(
                    color: theme.colors.border,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          FButton(
            variant: .destructive,
            onPress: onDelete,
            child: const Text('delete'),
          ),
        ],
      ),
    );
  }
}
