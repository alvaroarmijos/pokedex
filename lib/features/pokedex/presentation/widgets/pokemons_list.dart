import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemons/pokemons_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/loading_widget.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/message_display.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/pokemons_display.dart';

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
