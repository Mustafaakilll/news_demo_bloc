import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_navigation_bloc/app_navigation_cubit.dart';

enum AuthNavigationState { logIn, signUp }

class AuthNavigationCubit extends Cubit<AuthNavigationState> {
  AuthNavigationCubit(this.appNavigationCubit)
      : super(AuthNavigationState.logIn);

  final AppNavigationCubit appNavigationCubit;

  void showLogin() => emit(AuthNavigationState.logIn);

  void showSignUp() => emit(AuthNavigationState.signUp);

  void showNews() => appNavigationCubit.showSession();
}
