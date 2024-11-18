import 'package:flutter/material.dart';

final ThemeData darkCoffeeTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.brown.shade900, // Dark coffee background
  scaffoldBackgroundColor:
      Colors.brown.shade800, // Deep brown for the scaffold background
  cardColor: Colors.brown.shade700, // Slightly lighter brown for cards
  appBarTheme: AppBarTheme(
    color: Colors.brown.shade900, // Dark brown for app bar
    titleTextStyle:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white70),
    displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.brown.shade600,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown.shade500),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange.shade300),
    ),
    labelStyle: const TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(color: Colors.white60),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.orange.shade500, // Coffee theme button color
    textTheme: ButtonTextTheme.primary,
  ),
);
