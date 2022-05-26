import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/body_pokemon_detail.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/header_pokemon_detail.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/loading_widget.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/message_display.dart';

class PokemonDetailPage extends StatelessWidget {
  static const ROUTE = 'pokemon-detail';

  @override
  Widget build(BuildContext context) {
    final idPokemon = ModalRoute.of(context)!.settings.arguments;
    context
        .read<PokemonBloc>()
        .add(GetPokemonEvent(idPokemon: idPokemon as int));
    return Scaffold(
      body: BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
        if (state is Empty) {
          return MessageDisplay(
            message: 'There aren\'t information about pokemon.',
          );
        } else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Loaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderPokemonDetail(pokemon: state.pokemon),
              BodyPokemonDetal(pokemon: state.pokemon),
            ],
          );
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
