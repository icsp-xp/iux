import 'package:iux/ui/core/theme/data/color_scheme.dart';
import 'package:iux/ui/core/theme/data/radius_size.dart';
import 'package:iux/ui/core/theme/data/spacing.dart';
import 'package:iux/ui/core/theme/data/typography.dart';

enum ThemeMode { light, dark, system }

class ThemeData {
  const ThemeData(
    this.colorScheme,
    this.typography,
    this.spacing,
    this.radiusSize,
  );

  final ColorScheme colorScheme;
  final Typography typography;
  final Spacing spacing;
  final RadiusSize radiusSize;
}
