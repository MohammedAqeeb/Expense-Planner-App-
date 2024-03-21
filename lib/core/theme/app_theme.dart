import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  // Resusable Border color
  static _border([Color color = AppPallete.greyColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(14),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    // dark color for entire app
    scaffoldBackgroundColor: AppPallete.backgroundColor,

    // For Decoration of Input fields
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.lightRedColor),
    ),
  );
}
