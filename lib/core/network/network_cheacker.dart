import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkChecker {
  final InternetConnection _internetConnection = InternetConnection();

  Future<bool> get isConnected async {
    final status = await _internetConnection.hasInternetAccess;
    return status;
  }

  Stream<bool> get onConnectivityChanged {
    return _internetConnection.onStatusChange.map((status) {
      return status == InternetStatus.connected;
    });
  }
}