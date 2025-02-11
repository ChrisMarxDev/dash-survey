import 'dart:developer';

void logInfo(String object) {
  print(object);
}

void logError(Object object) {
  log(object.toString(), error: object, stackTrace: StackTrace.current);
}
