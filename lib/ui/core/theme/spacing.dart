import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Spacing extends ThemeExtension<Spacing> {
  final double xs;
  final double sm;
  final double md;
  final double base;
  final double lg;
  final double xl;
  final double xxl;

  const Spacing({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 12.0,
    this.base = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
  });

  @override
  Spacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? base,
    double? lg,
    double? xl,
    double? xxl,
  }) => Spacing(
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    base: base ?? this.base,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    xxl: xxl ?? this.xxl,
  );

  @override
  Spacing lerp(final Spacing? other, final double t) {
    if (other is! Spacing) {
      return this;
    }
    return Spacing(
      xs: xs,
      sm: sm,
      md: md,
      base: base,
      lg: lg,
      xl: xl,
      xxl: xxl,
    );
  }
}

extension SpacingExt on FThemeData {
  Spacing get spacing => extension<Spacing>();
}
