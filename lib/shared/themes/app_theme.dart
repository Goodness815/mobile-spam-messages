import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,

    brightness: Brightness.light,

    primaryColor: AppColors.primaryColor,

    scaffoldBackgroundColor: AppColors.backgroundColor,

    splashColor: AppColors.primaryColor,

    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: AppColors.primaryTextColor,
      selectionColor: AppColors.secondaryTextColor,
    ),

    backgroundColor: AppColors.backgroundColor,

    // inputDecorationTheme: inputDecorationTheme(false),

    iconTheme: const IconThemeData(color: AppColors.primaryTextColor),

    /* textTheme: GoogleFonts.interTextTheme().copyWith(



      headline1: GoogleFonts.inter(textStyle: _h11),



      headline2: GoogleFonts.inter(textStyle: _h12),



      headline3: GoogleFonts.inter(textStyle: _h14),



      headline4: GoogleFonts.inter(textStyle: _h16),



      headline5: GoogleFonts.inter(textStyle: _h18),



      headline6: GoogleFonts.inter(textStyle: _h20),



      bodyText1: GoogleFonts.inter(textStyle: _h12),



      bodyText2: GoogleFonts.inter(textStyle: _h14),



      overline: GoogleFonts.inter(textStyle: _h32),



    ),*/

    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,

      secondary: AppColors
          .secondaryColor, // on light theme surface = Colors.white by default
    ).copyWith(secondary: AppColors.secondaryColor),
  );
}
