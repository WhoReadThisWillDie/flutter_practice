import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:rick_and_morty_practice/data/models/character.dart';

class CharacterProvider {
  Future<Character> getCharacter(int page, String name) async {
    try {
      final response = await http.get(Uri.parse(
          'https://rickandmortyapi.com/api/character?page=$page&name=$name'));

      return Character.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
