import 'package:flutter/material.dart';

class CustomTheme {
  // Define your custom primary and accent colors here
  static const Color primaryColor = Color(0xFF3498db); // Replace with your color
  static const Color accentColor = Color(0xFF5bc0de);  // Replace with your color

  // Define a whitish background color
  static const Color backgroundColor = Color(0xFFF3F4F6);

  // Define text colors
  static const Color textColor = Colors.black; // Text color for dark backgrounds
  static const Color lightTextColor = Colors.black54; // Text color for light backgrounds

  // Create a ThemeData object with your custom colors and properties
  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor, // Scaffold background color
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 20, color: textColor),
      backgroundColor: Colors.red, // AppBar background color
      iconTheme: IconThemeData(color: Colors.white), // AppBar icon color
    ),
    // You can set more properties here, like text themes, fonts, etc.
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(fontSize: 30, color: textColor),
      bodyMedium: TextStyle(fontSize: 16, color: textColor),
      displaySmall: TextStyle(fontSize: 14, color: lightTextColor),
    ), colorScheme: const ColorScheme.light(
      primary: primaryColor, // Primary color
      background: backgroundColor,// Background color
     secondary: accentColor
    ),
  );
}
