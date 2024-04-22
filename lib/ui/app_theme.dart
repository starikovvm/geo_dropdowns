import 'package:flutter/material.dart';

ThemeData get appThemeData {
  return ThemeData.light(useMaterial3: true).copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      menuStyle: const MenuStyle(),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
  );
}
