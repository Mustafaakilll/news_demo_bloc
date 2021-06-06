import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/auth_navigator.dart';
import '../authentication/auth_cubit.dart';
import '../bottom_nav_bar_bloc/bottom_nav_bar_navigator.dart';
import '../loading_view.dart';
import 'app_navigation_cubit.dart';
import 'app_navigation_state.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavigationCubit, AppNavigationState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is UnknownSessionState)
              MaterialPage(child: LoadingView()),

            /// IF USER NOT LOGIN YET GO TO AUTH SCREEN
            if (state is UnauthenticatedState)
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthNavigationCubit(context.read<AppNavigationCubit>()),
                  child: const AuthNavigator(),
                ),
              ),

            /// IF USER SIGNED IN GO TO NEWS SCREEN
            if (state is AuthenticatedState)
              MaterialPage(child: BottomNavBarNavigator()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
