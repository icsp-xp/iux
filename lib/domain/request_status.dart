import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iux/domain/failure.dart';

part 'request_status.freezed.dart';

/// Represents the lifecycle states of an asynchronous request that returns a [T].
///
/// A [RequestStatus] can be one of four states:
/// - [RequestIdle]: the operation has not started yet.
/// - [RequestPending]: the operation is currently in progress.
/// - [RequestSucceeded]: the operation completed successfully with a value of type [T].
/// - [RequestFailed]: the operation failed with a [Failure].
@freezed
sealed class RequestStatus<T> with _$RequestStatus<T> {
  const RequestStatus._();

  /// Indicates that the operation is idle and waiting to start.
  ///
  /// Use this state to represent the UI before any user interaction occurs
  /// or after a state reset.
  const factory RequestStatus.idle() = RequestIdle<T>;

  /// Indicates that the request is currently being processed.
  const factory RequestStatus.pending() = RequestPending<T>;

  /// Indicates that the request completed successfully, carrying a [value] of type [T].
  ///
  /// Use [T] to represent the data returned by the operation. If no data is
  /// returned, consider using [Unit]
  const factory RequestStatus.succeeded(T value) = RequestSucceeded<T>;

  /// Indicates that the request failed.
  ///
  /// Contains a [failure] describing the specific reason for the error
  const factory RequestStatus.failed(Failure failure) = RequestFailed<T>;

  /// Returns true if the request is idle (not started yet).
  bool get isIdle => this is RequestIdle<T>;

  /// Returns true if the request is currently loading.
  bool get isPending => this is RequestPending<T>;

  /// Returns true if the request encountered an error.
  bool get isFailed => this is RequestFailed<T>;

  /// Returns true if the request was completed successfully.
  bool get isSucceeded => this is RequestSucceeded<T>;

  /// Returns the value [T] if the state is [RequestSucceeded], otherwise returns null.
  T? getValueOrNull() => mapOrNull(succeeded: (state) => state.value);
}
