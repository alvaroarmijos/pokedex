import 'package:pokedex/features/pokedex/domain/entities/pokemon_short.dart';

import 'package:meta/meta.dart';

class PokemonShortModel extends PokemonShort {
  final String name;
  final String url;
  final int id;

  PokemonShortModel(
      {@required this.name, @required this.url, @required this.id})
      : super(name: name, url: url);

  factory PokemonShortModel.fromJson(Map<String, dynamic> json) {
    return PokemonShortModel(
      name: json['name'],
      url: json['url'],
      id: int.parse(json['url'].split('/').reversed.toList()[1]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
