import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'iux_settings.freezed.dart';
part 'iux_settings.g.dart';

@freezed
abstract class IuxSettings with _$IuxSettings {
  const IuxSettings._();

  const factory IuxSettings({required String defaultProjectDirPath}) =
      _IuxSettings;

  factory IuxSettings.fromJson(Map<String, dynamic> json) =>
      _$IuxSettingsFromJson(json);

  factory IuxSettings.fromJsonString(String json) =>
      IuxSettings.fromJson(jsonDecode(json));

  String toJsonString() => jsonEncode(toJson());
}
