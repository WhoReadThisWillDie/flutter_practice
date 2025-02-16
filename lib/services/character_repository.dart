import 'package:rick_and_morty_practice/data/models/character.dart';
import 'package:rick_and_morty_practice/services/character_provider.dart';

class CharacterRepository {
  final _characterProvider = CharacterProvider();

  Future<Character> getCharacter(int page, String name) =>
      _characterProvider.getCharacter(page, name);
}