import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedex/features/pokedex/presentation/pages/pokemons_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      initialRoute: PokemonsPage.ROUTE,
      routes: {
        PokemonsPage.ROUTE: (_) => PokemonsPage(),
        PokemonDetailPage.ROUTE: (_) => PokemonDetailPage(),
      },
      theme: ThemeData(buttonColor: Colors.white),
    );
  }
}
