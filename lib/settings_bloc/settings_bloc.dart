import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/auth_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this.authRepo) : super(SettingsInitial());

  final AuthRepository authRepo;

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is LogOutEvent) {
      //TODO: CIKIS YAP
      final isSuccess = authRepo.logOut();
      if (isSuccess) print('Basarili');
    }
  }
}
