import 'package:flutter/widgets.dart';
import 'package:iux/core/extension/build_context_ext.dart';
import 'package:iux/domain/failure.dart';

extension FailureExt on Failure {
  String localize(final BuildContext context) {
    final l10n = context.l10n;

    return switch (this) {
      UnexpectedFailure() => l10n.errorUnexpected,
      DataAlreadyExistsFailure() => l10n.errorDataAlreadyExists,
      DataNotFoundFailure() => l10n.errorDataNotFound,
      InvalidDataFailure() => l10n.errorInvalidData,
      UnsupportedOs() => l10n.errorUnsupportedOS,
    };
  }
}
