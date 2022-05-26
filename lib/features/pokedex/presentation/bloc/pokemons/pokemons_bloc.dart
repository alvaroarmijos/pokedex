import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/global/global_variables.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemons.dart';

part 'pokemons_event.dart';
part 'pokemons_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  final GetPokemons getPokemons;

  PokemonsBloc({
    required this.getPokemons,
  }) : super(Empty()) {
    on<InitPokedex>((event, emit) async {
      int currentOffset = 0;
      emit(Loading(offset: currentOffset));
      final failureOrPosts = await getPokemons(Params(offset: currentOffset));
      emit(failureOrPosts.fold(
        (failure) => Error(
          message: _mapFailureToMessage(failure),
        ),
        (pokemons) => Loaded(
            pokemons: pokemons as List<PokemonShortModel>,
            offset: currentOffset),
      ));
    });

    on<NextPage>((event, emit) async {
      if (state.offset > GlobalVariables.MAX_POKEMONS) return;
      int currentOffset = state.offset + 10;
      emit(Loading(offset: currentOffset));
      final failureOrPosts = await getPokemons(Params(offset: currentOffset));
      emit(failureOrPosts.fold(
        (failure) => Error(
          message: _mapFailureToMessage(failure),
        ),
        (pokemons) => Loaded(
            pokemons: pokemons as List<PokemonShortModel>,
            offset: currentOffset),
      ));
    });

    on<PreviousPage>((event, emit) async {
      if (state.offset <= 0) return;
      int currentOffset = state.offset - 10;

      emit(Loading(offset: currentOffset));
      final failureOrPosts = await getPokemons(Params(offset: currentOffset));
      emit(failureOrPosts.fold(
        (failure) => Error(
          message: _mapFailureToMessage(failure),
        ),
        (pokemons) => Loaded(
            pokemons: pokemons as List<PokemonShortModel>,
            offset: currentOffset),
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
