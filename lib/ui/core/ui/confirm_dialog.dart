import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:iux/core/extension/build_context_ext.dart';
import 'package:iux/ui/core/ui/adaptive_dialog.dart';

Future<T?> showConfirmDialog<T>({
  required final BuildContext context,
  required final String title,
  final String? description,
  final VoidCallback? onConfirm,
  final VoidCallback? onDismiss,
}) => showFDialog<T>(
  context: context,
  builder: (context, style, animation) => AdaptiveDialog(
    style: style,
    animation: animation,
    title: Text(title),
    body: Text(description ?? ''),
    actions: [
      if (onConfirm != null)
        FButton(
          variant: .primary,
          onPress: onConfirm,
          child: Text(context.l10n.actionContinue),
        ),
      if (onDismiss != null)
        FButton(
          variant: .secondary,
          onPress: onDismiss,
          child: Text(context.l10n.actionBack),
        ),
    ],
  ),
);
