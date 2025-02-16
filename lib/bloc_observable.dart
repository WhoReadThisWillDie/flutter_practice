import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    dev.log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    dev.log('onError -- bloc: ${bloc.runtimeType}, error: $error');
  }
}