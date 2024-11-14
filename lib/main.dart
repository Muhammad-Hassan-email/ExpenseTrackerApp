import 'package:expense_tracker/widgets/Expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255,5,99,125));


void main() {
  runApp(MaterialApp(
    //Dark Mode
    // ignore: deprecated_member_use
    darkTheme: ThemeData.dark().copyWith(useMaterial3: true,
    colorScheme: kDarkColorScheme,
    cardTheme: const CardTheme().copyWith(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        color: kDarkColorScheme.secondaryContainer,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer
        ),
      ),
    ),

    //Light mode
    theme: ThemeData().copyWith(
      // ignore: deprecated_member_use
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        color: kColorScheme.secondaryContainer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: kColorScheme.onSecondaryContainer,
        ),
      )
      ),
    themeMode: ThemeMode.system,
    home: const Expenses(),
    ),
  );
}