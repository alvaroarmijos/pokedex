import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/core/global/global_variables.dart';
import 'package:pokedex/core/global/styles.dart';
import 'package:pokedex/core/utils/utils.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/item_type_pokemon.dart';

class HeaderPokemonDetail extends StatelessWidget {
  final PokemonModel pokemon;
  const HeaderPokemonDetail({Key? key, required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.cyan,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Utils.capitalize(pokemon.name),
                            style: TitleStyle(color: Colors.white, size: 26),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "#${pokemon.id}",
                              style: TitleStyle(color: Colors.white),
                            )),
                        Container(
                          height: 40,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: pokemon.types.length,
                              itemBuilder: (_, index) => ItemTypePokemon(
                                  type: pokemon.types[index].type.name)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(50),
                          topRight: const Radius.circular(50),
                        )),
                  )
                ],
              ),
              Positioned(
                  bottom: 20,
                  child: SvgPicture.network(
                      GlobalVariables.IMAGES_POKEMON + "${pokemon.id}.svg",
                      height: 200)),
            ],
          ),
        ),
      ),
    );
  }
}
