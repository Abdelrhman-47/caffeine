
import 'package:caffeine/features/favorite/data/fav_model.dart';
import 'package:equatable/equatable.dart';

class FavState extends Equatable {
  const FavState();

  @override
  List<Object> get props => [];
}

final class FavInitial extends FavState {}
final class FavLoading extends FavState {}
final class FavLoaded extends FavState{
  final List<FavModel> favsData;

  const FavLoaded(this.favsData);

  @override
  List<Object> get props => [favsData];

}
final class FavError extends FavState{
  final String message;

  const FavError(this.message);

  @override
  List<Object> get props => [message];

}
final class FaveAded extends FavState{
  const FaveAded();
    List<Object> get props => [];

}
final class Favedeleted extends FavState{
  const Favedeleted();
    List<Object> get props => [];

}
