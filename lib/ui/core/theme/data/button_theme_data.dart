import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'button_theme_data.freezed.dart';

@freezed
abstract class ButtonThemeData with _$ButtonThemeData {
  const factory ButtonThemeData({
    required Color disabledColor,
    required Color hoverColor,
    required Color foregroundColor,
    required Color backgroundColor,
    required BorderRadius borderRadius,
    BoxBorder? border,
  }) = _ButtonThemeData;
}