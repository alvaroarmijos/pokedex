import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/pokemon_short_card.dart';

final List<PokemonShortModel> pokemons = [
  PokemonShortModel(name: 'Bulbasour', url: '1', id: 1),
  PokemonShortModel(name: '2', url: '2', id: 2),
  PokemonShortModel(name: '3', url: '3', id: 3),
  PokemonShortModel(name: '4', url: '4', id: 4),
  PokemonShortModel(name: '5', url: '5', id: 5),
  PokemonShortModel(name: '6', url: '6', id: 6),
  PokemonShortModel(name: '7', url: '7', id: 7),
  PokemonShortModel(name: '8', url: '8', id: 8),
];

class PokemonsList extends StatelessWidget {
  const PokemonsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 20),
          itemCount: pokemons.length,
          itemBuilder: (context, index) =>
              PokemonShortCard(pokemon: pokemons[index]),
        ),
      ),
    );
  }
}
