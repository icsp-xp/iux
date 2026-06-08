import 'package:flutter/widgets.dart';

class Typography {
  const Typography({
    required this.bodySmall,
    required this.bodyMedium,
    required this.bodyLarge,
    required this.labelSmall,
    required this.labelMedium,
    required this.labelLarge,
    required this.titleSmall,
    required this.titleMedium,
    required this.titleLarge,
  });

  final TextStyle bodySmall;
  final TextStyle bodyMedium;
  final TextStyle bodyLarge;

  final TextStyle labelSmall;
  final TextStyle labelMedium;
  final TextStyle labelLarge;

  final TextStyle titleSmall;
  final TextStyle titleMedium;
  final TextStyle titleLarge;
}
