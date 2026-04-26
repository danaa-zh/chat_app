import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextTheme get textTheme => GoogleFonts.poppinsTextTheme().copyWith(
    headlineLarge: GoogleFonts.poppins(
      fontSize: AppSpacings.screen,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: AppSpacings.block,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: AppSpacings.section,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: AppSpacings.xxl,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: AppSpacings.xl,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: AppSpacings.lg,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
    ),
  );

  static TextStyle get appBarTitle => GoogleFonts.poppins(
    fontSize: AppSpacings.xxxl, 
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get elevatedButton => GoogleFonts.poppins(
    fontSize: AppSpacings.xxl,
    fontWeight: FontWeight.w600,
  );
}