import '../../data/repository/characters_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit(this.charactersRepository) : super(CharacterInitial());
  final CharactersRepository charactersRepository;
  Future<void> getAllCharacters() async {
    emit(CharacterLoading());
    try {
      emit(CharacterLoaded(await charactersRepository.getAllCharacters()));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getPageCharacters(index) async {
    emit(CharacterLoading());
    try {
      emit(
          CharacterLoaded(await charactersRepository.getPageCharacters(index)));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getFilteredCharacters(String characterSearchedFor) async {
    emit(CharacterLoading());
    try {
      Map<String, dynamic> charactersMap =
          await charactersRepository.filterCharacters(characterSearchedFor);
      emit(CharacterFilteredLoaded(charactersMap));
    } catch (e) {
      emit(CharacterFilteredError(errorMsg: 'No Character Found'));
    }
  }
}
