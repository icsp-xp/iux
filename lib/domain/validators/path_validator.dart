import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:iux/core/extension/string_ext.dart';
import 'package:iux/core/supported_target_platform.dart';
import 'package:iux/domain/error_handler.dart';
import 'package:iux/domain/failure.dart';

abstract final class PathValidator {
  static final RegExp _linuxMacPath = RegExp(r'^/[^\x00]+$');

  static final RegExp _windowsPath = RegExp(
    r'^(?:[a-zA-Z]:[/\\]|\\\\)[^<>:"|?*\x00-\x1F]*$',
  );

  static Either<Failure, bool> isValid(final String path) => Either.tryCatch(
    () {
      if (path.isBlank) {
        return false;
      }

      return STP.whenOrElse<bool>(
        linux: () => _linuxMacPath.hasMatch(path),
        macOs: () => _linuxMacPath.hasMatch(path),
        windows: () => _windowsPath.hasMatch(path),
        orElse: () => throw const UnsupportedOs(),
      );
    },
    (error, stackTrace) => ErrorHandler.handle(
      error,
      stackTrace,
      'On check path validity on $defaultTargetPlatform system',
    ),
  );
}
