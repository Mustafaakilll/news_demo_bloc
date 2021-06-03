import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';
import 'log_in_bloc/login_view.dart';
import 'sign_up_bloc/sign_up_view.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthNavigationCubit, AuthNavigationState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state == AuthNavigationState.logIn)
              MaterialPage(child: LoginView()),
            if (state == AuthNavigationState.signUp)
              MaterialPage(child: SignUpView())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
