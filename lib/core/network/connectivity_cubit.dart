import 'dart:async';

import 'package:caffeine/core/network/connectivity_state.dart';
import 'package:caffeine/core/network/network_cheacker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final NetworkChecker _networkChecker;
  StreamSubscription<bool>? _subscription;

  ConnectivityCubit({required NetworkChecker networkChecker})
    : _networkChecker = networkChecker,
      super(ConnectivityInitial()) {
    _init();
  }

  void _init() async {
    // Check initial status
    final isConnected = await _networkChecker.isConnected;
    emit(isConnected ? ConnectivityConnected() : ConnectivityDisconnected());

    // Listen to changes
    _subscription = _networkChecker.onConnectivityChanged.listen((isConnected) {
      emit(isConnected ? ConnectivityConnected() : ConnectivityDisconnected());
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}