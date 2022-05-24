import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/header_pokemons.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/pokemons_list.dart';

class PokemonsPage extends StatelessWidget {
  static const ROUTE = 'pokemons';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PokemonsBody(),
    ));
  }
}

class PokemonsBody extends StatelessWidget {
  const PokemonsBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HeaderPokemons(),
          PokemonsList(),
        ],
      ),
    );
  }
}
