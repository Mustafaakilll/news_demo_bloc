import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'app_navigation_bloc/app_navigation_cubit.dart';
import 'app_navigation_bloc/app_navigator.dart';
import 'authentication/auth_repository.dart';
import 'news_bloc/news_repository.dart';
import 'settings_bloc/theme_bloc/theme_bloc.dart';
import 'settings_bloc/theme_bloc/theme_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentaryDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentaryDirectory.path);
  final settings = await Hive.openBox('theme');
  bool isLightTheme = settings.get('isLightTheme') ?? true;
  runApp(MyApp(isLightTheme: isLightTheme));
}

class MyApp extends StatelessWidget {
  final isLightTheme;

  const MyApp({Key? key, this.isLightTheme}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ThemeBloc(ThemeRepository(isLightTheme: isLightTheme), isLightTheme),
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
                create: (context) =>
                    AppNavigationCubit(context.read<AuthRepository>()),
                child: AppNavigator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
