import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemons.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemons/pokemons_bloc.dart';

class MockGetPokemons extends Mock implements GetPokemons {}

class FakeParams extends Fake implements Params {}

void main() {
  late PokemonsBloc bloc;
  late MockGetPokemons mockGetPokemons;

  setUp(() {
    mockGetPokemons = MockGetPokemons();

    bloc = PokemonsBloc(
      getPokemons: mockGetPokemons,
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeParams());
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetPokemons', () {
    final tOffset = 10;
    final tPokemon = PokemonShortModel(
        name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/", id: 1);
    final tListPokemon = [tPokemon];

    test(
      'should get data from the InitPokedex use case',
      () async {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Right(tListPokemon));
        // act
        bloc.add(InitPokedex());
        await untilCalled(() => mockGetPokemons(any()));
        // assert
        verify(() => mockGetPokemons(Params(offset: 0)));
      },
    );

    test(
      'should get data from the NextPage use case',
      () async {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Right(tListPokemon));
        // act
        bloc.add(NextPage());
        await untilCalled(() => mockGetPokemons(any()));
        // assert
        verify(() => mockGetPokemons(Params(offset: tOffset)));
      },
    );

    test(
      'should not get data from the PreviousPage use case',
      () async {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Right(tListPokemon));
        // act
        bloc.add(PreviousPage());
        // assert
        verifyNever(() => mockGetPokemons(Params(offset: 0)));
      },
    );

    test(
      'should get data from the PreviousPage use case',
      () async {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Right(tListPokemon));
        bloc.add(NextPage());
        await untilCalled(() => mockGetPokemons(any()));
        // act
        bloc.add(PreviousPage());
        await untilCalled(() => mockGetPokemons(any()));
        // assert
        verify(() => mockGetPokemons(Params(offset: 0)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is first time gotten successfully',
      () async* {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Right(tListPokemon));
        // assert later
        final expected = [
          Empty(),
          Loading(offset: tOffset),
          Loaded(pokemons: tListPokemon, offset: tOffset),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(InitPokedex());
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async* {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Right(tListPokemon));
        // assert later
        final expected = [
          Empty(),
          Loading(offset: tOffset),
          Loaded(pokemons: tListPokemon, offset: tOffset),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(NextPage());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails InitPokedex',
      () async* {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(offset: tOffset),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(InitPokedex());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails NextPage',
      () async* {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(offset: tOffset),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(NextPage());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails PreviousPage',
      () async* {
        // arrange
        when(() => mockGetPokemons(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(offset: tOffset),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(PreviousPage());
      },
    );
  });
}
