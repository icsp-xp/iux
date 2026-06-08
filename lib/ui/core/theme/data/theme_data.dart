import 'package:iux/ui/core/theme/data/color_scheme.dart';
import 'package:iux/ui/core/theme/data/radius_size.dart';
import 'package:iux/ui/core/theme/data/spacing.dart';
import 'package:iux/ui/core/theme/data/typography.dart';
import 'package:iux/ui/core/theme/data/button_theme_data.dart';

enum ThemeMode { light, dark, system }

class ThemeData {
  final ColorScheme colorScheme;
  final Typography typography;
  final Spacing spacing;
  final RadiusSize radiusSize;

  final ButtonThemeData primaryButtonThemeData;
  final ButtonThemeData secondaryButtonThemeData;
  final ButtonThemeData errorButtonThemeData;

  const ThemeData({
    required this.colorScheme,
    required this.typography,
    required this.spacing,
    required this.radiusSize,

    required this.primaryButtonThemeData,
    required this.secondaryButtonThemeData,
    required this.errorButtonThemeData,
  });
}
