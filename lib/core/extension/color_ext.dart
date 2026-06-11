import 'dart:ui';

extension ColorExt on Color {
  /// Darken a color by [percent] amount (100 = black)
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final f = 1 - percent / 100;

    return withValues(red: r * f, green: g * f, blue: b * f, alpha: a);
  }

  /// Lighten a color by [percent] amount (100 = white)
  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;

    return withValues(
      red: r + ((1.0 - r) * p),
      green: g + ((1.0 - g) * p),
      blue: b + ((1.0 - b) * p),
      alpha: a,
    );
  }
}
