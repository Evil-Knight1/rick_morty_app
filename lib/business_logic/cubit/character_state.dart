part of 'character_cubit.dart';

sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

final class CharacterLoading extends CharacterState {}

final class CharacterLoaded extends CharacterState {
  final Map<String,dynamic> characters;

  CharacterLoaded(this.characters);
}

final class CharacterFilteredLoaded extends CharacterState {
  final Map<String, dynamic> filteredCharacters;
  CharacterFilteredLoaded(this.filteredCharacters);
}

final class CharacterFilteredError extends CharacterState {
  final String errorMsg;

  CharacterFilteredError({required this.errorMsg});

}