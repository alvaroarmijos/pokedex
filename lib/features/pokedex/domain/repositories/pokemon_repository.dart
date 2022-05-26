import 'package:dartz/dartz.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_short.dart';

import '../../../../core/error/failures.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonShort>>> getPokemons(int offset);
  Future<Either<Failure, Pokemon>> getPokemon(int idPokemon);
}
