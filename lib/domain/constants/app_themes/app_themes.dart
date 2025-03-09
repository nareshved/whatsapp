import 'package:flutter/material.dart';
import 'package:whatsapp/domain/constants/app_colors/app_colors.dart';

var mlightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: AppColors.lightPrimaryColor,
    surface: AppColors.lightBgColor,
    secondaryContainer: AppColors.lightMsgBoxContainerColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightPrimaryContainerColor,
  ),
  useMaterial3: true,
  fontFamily: "Outfit",
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "Outfit",
      fontSize: 18,
      // fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Outfit",
      fontSize: 15,
      // fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: "Outfit",
      fontSize: 13,
      // fontWeight: FontWeight.w400,
    ),
  ),
);

// dark theme

var mDarkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Outfit",
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimaryColor,
    surface: AppColors.darkbgSurfaceColor,
    secondaryContainer: AppColors.darkChatMsgContainerContainerColor,
  ),

  appBarTheme: AppBarTheme(backgroundColor: AppColors.darkAppBarColor),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "Outfit",
      fontSize: 18,
      // fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Outfit",
      fontSize: 15,
      // fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: "Outfit",
      fontSize: 13,
      // fontWeight: FontWeight.w400,
    ),
  ),
);























// final mDarkTheme = ThemeData(
// brightness: Brightness.dark,

// colorScheme: ColorScheme.fromSeed(
// seedColor: Color.fromRGBO(255, 87, 34, 1),


// ),

// );
