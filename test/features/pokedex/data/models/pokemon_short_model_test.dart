import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_short.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPokemonShortModel = PokemonShortModel(
      name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/", id: 1);

  group('Entity', () {
    test('should be a subclass of PokemonShort entity', () async {
      expect(tPokemonShortModel, isA<PokemonShort>());
    });
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('pokemon_short.json'));
      final result = PokemonShortModel.fromJson(jsonMap);
      expect(result, tPokemonShortModel);
    });
  });

  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      final result = tPokemonShortModel.toJson();

      final expectedMap = {
        "name": "bulbasaur",
        "url": "https://pokeapi.co/api/v2/pokemon/1/"
      };
      expect(result, expectedMap);
    });
  });
}
