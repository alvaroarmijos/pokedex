import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_short.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemons.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late GetPokemons usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemons(mockPokemonRepository);
  });

  final tOffset = 0;

  final tPokemon = PokemonShort(
      name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/");
  final tListPokemon = [tPokemon];

  test(
    'should get all posts from the repository',
    () async {
      when(() => mockPokemonRepository.getPokemons(tOffset))
          .thenAnswer((_) async => Right(tListPokemon));

      final result = await usecase(Params(offset: tOffset));
      expect(result, Right(tListPokemon));
      verify(() => mockPokemonRepository.getPokemons(tOffset));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
