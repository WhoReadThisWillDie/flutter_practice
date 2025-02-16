import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_practice/bloc_observable.dart';

import 'package:rick_and_morty_practice/rick_and_morty_app.dart';

void main() {
  Bloc.observer = CharacterBlocObserver();
  runApp(RickAndMortyApp());
}
