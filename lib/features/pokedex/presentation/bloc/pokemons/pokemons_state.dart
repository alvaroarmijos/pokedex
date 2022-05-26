part of 'pokemons_bloc.dart';

abstract class PokemonsState extends Equatable {
  final int offset;
  final List<PokemonShortModel> pokemons;
  const PokemonsState({
    this.offset = 0,
    this.pokemons = const [],
  });

  @override
  List<Object> get props => [];
}

class Empty extends PokemonsState {}

class Loading extends PokemonsState {
  final int offset;

  const Loading({required this.offset}) : super(offset: offset);

  @override
  List<Object> get props => [pokemons, offset];
}

class Loaded extends PokemonsState {
  final List<PokemonShortModel> pokemons;
  final int offset;

  const Loaded({required this.pokemons, required this.offset})
      : super(pokemons: pokemons, offset: offset);
  @override
  List<Object> get props => [pokemons, offset];
}

class Error extends PokemonsState {
  final String message;

  const Error({required this.message});

  List<Object> get props => [message];
}
