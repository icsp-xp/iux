import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iux/core/extension/context_ext.dart';

class Dialog extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  const Dialog({required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final radius = theme.radiusSize;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(radius.medium),
        ),
        child: builder(context),
      ),
    );
  }
}
