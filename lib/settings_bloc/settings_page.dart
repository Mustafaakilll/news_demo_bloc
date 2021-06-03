import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_navigation_bloc/app_navigation_cubit.dart';
import 'dev_info_page.dart';
import 'settings_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';
import 'theme_bloc/theme_bloc.dart';
import 'theme_bloc/theme_event.dart';

//TODO:BURAYI DUZELT

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(context.read<AppNavigationCubit>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings Page')),
        body: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state is DevInfoState) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DeveloperPage()));
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextButton(
                        onPressed: () =>
                            context.read<SettingsBloc>().add(GoDevInfo()),
                        child: const Text(
                          'Gelistirici Hakkinda',
                          textScaleFactor: 1.3,
                        ),
                      ),
                    ),
                    SwitchListTile(
                      title: const Text('Koyu Tema'),
                      value:
                          context.read<ThemeBloc>().state == ThemeData.dark(),
                      onChanged: (value) {
                        context
                            .read<ThemeBloc>()
                            .add(value ? DarkThemeEvent() : LightThemeEvent());
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.read<SettingsBloc>().add(LogOutEvent()),
                  child: const Text('Cikis Yap'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
