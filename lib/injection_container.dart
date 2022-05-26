import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:pokedex/core/platform/network_info.dart';
import 'package:pokedex/features/pokedex/data/datasources/pokemon_remote_data_surce.dart';
import 'package:pokedex/features/pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemon.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemons.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/features/pokedex/presentation/bloc/pokemons/pokemons_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Posts
  //Bloc
  sl.registerFactory(
    () => PokemonsBloc(
      getPokemons: sl(),
    ),
  );
  sl.registerFactory(
    () => PokemonBloc(
      getPokemon: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPokemons(sl()));
  sl.registerLazySingleton(() => GetPokemon(sl()));

  // Repository
  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(client: sl()),
  );

  //! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
