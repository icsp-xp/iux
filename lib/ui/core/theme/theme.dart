import 'dart:ui';

import 'package:iux/ui/core/theme/data/button_theme_data.dart';
import 'package:iux/ui/core/theme/data/color_scheme.dart';
import 'package:iux/ui/core/theme/data/radius_size.dart';
import 'package:iux/ui/core/theme/data/spacing.dart';
import 'package:iux/ui/core/theme/data/theme_data.dart';
import 'package:iux/ui/core/theme/data/typography.dart';

abstract class Theme {
  const Theme();

  Typography getTypography(final Brightness brightness);
  ColorScheme getColorScheme(final Brightness brightness);
  Spacing getSpacing();
  RadiusSize getRadiusSize();
  ButtonThemeData getPrimaryButtonThemeData(final Brightness brightness);
  ButtonThemeData getSecondaryButtonThemeData(final Brightness brightness);
  ButtonThemeData getErrorButtonThemeData(final Brightness brightness);

  ThemeData getThemeData(final Brightness brightness) => ThemeData(
    colorScheme: getColorScheme(brightness),
    typography: getTypography(brightness),
    spacing: getSpacing(),
    radiusSize: getRadiusSize(),
    primaryButtonThemeData: getPrimaryButtonThemeData(brightness),
    secondaryButtonThemeData: getSecondaryButtonThemeData(brightness),
    errorButtonThemeData: getErrorButtonThemeData(brightness),
  );
}
