import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/auth_repository.dart';
import 'app_navigation_state.dart';

class AppNavigationCubit extends Cubit<AppNavigationState> {
  AppNavigationCubit(this.authRepo) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  final AuthRepository authRepo;

  void attemptAutoLogin() {
    try {
      FirebaseAuth.instance.currentUser!;
      emit(AuthenticatedState());
    } catch (e) {
      emit(UnauthenticatedState());
    }
  }

  void showAuth() => emit(UnauthenticatedState());

  void showSession() => emit(AuthenticatedState());

  void signOut() {
    emit(UnauthenticatedState());
    authRepo.signOut();
  }
}
