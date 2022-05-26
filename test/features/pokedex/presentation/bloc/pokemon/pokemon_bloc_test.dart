import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemon.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemon/pokemon_bloc.dart';

class MockGetPokemon extends Mock implements GetPokemon {}

class FakeParams extends Fake implements Params {}

void main() {
  late PokemonBloc bloc;
  late MockGetPokemon mockGetPokemon;

  setUp(() {
    mockGetPokemon = MockGetPokemon();

    bloc = PokemonBloc(
      getPokemon: mockGetPokemon,
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeParams());
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetPokemon', () {
    final tInt = 1;
    final tPokemon = PokemonModel(
        baseExperience: 64,
        height: 7,
        heldItems: [],
        id: 1,
        isDefault: true,
        name: "bulbasaur",
        weight: 69,
        abilities: [
          AbilityElementModel(
              ability: TypeClassModel(
                  name: "overgrow",
                  url: "https://pokeapi.co/api/v2/ability/65/"),
              isHidden: false,
              slot: 1),
          AbilityElementModel(
              ability: TypeClassModel(
                  name: "chlorophyll",
                  url: "https://pokeapi.co/api/v2/ability/34/"),
              isHidden: true,
              slot: 3),
        ],
        types: [
          TypeModel(
            slot: 1,
            type: TypeClassModel(
                name: "grass", url: "https://pokeapi.co/api/v2/type/12/"),
          ),
          TypeModel(
            slot: 2,
            type: TypeClassModel(
                name: "poison", url: "https://pokeapi.co/api/v2/type/4/"),
          ),
        ]);

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        when(() => mockGetPokemon(any()))
            .thenAnswer((_) async => Right(tPokemon));
        // act
        bloc.add(GetPokemonEvent(idPokemon: tInt));
        await untilCalled(() => mockGetPokemon(any()));
        // assert
        verify(() => mockGetPokemon(Params(idPokemon: tInt)));
      },
    );

    test(
      'should emit [LoadingInformation, LoadedInformation] when data is gotten successfully',
      () async* {
        // arrange
        when(() => mockGetPokemon(any()))
            .thenAnswer((_) async => Right(tPokemon));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(pokemon: tPokemon),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(GetPokemonEvent(idPokemon: tInt));
      },
    );

    test(
      'should emit [LoadingInformation, LoadedInformation] when getting data fails',
      () async* {
        // arrange
        when(() => mockGetPokemon(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: "Server Failure"),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(GetPokemonEvent(idPokemon: tInt));
      },
    );
  });
}
