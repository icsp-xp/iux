import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:iux/core/extension/build_context_ext.dart';
import 'package:iux/ui/core/theme/spacing.dart';
import 'package:iux/ui/core/ui/confirm_dialog.dart';

class ProjectView extends StatelessWidget {
  final String name;
  final String path;
  final VoidCallback onDelete;
  final VoidCallback onOpenProject;

  const ProjectView({
    required this.name,
    required this.path,
    required this.onDelete,
    required this.onOpenProject,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTappable(
      onPress: onOpenProject,
      builder: (context, states, child) => FFocusedOutline(
        focused: states.contains(FTappableVariant.focused),
        child: Container(
          padding: const .symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color:
                (states.contains(FTappableVariant.hovered) ||
                    states.contains(FTappableVariant.pressed))
                ? theme.colors.secondary
                : theme.colors.card,
            borderRadius: theme.style.borderRadius.sm,
          ),
          child: child,
        ),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.typography.body.md.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  spacing: theme.spacing.sm,
                  children: [
                    Icon(
                      FLucideIcons.folder,
                      color: theme.colors.mutedForeground,
                    ),
                    Text(
                      path,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.body.md.copyWith(
                        color: theme.colors.mutedForeground,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FButton.icon(
            variant: .destructive,
            onPress: () async {
              final bool? canDelete = await showConfirmDialog<bool>(
                context: context,
                title: context.l10n.deleteThisProjectTitle,
                description: context.l10n.deleteThisProjectDescription,
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
