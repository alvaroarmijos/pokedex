import 'package:flutter/material.dart';
import 'package:pokedex/core/global/styles.dart';
import 'package:pokedex/core/utils/utils.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';

class BodyPokemonDetal extends StatelessWidget {
  final PokemonModel pokemon;
  const BodyPokemonDetal({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          DataPokemon(
            title: "Height",
            subtitle: pokemon.height.toString() + " mm",
          ),
          DataPokemon(
            title: "Weight",
            subtitle: Utils.toKg(pokemon.weight).toStringAsFixed(2) + " kg",
          ),
          Row(children: [
            Expanded(
                child: Text(
              'Abilities',
              style: TitleStyle(color: Colors.cyan, size: 18),
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < pokemon.abilities.length; i++)
                  Text(
                    Utils.capitalize(pokemon.abilities[i].ability.name),
                    style: SubtitleStyle(),
                  ),
              ],
            )),
          ]),
          SizedBox(
            height: 20,
          ),
          Row(children: [
            Expanded(
                child: Text(
              'Types',
              style: TitleStyle(color: Colors.cyan, size: 18),
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < pokemon.types.length; i++)
                  Text(
                    Utils.capitalize(pokemon.types[i].type.name),
                    style: SubtitleStyle(),
                  ),
              ],
            )),
          ]),
        ],
      ),
    ));
  }
}

class DataPokemon extends StatelessWidget {
  final String title;
  final String subtitle;
  const DataPokemon({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: TitleStyle(color: Colors.cyan, size: 18),
          )),
          Expanded(
              child: Text(
            subtitle,
            style: SubtitleStyle(),
          )),
        ],
      ),
    );
  }
}
