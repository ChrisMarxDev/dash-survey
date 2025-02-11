// ignore_for_file: avoid_print
const bool _isLoggingEnabled = true;

void logInfo(String message) {
  if (_isLoggingEnabled) {
    print('>>>>>>>Dash Survey Core>>>>>>>');
    print(message);
    print('<<<<<<<Dash Survey Core<<<<<<<');
  }
}
