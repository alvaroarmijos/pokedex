import 'package:flutter/material.dart';
import 'package:pokedex/core/global/global_variables.dart';
import 'package:pokedex/core/global/styles.dart';

class HeaderPokemons extends StatelessWidget {
  const HeaderPokemons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Image.asset(
              GlobalVariables.IMAGES + "pokeball.png",
              width: 200,
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Pokedex',
                  style: TitleStyle(size: 30),
                ),
              )),
        ],
      ),
    );
  }
}
