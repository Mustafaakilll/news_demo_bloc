import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData.light());

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    if (event is LightThemeEvent) yield ThemeData.light();
    if (event is DarkThemeEvent) yield ThemeData.dark();
  }
}
