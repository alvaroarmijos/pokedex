import 'package:equatable/equatable.dart';

class PokemonShort extends Equatable {
  final String name;
  final String url;

  PokemonShort({this.name, this.url}) : super([name, url]);
}
