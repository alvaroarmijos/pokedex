import 'package:flutter/material.dart';

class PokemonDetailPage extends StatelessWidget {
  static const ROUTE = 'pokemon-detail';

  @override
  Widget build(BuildContext context) {
    final int pokemonId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Text('PokemonDetailPage'),
      ),
    );
  }
}
