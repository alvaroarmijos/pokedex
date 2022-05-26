part of 'pokemons_bloc.dart';

abstract class PokemonsEvent extends Equatable {
  const PokemonsEvent();

  @override
  List<Object> get props => [];
}

class InitPokedex extends PokemonsEvent {
  const InitPokedex();
  @override
  List<Object> get props => [];
}

class NextPage extends PokemonsEvent {
  const NextPage();
  @override
  List<Object> get props => [];
}

class PreviousPage extends PokemonsEvent {
  const PreviousPage();
  @override
  List<Object> get props => [];
}
