import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigation_bloc/app_navigation_cubit.dart';
import 'settings_bloc/settings_page.dart';
import 'news_bloc/news_page.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavigationCubit, AppNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: state is NewsPageState ? const NewsPage() : SettingsPage(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state is NewsPageState ? 0 : 1,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Haberler'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Ayarlar'),
            ],
            onTap: (value) {
              if (value == 1) {
                context.read<AppNavigationCubit>().showSettingsPage();
                print('value 1 Geldi');
              } else {
                context.read<AppNavigationCubit>().showNewsPage();
              }
            },
          ),
        );
      },
    );
  }
}
