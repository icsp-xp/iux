import 'package:flutter/widgets.dart';
import 'package:iux/ui/core/theme/data/theme_data.dart';

class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    required this.themeData,
    required super.child,
    super.key,
  });

  final ThemeData themeData;

  static ThemeData of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeProvider>()!
        .themeData;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.themeData != themeData;
  }
}
