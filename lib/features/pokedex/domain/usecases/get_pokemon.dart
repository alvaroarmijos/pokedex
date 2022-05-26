import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/usecases/usecase.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemon extends UseCase<Pokemon, Params> {
  final PokemonRepository repository;

  GetPokemon(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(Params params) async {
    return await repository.getPokemon(params.idPokemon);
  }
}

class Params extends Equatable {
  final int idPokemon;

  const Params({required this.idPokemon});

  @override
  List<Object?> get props => [idPokemon];
}
