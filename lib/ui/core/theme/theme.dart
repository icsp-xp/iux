import 'dart:ui';

import 'package:iux/ui/core/theme/data/color_scheme.dart';
import 'package:iux/ui/core/theme/data/radius_size.dart';
import 'package:iux/ui/core/theme/data/spacing.dart';
import 'package:iux/ui/core/theme/data/theme_data.dart';
import 'package:iux/ui/core/theme/data/typography.dart';

abstract class Theme {
  const Theme();

  Typography setTypography(Brightness brightness);
  ColorScheme setColorScheme(Brightness brightness);
  Spacing setSpacing();
  RadiusSize setRadiusSize();

  ThemeData getLightTheme() => ThemeData(
    setColorScheme(Brightness.light),
    setTypography(Brightness.light),
    setSpacing(),
    setRadiusSize(),
  );
  
  ThemeData getDarkTheme() => ThemeData(
    setColorScheme(Brightness.dark),
    setTypography(Brightness.dark),
    setSpacing(),
    setRadiusSize(),
  );

  ThemeData getThemeFromBrightness(Brightness brightness) =>
      switch (brightness) {
        Brightness.dark => getDarkTheme(),
        Brightness.light => getLightTheme(),
      };
}
