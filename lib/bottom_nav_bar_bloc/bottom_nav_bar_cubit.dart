import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(NewsPageState());

  void showNewsPage() {
    emit(NewsPageState());
  }

  void showSettingsPage() {
    emit(SettingsPageState());
  }

  void showSearchPage() {
    emit(SearchPageState());
  }
}
