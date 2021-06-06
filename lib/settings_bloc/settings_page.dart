import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_navigation_bloc/app_navigation_cubit.dart';
import 'settings_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';
import 'theme_bloc/theme_bloc.dart';
import 'theme_bloc/theme_event.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(context.read<AppNavigationCubit>()),
      child: Scaffold(
        appBar: _appBar(),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _themeSwitch(context),
                _logOutButton(context),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(title: const Text('Settings Page'));
  }

  SwitchListTile _themeSwitch(BuildContext context) {
    return SwitchListTile(
      title: const Text('Koyu Tema'),
      value: context.read<ThemeBloc>().state == ThemeData.dark(),
      onChanged: (value) {
        context
            .read<ThemeBloc>()
            .add(value ? DarkThemeEvent() : LightThemeEvent());
      },
    );
  }

  ElevatedButton _logOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<SettingsBloc>().add(LogOutEvent()),
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff616161),
      ),
      child: const Text('Cikis Yap'),
    );
  }
}
