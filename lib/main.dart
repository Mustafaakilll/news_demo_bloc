import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigation_bloc/app_navigation_cubit.dart';
import 'app_navigator.dart';
import 'news_bloc/news_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: RepositoryProvider(
        create: (context) => NewsRepository(Dio()),
        child: BlocProvider(
          create: (context) => AppNavigationCubit(),
          child: AppNavigator(),
        ),
      ),
    );
  }
}
