extension ObjectExt on Object {
  T? safeCast<T>() => this is T ? this as T : null;
}
