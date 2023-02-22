import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      shadowColor: Colors.grey.withOpacity(0.7),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.mainAppColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.mainAppColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),

      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      fontFamily: GoogleFonts.outfit().fontFamily,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.outfit(
          color: Colors.black,
          fontSize: 22,
        ),
        headlineSmall: GoogleFonts.outfit(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: GoogleFonts.outfit(
          color: Colors.black,
          fontSize: 13,
        ),
        bodyMedium: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
      ),
    );
  }
}
