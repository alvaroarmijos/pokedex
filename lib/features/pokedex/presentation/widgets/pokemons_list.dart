import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemons/pokemons_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/loading_widget.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/message_display.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/pokemons_display.dart';

// final List<PokemonShortModel> pokemons = [
//   PokemonShortModel(name: 'Bulbasour', url: '1', id: 1),
//   PokemonShortModel(name: '2', url: '2', id: 2),
//   PokemonShortModel(name: '3', url: '3', id: 3),
//   PokemonShortModel(name: '4', url: '4', id: 4),
//   PokemonShortModel(name: '5', url: '5', id: 5),
//   PokemonShortModel(name: '6', url: '6', id: 6),
//   PokemonShortModel(name: '7', url: '7', id: 7),
//   PokemonShortModel(name: '8', url: '8', id: 8),
// ];

class PokemonsList extends StatelessWidget {
  const PokemonsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PokemonsBloc>().add(InitPokedex());

    return Expanded(
      child:
          BlocBuilder<PokemonsBloc, PokemonsState>(builder: (context, state) {
        if (state is Empty) {
          return MessageDisplay(
            message: 'There aren\'t pokemons.',
          );
        } else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Loaded) {
          return PokemonsDisplay(pokemons: state.pokemons);
        } else if (state is Error) {
          return MessageDisplay(
            message: state.message,
          );
        }

        return Container();
      }),
    );
  }
}
