import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/auth_repository.dart';
import 'settings_bloc.dart';
import 'settings_state.dart';
import 'theme_bloc/theme_bloc.dart';
import 'theme_bloc/theme_event.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings Page')),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return SwitchListTile(
              title: const Text('Koyu Tema'),
              value: context.read<ThemeBloc>().state == ThemeData.dark(),
              onChanged: (value) {
                context
                    .read<ThemeBloc>()
                    .add(value ? DarkThemeEvent() : LightThemeEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
