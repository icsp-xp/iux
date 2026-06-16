import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:iux/data/services/iux_settings_service.dart';
import 'package:iux/domain/error_handler.dart';
import 'package:iux/domain/failure.dart';
import 'package:iux/domain/model/iux_settings.dart';

final class IuxSettingsRepository {
  final IuxSettingsService _iuxSettingsService;

  IuxSettings? _settings;

  IuxSettingsRepository(this._iuxSettingsService);

  TaskEither<Failure, IuxSettings> getSettings() => TaskEither.tryCatch(
    () async {
      if (_settings != null) {
        return _settings!;
      }

      final content = await _iuxSettingsService.readAsString();
      if (content == null) {
        await _iuxSettingsService.create();

        final defaultSettings = IuxSettings(
          defaultProjectDirPath: await _iuxSettingsService
              .getDefaultProjectsDirPath(),
        );

        await _iuxSettingsService.writeAsString(defaultSettings.toJsonString());

        _settings = defaultSettings;

        return defaultSettings;
      } else {
        final settings = IuxSettings.fromJsonString(content);
        _settings = settings;

        return settings;
      }
    },
    (error, stackTrace) =>
        ErrorHandler.handle(error, stackTrace, 'On get iux settings'),
  );

  Future<Unit> _saveSettings(IuxSettings settings) async => _iuxSettingsService
      .writeAsString(jsonEncode(settings.toJson()))
      .then((_) => unit);

  TaskEither<Failure, Unit> updateSettings(
    IuxSettings Function(IuxSettings currentSettings) updater,
  ) => getSettings().flatMap(
    (currentSettings) => TaskEither.tryCatch(
      () async {
        final newSettings = updater(currentSettings);
        await _saveSettings(newSettings);
        return unit;
      },
      (error, stackTrace) =>
          ErrorHandler.handle(error, stackTrace, 'On update iux settings'),
    ),
  );
}
