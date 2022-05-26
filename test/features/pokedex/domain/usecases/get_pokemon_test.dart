import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemon.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late GetPokemon usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemon(mockPokemonRepository);
  });

  final tId = 1;
  final tPokemon = Pokemon(
      baseExperience: 64,
      height: 7,
      heldItems: [],
      id: 1,
      isDefault: true,
      name: "bulbasaur",
      weight: 69,
      abilities: [
        AbilityElement(
            ability: TypeClass(
                name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/"),
            isHidden: false,
            slot: 1),
        AbilityElement(
            ability: TypeClass(
                name: "chlorophyll",
                url: "https://pokeapi.co/api/v2/ability/34/"),
            isHidden: true,
            slot: 3),
      ],
      types: [
        Type(
          slot: 1,
          type: TypeClass(
              name: "grass", url: "https://pokeapi.co/api/v2/type/12/"),
        ),
        Type(
          slot: 2,
          type: TypeClass(
              name: "poison", url: "https://pokeapi.co/api/v2/type/4/"),
        ),
      ]);

  test(
    'should get pokemon information from the repository',
    () async {
      when(() => mockPokemonRepository.getPokemon(tId))
          .thenAnswer((_) async => Right(tPokemon));

      final result = await usecase(Params(idPokemon: tId));
      expect(result, Right(tPokemon));
      verify(() => mockPokemonRepository.getPokemon(tId));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
