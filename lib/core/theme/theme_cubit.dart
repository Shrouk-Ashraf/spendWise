import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/core/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const _prefKey = 'pref_is_dark_mode';

  final SharedPreferences _prefs;

  ThemeCubit(this._prefs)
      : super(ThemeState(themeMode: _initialThemeMode(_prefs)));

  static ThemeMode _initialThemeMode(SharedPreferences prefs) {
    final isDark = prefs.getBool(_prefKey);
    if (isDark == null) return ThemeMode.system;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _saveToPrefs(mode);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> toggle() async {
    final newMode = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setTheme(newMode);
  }

  Future<void> _saveToPrefs(ThemeMode mode) async {
    if (mode == ThemeMode.system) {
      // remove explicit pref to follow system
      await _prefs.remove(_prefKey);
    } else {
      await _prefs.setBool(_prefKey, mode == ThemeMode.dark);
    }
  }
}
