import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/core/global/global_variables.dart';

class ImagePokemon extends StatelessWidget {
  final int pokemonId;
  final double width;
  const ImagePokemon({Key? key, required this.pokemonId, this.width = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SvgPicture.network(
          GlobalVariables.IMAGES_POKEMON + "$pokemonId.svg",
          width: width),
    );
  }
}
