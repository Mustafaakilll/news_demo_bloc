import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_repository.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  final ThemeRepository themeRepo;
  final bool isLightTheme;

  ThemeBloc(this.themeRepo, this.isLightTheme)
      : super(isLightTheme == true ? ThemeData.light() : ThemeData.dark());

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    if (event is LightThemeEvent) {
      themeRepo.isLightTheme = !themeRepo.isLightTheme;
      await themeRepo.setTheme();
      yield ThemeData.light();
    }
    if (event is DarkThemeEvent) {
      themeRepo.isLightTheme = !themeRepo.isLightTheme;
      await themeRepo.setTheme();
      yield ThemeData.dark();
    }
  }
}
