part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonEvent extends PokemonEvent {
  final int idPokemon;
  const GetPokemonEvent({required this.idPokemon});
  @override
  List<Object> get props => [idPokemon];
}
