import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';

class Scaffold extends StatelessWidget {
  final Widget? header;

  final double leftBarWidth;
  final Widget? leftBar;

  final double rightBarWidth;
  final Widget? rightBar;

  final double topBarHeight;
  final Widget? topBar;

  final double bottomBartHeight;
  final Widget? bottomBar;

  final Widget center;

  const Scaffold({
    required this.center,
    this.leftBarWidth = 0,
    this.leftBar,
    this.rightBarWidth = 0,
    this.rightBar,
    this.topBarHeight = 0,
    this.topBar,
    this.bottomBartHeight = 0,
    this.bottomBar,
    this.header,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ThemeProvider.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surface,
      child: Column(
        children: [
          ?header,

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (leftBar != null)
                  SizedBox(width: leftBarWidth, child: leftBar),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (topBar != null)
                        SizedBox(height: topBarHeight, child: topBar),

                      Expanded(child: center),

                      if (bottomBar != null)
                        SizedBox(height: bottomBartHeight, child: bottomBar),
                    ],
                  ),
                ),

                if (rightBar != null)
                  SizedBox(width: rightBarWidth, child: rightBar),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
