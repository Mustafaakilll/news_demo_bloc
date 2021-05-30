import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data_repository.dart';

class ThemeRepository implements DataRepository {
  bool isLightTheme;
  ThemeRepository({required this.isLightTheme});

  Future<ThemeData> getThemeFromDB() async {
    final settings = await Hive.openBox('theme');
    debugPrint('${settings.get('isLightTheme')} GET THEME');
    return await settings.get('isLightTheme');
  }

  Future<void> setTheme() async {
    final settings = await Hive.openBox('theme');
    await settings.put('isLightTheme', isLightTheme);
  }
}
