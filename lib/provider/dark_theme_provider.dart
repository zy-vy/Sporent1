import 'package:flutter/cupertino.dart';
import 'package:sporent/services/dark_theme_pref.dart';

class DarkThemeProvider with ChangeNotifier {

  DarkThemePref darkThemePref = DarkThemePref();

  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme (bool value){
    _darkTheme = value;
    darkThemePref.setDarkTheme(value);
    notifyListeners();
  }

}