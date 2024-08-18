import 'business_logic/cubit/character_cubit.dart';
import 'data/models/character_model.dart';
import 'data/repository/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
import 'presentation/pages/character_details_screen.dart';
import 'presentation/pages/characters_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;
  AppRouter() {
    charactersRepository = CharactersRepository();
    characterCubit = CharacterCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allCharactersScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider<CharacterCubit>(
            create: (BuildContext context) => characterCubit,
            child: const CharactersPage(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                  characterModel: character,
                ));
    }
    return null;
  }
}
