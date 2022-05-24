import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/core/global/global_variables.dart';
import 'package:pokedex/core/global/styles.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_short_model.dart';
import 'package:pokedex/features/pokedex/presentation/pages/pokemon_detail_page.dart';

class PokemonShortCard extends StatelessWidget {
  final PokemonShortModel pokemon;
  const PokemonShortCard({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, PokemonDetailPage.ROUTE,
          arguments: pokemon.id),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text("#${pokemon.id}", style: SubtitleStyle()),
            ),
            Text(pokemon.name, style: TitleStyle()),
            SvgPicture.network(
                GlobalVariables.IMAGES_POKEMON + "${pokemon.id}.svg",
                width: 100),
          ],
        ),
      )),
    );
  }
}
