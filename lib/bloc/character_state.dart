part of 'character_bloc.dart';

@freezed
class CharacterState with _$CharacterState {
  const factory CharacterState.loading() = CharacterLoadingState;
  const factory CharacterState.loaded({required Character character}) = CharacterLoadedState;
  const factory CharacterState.error() = CharacterErrorState;
}
