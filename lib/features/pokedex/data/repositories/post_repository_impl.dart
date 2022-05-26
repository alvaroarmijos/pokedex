import 'package:dartz/dartz.dart';
import 'package:pokedex/core/error/exception.dart';
import 'package:pokedex/core/platform/network_info.dart';
import 'package:pokedex/features/pokedex/data/datasources/pokemon_remote_data_surce.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_short.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokemon_repository.dart';

import '../../../../core/error/failures.dart';

typedef Future<List<PokemonShortModel>> _GetPokemons();
typedef Future<PokemonModel> _GetPokemon();

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Pokemon>> getPokemon(int idPokemon) async {
    return await _getPokemon(() {
      return remoteDataSource.getPokemon(idPokemon);
    });
  }

  @override
  Future<Either<Failure, List<PokemonShort>>> getPokemons(int offset) async {
    return await _getPokemons(() {
      return remoteDataSource.getPokemons(offset);
    });
  }

  Future<Either<Failure, List<PokemonShort>>> _getPokemons(
      _GetPokemons getPokemons) async {
    if (await networkInfo.isConnected) {
      try {
        final pokemons = await getPokemons();
        return Right(pokemons);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Pokemon>> _getPokemon(_GetPokemon getPokemon) async {
    if (await networkInfo.isConnected) {
      try {
        final pokemon = await getPokemon();
        return Right(pokemon);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
