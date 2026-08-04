import 'package:freezed_annotation/freezed_annotation.dart';

part 'toast_data.freezed.dart';

@freezed
abstract class ToastData with _$ToastData {
  const factory ToastData({required String id, required String message}) = _ToastData;
}
