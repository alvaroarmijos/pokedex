import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/error/exception.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/core/platform/network_info.dart';
import 'package:pokedex/features/pokedex/data/datasources/pokemon_remote_data_surce.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:pokedex/features/pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_short.dart';

class MockRemoteDataSource extends Mock implements PokemonRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late PokemonRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PokemonRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getPokemons', () {
    final tOfsset = 0;
    final tPokemon = PokemonShortModel(
        name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/", id: 1);
    final tListPokemonModel = [tPokemon];
    final List<PokemonShort> tListPokemon = tListPokemonModel;
    test('should check if the device is online', () async {
      //arrange
      when(() => mockRemoteDataSource.getPokemons(tOfsset))
          .thenAnswer((_) async => tListPokemonModel);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      repository.getPokemons(tOfsset);
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      // This setUp applies only to the 'device is online' group
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemons(tOfsset))
              .thenAnswer((_) async => tListPokemonModel);
          // act
          final result = await repository.getPokemons(tOfsset);
          // assert
          verify(() => mockRemoteDataSource.getPokemons(tOfsset));
          expect(result, equals(Right(tListPokemon)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getPokemons(tOfsset))
              .thenThrow(ServerException());
          // act
          final result = await repository.getPokemons(tOfsset);
          // assert
          verify(() => mockRemoteDataSource.getPokemons(tOfsset));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('getPokemon', () {
      final tId = 1;
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

      test('should check if the device is online', () {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getPokemon(tId))
            .thenAnswer((_) async => tPokemon);
        // act
        repository.getPokemon(tId);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      });

      group('device is online', () {
        // This setUp applies only to the 'device is online' group
        setUp(() {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });

        test(
          'should return remote data when the call to remote data source is successful',
          () async {
            // arrange
            when(() => mockRemoteDataSource.getPokemon(tId))
                .thenAnswer((_) async => tPokemon);
            // act
            final result = await repository.getPokemon(tId);
            // assert
            verify(() => mockRemoteDataSource.getPokemon(tId));
            expect(result, equals(Right(tPokemon)));
          },
        );
        test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
            // arrange
            when(() => mockRemoteDataSource.getPokemon(tId))
                .thenThrow(ServerException());
            // act
            final result = await repository.getPokemon(tId);
            // assert
            verify(() => mockRemoteDataSource.getPokemon(tId));
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
    });
  });
}
