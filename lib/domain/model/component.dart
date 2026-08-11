import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iux/domain/model/component_type.dart';

part 'component.freezed.dart';
part 'component.g.dart';

@freezed
abstract class Component with _$Component {
  const factory Component({
    required String uid,
    required ComponentType type,
    required String? parentUid,
    required Map<String, dynamic> modifiedProperties,
  }) = _Component;

  factory Component.fromJson(Map<String, Object?> json) => _$ComponentFromJson(json);
}
