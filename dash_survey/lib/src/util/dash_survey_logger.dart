const bool _isDebug = true;
void dashLogInfo(String object) {
  if (_isDebug) {
    print('>>>>>>>Dash Survey>>>>>>>');
    print(object);
    print('<<<<<<<Dash Survey<<<<<<<');
  }
}

void dashLogError(Object object) {
  if (_isDebug) {
    print('>>>>>>>Dash Survey>>>>>>>');
    print(object);
    print('<<<<<<<Dash Survey<<<<<<<');
  }
}
