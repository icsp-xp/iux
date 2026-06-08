import 'package:flutter/widgets.dart';
import 'package:iux/ui/core/theme/data/color_scheme.dart';
import 'package:iux/ui/core/theme/data/radius_size.dart';
import 'package:iux/ui/core/theme/data/spacing.dart';
import 'package:iux/ui/core/theme/data/typography.dart';
import 'package:iux/ui/core/theme/theme.dart';

class IuxTheme extends Theme {
  const IuxTheme();

  // Light theme colors
  final _lightColorScheme = const ColorScheme(
    primary: Color(0xFF2563EB),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFDEE5F8),
    onPrimaryContainer: Color(0xFF0F172A),

    secondary: Color(0xFF64748B),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE2E8F0),
    onSecondaryContainer: Color(0xFF1E293B),

    tertiary: Color(0xFF06B6D4),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFCFFAFE),
    onTertiaryContainer: Color(0xFF082F35),

    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),

    surface: Color(0xFFFAFAFA),
    onSurface: Color(0xFF0F172A),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF3F4F6),
    surfaceContainer: Color(0xFFE5E7EB),
    surfaceContainerHigh: Color(0xFFD1D5DB),
    surfaceContainerHighest: Color(0xFFBBBFCC),

    onSurfaceContainerLowest: Color(0xFF0F172A),
    onSurfaceContainerLow: Color(0xFF374151),
    onSurfaceContainer: Color(0xFF4B5563),
    onSurfaceContainerHigh: Color(0xFF6B7280),
    onSurfaceContainerHighest: Color(0xFF9CA3AF),

    outline: Color(0xFF9CA3AF),
    outlineVariant: Color(0xFFD1D5DB),
  );

  // Dark theme colors
  final _darkColorScheme = const ColorScheme(
    primary: Color(0xFF60A5FA),
    onPrimary: Color(0xFF0F172A),
    primaryContainer: Color(0xFF1E3A8A),
    onPrimaryContainer: Color(0xFFDEE5F8),

    secondary: Color(0xFF94A3B8),
    onSecondary: Color(0xFF0F172A),
    secondaryContainer: Color(0xFF334155),
    onSecondaryContainer: Color(0xFFE2E8F0),

    tertiary: Color(0xFF22D3EE),
    onTertiary: Color(0xFF082F35),
    tertiaryContainer: Color(0xFF164E63),
    onTertiaryContainer: Color(0xFFCFFAFE),

    error: Color(0xFFF87171),
    onError: Color(0xFF7F1D1D),
    errorContainer: Color(0xFF991B1B),
    onErrorContainer: Color(0xFFFEE2E2),

    surface: Color(0xFF0F172A),
    onSurface: Color(0xFFF8FAFC),
    surfaceContainerLowest: Color(0xFF020617),
    surfaceContainerLow: Color(0xFF1E293B),
    surfaceContainer: Color(0xFF334155),
    surfaceContainerHigh: Color(0xFF475569),
    surfaceContainerHighest: Color(0xFF64748B),

    onSurfaceContainerLowest: Color(0xFFF8FAFC),
    onSurfaceContainerLow: Color(0xFFCBD5E1),
    onSurfaceContainer: Color(0xFFB0B9C3),
    onSurfaceContainerHigh: Color(0xFF94A3B8),
    onSurfaceContainerHighest: Color(0xFF78828F),

    outline: Color(0xFF64748B),
    outlineVariant: Color(0xFF475569),
  );

  @override
  ColorScheme setColorScheme(Brightness brightness) {
    return switch (brightness) {
      Brightness.dark => _darkColorScheme,
      Brightness.light => _lightColorScheme,
    };
  }

  @override
  RadiusSize setRadiusSize() =>
      const RadiusSize(small: 6, medium: 12, large: 20);

  @override
  Spacing setSpacing() =>
      const Spacing(smaller: 8, small: 12, medium: 16, big: 24, bigger: 32);

  @override
  Typography setTypography(Brightness brightness) {
    return switch (brightness) {
      Brightness.dark => const Typography(
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: Color(0xFFB0B9C3),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: Color(0xFFCBD5E1),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: Color(0xFFF8FAFC),
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.45,
          color: Color(0xFF94A3B8),
          letterSpacing: 0.5,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Color(0xFFCBD5E1),
          letterSpacing: 0.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Color(0xFFF8FAFC),
          letterSpacing: 0.5,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: Color(0xFFF8FAFC),
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: Color(0xFFF8FAFC),
        ),
        titleLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.3,
          color: Color(0xFFF8FAFC),
        ),
      ),
      Brightness.light => const Typography(
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: Color(0xFF6B7280),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: Color(0xFF4B5563),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: Color(0xFF0F172A),
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.45,
          color: Color(0xFF6B7280),
          letterSpacing: 0.5,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Color(0xFF374151),
          letterSpacing: 0.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Color(0xFF0F172A),
          letterSpacing: 0.5,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: Color(0xFF0F172A),
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: Color(0xFF0F172A),
        ),
        titleLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.3,
          color: Color(0xFF0F172A),
        ),
      ),
    };
  }
}
