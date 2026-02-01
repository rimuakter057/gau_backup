import 'package:flutter/material.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/config/app_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  fontFamily: AppConfig.questrial,

  /// AppBar ===============================================
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.black),
  ),

  /// Elevated Button ======================================
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      minimumSize: Size(double.infinity, ResponsiveHelper.height(48)),
      shadowColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(32),
        vertical: ResponsiveHelper.height(16),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8)),
      ),
      foregroundColor: AppColors.white,
      textStyle: GoogleFonts.inter(
        fontSize: ResponsiveHelper.fontSize(16),
        fontWeight: FontWeight.w500,
      ),
    ),
  ),

  /// Outlined Button =====================================
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(
        color: AppColors.primaryColor,
        width: ResponsiveHelper.width(1.5),
      ),
      foregroundColor: AppColors.primaryColor,
      minimumSize: Size(
        ResponsiveHelper.width(186),
        ResponsiveHelper.height(48),
      ),
      padding: ResponsiveHelper.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8)),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: ResponsiveHelper.fontSize(16),
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  /// Text Button =========================================
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryText,
      textStyle: TextStyle(
        fontFamily: AppConfig.questrial,
        fontWeight: FontWeight.w600,
        fontSize: ResponsiveHelper.fontSize(14),
        decoration: TextDecoration.underline,
      ),
    ),
  ),

  /// Icon Theme ==========================================
  iconTheme: const IconThemeData(color: AppColors.black),

  /// InputDecoration Theme ==============================
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.backgroundColor,
    iconColor: AppColors.primaryColor,
    prefixIconColor: AppColors.primaryColor,
    suffixIconColor: AppColors.primaryColor,
    contentPadding: EdgeInsets.symmetric(
      horizontal: ResponsiveHelper.width(15),
      vertical: ResponsiveHelper.height(14),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
      borderSide: BorderSide(color: AppColors.inputBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
      borderSide: BorderSide(color: AppColors.inputBorderColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
      borderSide: BorderSide(color: AppColors.red, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
      borderSide: BorderSide(color: AppColors.errorColor, width: 2),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
      borderSide: BorderSide(color: AppColors.inputBorderColor),
    ),
    hintStyle: GoogleFonts.inter(
      fontSize: ResponsiveHelper.fontSize(12),
      fontWeight: FontWeight.w400,
      color: AppColors.hintColor,
    ),
    errorStyle: GoogleFonts.inter(
      fontSize: ResponsiveHelper.fontSize(12),
      fontWeight: FontWeight.w400,
      color: AppColors.errorColor,
    ),
  ),

  /// Text Theme ==========================================
  textTheme: TextTheme(
    titleLarge: GoogleFonts.inter(
      fontSize: ResponsiveHelper.fontSize(32),
      fontWeight: FontWeight.w700,
      color: AppColors.darkRed,
    ),
    titleMedium: GoogleFonts.playfairDisplay(
      fontSize: ResponsiveHelper.fontSize(20),
      fontWeight: FontWeight.w700,
      color: AppColors.titleColor,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: ResponsiveHelper.fontSize(14),
      fontWeight: FontWeight.w500,
      color: AppColors.bodyMediumText,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: ResponsiveHelper.fontSize(12),
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: ResponsiveHelper.fontSize(12),
      fontWeight: FontWeight.w500,
      color: AppColors.labelTextColor,
    ),
  ),
);
