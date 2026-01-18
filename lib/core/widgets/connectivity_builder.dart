import 'package:caffeine/core/network/connectivity_cubit.dart';
import 'package:caffeine/core/network/connectivity_state.dart';
import 'package:caffeine/core/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityBuilder extends StatelessWidget {
  final Widget Function(BuildContext, bool isConnected) builder;

  const ConnectivityBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        final isConnected = state is ConnectivityConnected;
        if (!isConnected) {
          return const NoInternetScreen();
        }
        return builder(context, isConnected);
      },
    );
  }
}