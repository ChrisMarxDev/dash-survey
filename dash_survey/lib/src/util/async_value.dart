// ignore_for_file: public_member_api_docs

/// Basic wrapper for async values.
sealed class AsyncValue<T> {
  const AsyncValue();
}

/// Represents an async value that is loading.
class AsyncValueLoading<T> extends AsyncValue<T> {
  const AsyncValueLoading();
}

/// Represents an async value that has an error.
class AsyncValueError<T> extends AsyncValue<T> {
  const AsyncValueError(this.error);

  final Object error;
}

/// Represents an async value that has a value.
class AsyncValueSuccess<T> extends AsyncValue<T> {
  const AsyncValueSuccess(this.value);

  final T value;
}
