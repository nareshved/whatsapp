import 'package:flutter/material.dart';
import 'package:whatsapp/domain/constants/app_colors/app_colors.dart';

var mlightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    surface: Colors.white,
    // primary: primaryColor,
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "Outfit",
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Outfit",
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: "Outfit",
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
  ),
);

// dark theme

var mDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(primary: darkPrimaryColor),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "Outfit",
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Outfit",
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: "Outfit",
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
  ),
);























// final mDarkTheme = ThemeData(
// brightness: Brightness.dark,

// colorScheme: ColorScheme.fromSeed(
// seedColor: Color.fromRGBO(255, 87, 34, 1),


// ),

// );
