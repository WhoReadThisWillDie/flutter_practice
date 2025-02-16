import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_practice/bloc/character_bloc.dart';
import 'package:rick_and_morty_practice/services/character_repository.dart';
import 'package:rick_and_morty_practice/ui/pages/search_page.dart';

class HomePage extends StatelessWidget {
  final _repository = CharacterRepository();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: Text(
          'Rick and Morty App',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocProvider(
        create: (context) => CharacterBloc(
          characterRepository: _repository,
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.black45),
          child: SearchPage(),
        ),
      ),
    );
  }
}
