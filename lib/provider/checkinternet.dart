import 'package:flutter/material.dart';
import '../constants/connectionStatus.dart';

class InternetStatus with ChangeNotifier {
  bool _status = false;
  ConnectionStatus _connection = ConnectionStatus.getInstance();

  bool get status => _status; // It is returning internet status.

  Future<void> updateInternetStatus() async {
    await _connection.checkConnection();
    if (_connection.hasConnection) {
      _status = true;
      notifyListeners();
    } else {
      _status = false;
      notifyListeners();
    }
  }
}
