import 'package:flutter/material.dart';

class Styles {

  static ThemeData themeData (bool isDark, BuildContext context){
    return ThemeData(
      scaffoldBackgroundColor: isDark? Colors.black54 :  Colors.white,
      primaryColor: const Color(0xFF4164DE),

      colorScheme: ThemeData().colorScheme.copyWith(
        secondary: isDark? Colors.black45 : Colors.white70,
        brightness: isDark ? Brightness.dark: Brightness.light
      ),
      cardColor: isDark? Colors.black38 : Colors.white60,
      canvasColor: isDark ? Colors.black87 : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isDark?
            const ColorScheme.dark():
            const ColorScheme.light()
      )
    );
  }

}