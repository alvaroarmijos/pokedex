import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemons/pokemons_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedex/features/pokedex/presentation/pages/pokemons_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PokemonsBloc>()),
        BlocProvider(create: (_) => di.sl<PokemonBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        initialRoute: PokemonsPage.ROUTE,
        routes: {
          PokemonsPage.ROUTE: (_) => PokemonsPage(),
          PokemonDetailPage.ROUTE: (_) => PokemonDetailPage(),
        },
        // theme: ThemeData(buttonColor: Colors.white),
      ),
    );
  }
}
