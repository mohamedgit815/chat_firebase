import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState extends ChangeNotifier {
  final String _key = "theme";
  SharedPreferences? _prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeState() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }


  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs!.getBool(_key) ?? true;
    notifyListeners();
  }


  _saveToPrefs() async {
    await _initPrefs();
    await _prefs!.setBool(_key, _darkTheme);
  }
}