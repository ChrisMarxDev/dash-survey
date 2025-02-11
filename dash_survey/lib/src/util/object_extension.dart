extension ObjectExtension on Object {
  T? asTypeOrNull<T>() {
    return this is T ? this as T : null;
  }
}
