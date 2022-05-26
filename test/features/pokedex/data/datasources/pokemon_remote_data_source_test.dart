import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/core/error/exception.dart';
import 'package:pokedex/features/pokedex/data/datasources/pokemon_remote_data_surce.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockUri extends Fake implements Uri {}

void main() {
  late PokemonRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PokemonRemoteDataSourceImpl(client: mockHttpClient);
  });

  setUpAll(() {
    registerFallbackValue(MockUri());
  });

  void setUpMockHttpClientFailure404() {
    when(() => mockHttpClient.get(any(), headers: any(named: "headers")))
        .thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getPokemons', () {
    final tPokemons = List<PokemonShortModel>.from(json
        .decode(fixture('list_pokemon_short.json'))
        .map((x) => PokemonShortModel.fromJson(x)));
    final tOffset = 0;
    test(
      'should preform a GET request on a URL being the endpoint and with application/json header',
      () {
        //arrange
        when(() => mockHttpClient.get(any(), headers: any(named: "headers")))
            .thenAnswer(
          (_) async =>
              http.Response(fixture('list_pokemon_short_response.json'), 200),
        );
        // act
        dataSource.getPokemons(tOffset);
        // assert
        verify(() => mockHttpClient.get(
              Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&offset=0'),
              headers: {'Content-Type': 'application/json'},
            ));
      },
    );

    test(
      'should return Pokemons when the response code is 200 (success)',
      () async {
        // arrange
        when(() => mockHttpClient.get(any(), headers: any(named: "headers")))
            .thenAnswer(
          (_) async =>
              http.Response(fixture('list_pokemon_short_response.json'), 200),
        );
        // act
        final result = await dataSource.getPokemons(tOffset);
        // assert
        expect(result, equals(tPokemons));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getPokemons;
        // assert
        expect(() => call(tOffset), throwsA(isA<ServerException>()));
      },
    );
  });

  group('getPokemon', () {
    final tId = 1;
    final tPokemon = PokemonModel.fromMap(json.decode(fixture('pokemon.json')));
    test(
      'should preform a GET request on a URL being the endpoint and with application/json header',
      () {
        //arrange
        when(() => mockHttpClient.get(any(), headers: any(named: "headers")))
            .thenAnswer(
          (_) async => http.Response(fixture('pokemon.json'), 200),
        );
        // act
        dataSource.getPokemon(tId);
        // assert
        verify(() => mockHttpClient.get(
              Uri.parse('https://pokeapi.co/api/v2/pokemon/$tId/'),
              headers: {'Content-Type': 'application/json'},
            ));
      },
    );

    test(
      'should return Pokemon when the response code is 200 (success)',
      () async {
        // arrange
        when(() => mockHttpClient.get(any(), headers: any(named: "headers")))
            .thenAnswer(
          (_) async => http.Response(fixture('pokemon.json'), 200),
        );
        // act
        final result = await dataSource.getPokemon(tId);
        // assert
        expect(result, equals(tPokemon));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getPokemon;
        // assert
        expect(() => call(tId), throwsA(isA<ServerException>()));
      },
    );
  });
}
