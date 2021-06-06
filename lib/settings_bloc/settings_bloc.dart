import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_navigation_bloc/app_navigation_cubit.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this.appNavigationCubit) : super(SettingsInitial());

  final AppNavigationCubit appNavigationCubit;

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is LogOutEvent) {
      appNavigationCubit.signOut();
    }
  }
}
