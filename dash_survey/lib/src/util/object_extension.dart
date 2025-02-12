extension ObjectExtension on Object {
  T? asTypeOrNull<T>() {
    return this is T ? this as T : null;
  }

  T asTypeOrThrow<T>() {
    return this is T ? this as T : throw Exception('Object is not of type $T');
  }
}
