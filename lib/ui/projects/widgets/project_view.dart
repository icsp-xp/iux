import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:iux/ui/core/theme/spacing.dart';
import 'package:iux/ui/core/ui/confirm_dialog.dart';

class ProjectView extends StatelessWidget {
  final String name;
  final String path;
  // final VoidCallback onChangePath;
  final VoidCallback onDelete;

  const ProjectView({
    required this.name,
    required this.path,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.colors.card,
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Row(
        spacing: theme.spacing.sm,
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
          FButton.icon(
            variant: .destructive,
            onPress: () async {
              final bool? canDelete = await showConfirmDialog<bool>(
                context: context,
                title: 'Delete Project?', // TODO: localize
                description:
                    'This action cannot be undone. This will permanently delete this project from your computer.', // TODO: localize
                onConfirm: () => context.pop(true),
                onDismiss: () => context.pop(false),
              );

              if (context.mounted && canDelete == true) {
                onDelete();
              }
            },
            child: const Icon(FLucideIcons.trash),
          ),
        ],
      ),
    );
  }
}
