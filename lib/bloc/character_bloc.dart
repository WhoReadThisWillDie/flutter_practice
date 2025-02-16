import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_practice/services/character_repository.dart';
import 'package:rick_and_morty_practice/data/models/character.dart';

part 'character_bloc.freezed.dart';

part 'character_event.dart';

part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;

  CharacterBloc({required this.characterRepository})
      : super(CharacterState.loading()) {
    on<CharacterFetchEvent>((event, emit) async {
      emit(CharacterState.loading());

      try {
        Character characterLoaded = await characterRepository
            .getCharacter(event.page, event.name)
            .timeout(const Duration(seconds: 5));
        emit(CharacterState.loaded(character: characterLoaded));
      } catch (_) {
        emit(CharacterState.error());
        rethrow;
      }
    });
  }
}
