// ignore_for_file: avoid_print
const bool _isLoggingEnabled = true;

// ignore: public_member_api_docs
void logInfo(String message) {
  if (_isLoggingEnabled) {
    print('>>>>>>>Dash Survey Core>>>>>>>');
    print(message);
    print('<<<<<<<Dash Survey Core<<<<<<<');
  }
}
