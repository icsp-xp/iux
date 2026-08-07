import 'package:flutter/foundation.dart';

abstract final class STP {
  static final platforms = <TargetPlatform>{
    TargetPlatform.linux,
    TargetPlatform.macOS,
    TargetPlatform.windows,
  };

  static bool isSupported(final TargetPlatform platform) =>
      platforms.contains(platform);

  static T whenOrElse<T>({
    required final T Function() linux,
    required final T Function() macOs,
    required final T Function() windows,
    required final T Function() orElse,
  }) => switch (defaultTargetPlatform) {
    TargetPlatform.linux => linux(),
    TargetPlatform.macOS => macOs(),
    TargetPlatform.windows => windows(),
    _ => orElse(),
  };
}
