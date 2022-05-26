import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemon.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemons/pokemons_bloc.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final GetPokemon getPokemon;
  PokemonBloc({required this.getPokemon}) : super(Empty()) {
    on<GetPokemonEvent>((event, emit) async {
      emit(Loading());
      final failureOrPosts =
          await getPokemon(Params(idPokemon: event.idPokemon));
      emit(failureOrPosts.fold(
        (failure) => Error(
          message: _mapFailureToMessage(failure),
        ),
        (pokemon) => Loaded(
          pokemon: pokemon as PokemonModel,
        ),
      ));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
