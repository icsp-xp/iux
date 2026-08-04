import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:iux/core/extension/context_ext.dart';
import 'package:iux/ui/core/icons/icons.dart';
import 'package:iux/ui/core/toast/toast_data.dart';
import 'package:iux/ui/core/ui/gap.dart';
import 'package:uuid/uuid.dart';

abstract class ToastManager {
  static final _toastsData = <ToastData>[];
  static OverlayEntry? _overlayEntry;

  static const avgCps = 1100 / 60;
  static const minDurationSec = 3;

  static void remove(final ToastData toastData) {
    if (_toastsData.isEmpty) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _toastsData.remove(toastData);
      _overlayEntry?.markNeedsBuild();
    }
  }

  static void show(
    final BuildContext context, {
    required String message,
    final Duration? duration,
  }) {
    final drt =
        duration ??
        Duration(seconds: max(minDurationSec, message.length / avgCps).round());

    final currentData = ToastData(id: const Uuid().v4(), message: message);
    _toastsData.add(currentData);

    if (_overlayEntry == null) {
      final spacing = context.theme.spacing;

      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: spacing.small,
          right: spacing.small,
          child: Column(
            crossAxisAlignment: .end,
            spacing: spacing.small,
            children: [
              for (final data in _toastsData)
                _ToastWidget(
                  message: data.message,
                  onRemove: () => remove(data),
                ),
            ],
          ),
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.markNeedsBuild();
    }

    Future.delayed(drt, () {
      remove(currentData);
    });
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRemove;

  const _ToastWidget({required this.message, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final spacing = context.theme.spacing;

    return Container(
      padding: EdgeInsets.all(spacing.small),
      decoration: BoxDecoration(
        color: context.theme.toastThemeData.backgroundColor,
        borderRadius: context.theme.toastThemeData.borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: context.theme.typography.bodyMedium.copyWith(
              color: context.theme.toastThemeData.foregroundColor,
            ),
          ),
          Gap(spacing.smaller),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.plus, // TODO: use close icon
              color: context.theme.toastThemeData.foregroundColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
