import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/usecases/usecase.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_short.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemons extends UseCase<List<PokemonShort>, Params> {
  final PokemonRepository repository;

  GetPokemons(this.repository);

  @override
  Future<Either<Failure, List<PokemonShort>>> call(Params params) async {
    return await repository.getPokemons(params.offset);
  }
}

class Params extends Equatable {
  final int offset;

  const Params({required this.offset});

  @override
  List<Object?> get props => [offset];
}
