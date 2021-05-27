import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_navigation_state.dart';

class AppNavigationCubit extends Cubit<AppNavigationState> {
  AppNavigationCubit() : super(NewsPageState());

  void showNewsPage() {
    print('News Page');
    emit(NewsPageState());
  }

  void showSettingsPage() {
    emit(SettingsPageState());
    print('Settings Page');
  }
}