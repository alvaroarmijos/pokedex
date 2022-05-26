import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/pokemon_short_card.dart';

class PokemonsDisplay extends StatelessWidget {
  final List<PokemonShortModel> pokemons;
  const PokemonsDisplay({Key? key, required this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 20),
        itemCount: pokemons.length,
        itemBuilder: (context, index) =>
            PokemonShortCard(pokemon: pokemons[index]),
      ),
    );
  }
}
