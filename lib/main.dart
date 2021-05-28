import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigation_bloc/app_navigation_cubit.dart';
import 'app_navigator.dart';
import 'authentication/auth_repository.dart';
import 'news_bloc/news_repository.dart';
import 'settings_bloc/theme_bloc/theme_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state,
            home: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(create: (_) => AuthRepository()),
                RepositoryProvider(create: (_) => NewsRepository(Dio())),
              ],
              child: BlocProvider(
                create: (context) => AppNavigationCubit(),
                child: AppNavigator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
