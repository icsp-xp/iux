import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'toast_theme_data.freezed.dart';

@freezed
abstract class ToastThemeData with _$ToastThemeData {
  const factory ToastThemeData({
    required Color foregroundColor,
    required Color backgroundColor,
    required BorderRadius borderRadius,
  }) = _ToastThemeData;
}
