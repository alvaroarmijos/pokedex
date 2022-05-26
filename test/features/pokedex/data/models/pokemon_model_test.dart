import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPokemonModel = PokemonModel(
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
                name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/"),
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

  group('Entity', () {
    test('should be a subclass of Pokemon entity', () async {
      expect(tPokemonModel, isA<Pokemon>());
    });
  });

  group('fromJson', () {
    test('should return a valid model', () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('pokemon.json'));
      final result = PokemonModel.fromMap(jsonMap);
      expect(result, tPokemonModel);
    });
  });

  group('toJson', () {
    test('should return a Json map containing the proper data', () {
      final result = tPokemonModel.toMap();

      final expectedMap = {
        "abilities": [
          {
            "ability": {
              "name": "overgrow",
              "url": "https://pokeapi.co/api/v2/ability/65/"
            },
            "is_hidden": false,
            "slot": 1
          },
          {
            "ability": {
              "name": "chlorophyll",
              "url": "https://pokeapi.co/api/v2/ability/34/"
            },
            "is_hidden": true,
            "slot": 3
          }
        ],
        "types": [
          {
            "slot": 1,
            "type": {
              "name": "grass",
              "url": "https://pokeapi.co/api/v2/type/12/"
            }
          },
          {
            "slot": 2,
            "type": {
              "name": "poison",
              "url": "https://pokeapi.co/api/v2/type/4/"
            }
          }
        ],
        "height": 7,
        "weight": 69,
        "base_experience": 64,
        "held_items": [],
        "id": 1,
        "is_default": true,
        "name": "bulbasaur"
      };
      expect(result, expectedMap);
    });
  });
}
