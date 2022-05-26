part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class Empty extends PokemonState {}

class Loading extends PokemonState {}

class Loaded extends PokemonState {
  final PokemonModel pokemon;

  const Loaded({required this.pokemon});
  @override
  List<Object> get props => [pokemon];
}

class Error extends PokemonState {
  final String message;

  const Error({required this.message});

  List<Object> get props => [message];
}
