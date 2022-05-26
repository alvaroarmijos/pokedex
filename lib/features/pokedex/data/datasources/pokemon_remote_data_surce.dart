import 'dart:convert';

import 'package:pokedex/core/error/exception.dart';
import 'package:pokedex/core/global/global_variables.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:http/http.dart' as http;

abstract class PokemonRemoteDataSource {
  /// Calls the https://pokeapi.co/api/v2/pokemon?limit=?&offset=? endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PokemonShortModel>> getPokemons(int offset);

  /// Calls the https://pokeapi.co/api/v2/pokemon/idPokemon/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<PokemonModel> getPokemon(int idPokemon);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PokemonShortModel>> getPokemons(int offset) async {
    final response = await client.get(
      Uri.parse(
          "${GlobalVariables.BASE_URL}?limit=${GlobalVariables.LIMIT}&offset=$offset"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return List<PokemonShortModel>.from(json
          .decode(response.body)['results']
          .map((x) => PokemonShortModel.fromJson(x)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PokemonModel> getPokemon(int idPokemon) async {
    final response = await client.get(
      Uri.parse("${GlobalVariables.BASE_URL}/$idPokemon/"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
