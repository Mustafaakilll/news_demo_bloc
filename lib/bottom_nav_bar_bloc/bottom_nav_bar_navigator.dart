import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search_news_bloc/search_news_view.dart';
import '../news_bloc/news_page.dart';
import '../settings_bloc/settings_page.dart';
import 'bottom_nav_bar_cubit.dart';

class BottomNavBarNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            if (state is NewsPageState) {
              return const NewsPage();
            } else if (state is SettingsPageState) {
              return SettingsPage();
            } else {
              return const SearchNewsPage();
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            var _currentIndex = 0;
            if (state is NewsPageState) {
              _currentIndex = 0;
            } else if (state is SettingsPageState) {
              _currentIndex = 2;
            } else if (state is SearchPageState) {
              _currentIndex = 1;
            }
            return _bottomNavBar(_currentIndex, context);
          },
        ),
      ),
    );
  }

  Widget _bottomNavBar(int currentIndex, BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.home), label: 'Haberler'),
        const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Arama'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'Ayarlar'),
      ],
      onTap: (value) => _onTap(value, context),
    );
  }

  void _onTap(int index, BuildContext context) {
    if (index == 2) {
      context.read<BottomNavBarCubit>().showSettingsPage();
    } else if (index == 0) {
      context.read<BottomNavBarCubit>().showNewsPage();
    } else if (index == 1) {
      context.read<BottomNavBarCubit>().showSearchPage();
    }
  }
}
