import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(counts: {}));

  void increment(int productId) {
    final newCounts = Map<int, int>.from(state.counts);
    newCounts[productId] = (newCounts[productId] ?? 1) + 1;
    emit(CounterState(counts: newCounts));
  }

  void decrement(int productId) {
    final newCounts = Map<int, int>.from(state.counts);
    if ((newCounts[productId] ?? 1) > 1) {
      newCounts[productId] = (newCounts[productId] ?? 1) - 1;
    }
    emit(CounterState(counts: newCounts));
  }

  int getCount(int productId) {
    return state.counts[productId] ?? 1;
  }
}
