import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final Map<int, int> counts;

  const CounterState({required this.counts});

  @override
  List<Object> get props => [counts];
}
