import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';
import '../constants/app_paddings.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get light => _buildTheme(isDark: false);
  static ThemeData get dark => _buildTheme(isDark: true);

  static ThemeData _buildTheme({required bool isDark}) {
    final ColorScheme colorScheme = isDark
        ? const ColorScheme.dark(
            primary: AppColors.primary,
            onPrimary: AppColors.onPrimary,
            secondary: AppColors.secondary,
            onSecondary: AppColors.onSecondary,
            tertiary: AppColors.tertiary,
            onTertiary: AppColors.textPrimary,
            error: AppColors.error,
          ).copyWith(
            surface: AppColors.darkSurface,
            onSurface: AppColors.darkTextPrimary,
            outline: AppColors.darkOutline,
          )
        : const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.onPrimary,
            secondary: AppColors.secondary,
            onSecondary: AppColors.onSecondary,
            tertiary: AppColors.tertiary,
            onTertiary: AppColors.textPrimary,
            error: AppColors.error,
          ).copyWith(
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
            outline: AppColors.outline,
          );

    final textTheme = GoogleFonts.manropeTextTheme(
      const TextTheme(
        displayLarge: AppTextStyles.splashTitle,
        displayMedium: AppTextStyles.authTitle,
        titleLarge: AppTextStyles.appBarTitle,
        titleMedium: AppTextStyles.sectionTitle,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.bodySecondary,
        bodySmall: AppTextStyles.timestamp,
        labelLarge: AppTextStyles.button,
        labelMedium: AppTextStyles.settingsTile,
        labelSmall: AppTextStyles.navLabel,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isDark ? AppColors.darkBackground : AppColors.background,
      dividerColor: isDark ? AppColors.darkDivider : AppColors.divider,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.background,
        foregroundColor:
            isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: AppConstants.appBarHeight,
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.appBarAction,
        ),
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          side: BorderSide(
            color: isDark ? AppColors.darkDivider : AppColors.divider,
            width: AppConstants.defaultBorderWidth,
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, AppConstants.defaultButtonHeight),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppPaddings.card),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, AppConstants.defaultButtonHeight),
          foregroundColor: colorScheme.secondary,
          textStyle: textTheme.labelLarge,
          side: BorderSide(
            color: isDark ? AppColors.darkOutline : AppColors.outline,
            width: AppConstants.defaultBorderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppPaddings.card),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.secondary,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:
            isDark ? AppColors.darkInputBackground : AppColors.inputBackground,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
        ),
        labelStyle: textTheme.bodyMedium,
        prefixIconColor: isDark ? AppColors.darkNavActive : AppColors.navActive,
        suffixIconColor: isDark ? AppColors.darkNavActive : AppColors.navActive,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.inputContentHorizontal,
          vertical: AppPaddings.inputContentVertical,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkOutline : AppColors.outline,
            width: AppConstants.defaultBorderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkOutline : AppColors.outline,
            width: AppConstants.defaultBorderWidth,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
        selectedItemColor: isDark ? AppColors.darkNavActive : AppColors.navActive,
        unselectedItemColor:
            isDark ? AppColors.darkNavInactive : AppColors.navInactive,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: isDark
            ? AppColors.darkChipSelected
            : AppColors.chipSelected,
        elevation: 0,
        height: AppConstants.bottomNavHeight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return textTheme.labelSmall?.copyWith(
            color: states.contains(WidgetState.selected)
                ? (isDark ? AppColors.darkNavActive : AppColors.navActive)
                : (isDark ? AppColors.darkNavInactive : AppColors.navInactive),
          );
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? AppColors.darkChipUnselected : AppColors.chipUnselected,
        selectedColor:
            isDark ? AppColors.darkChipSelected : AppColors.chipSelected,
        side: BorderSide(
          color: isDark ? AppColors.darkDivider : AppColors.divider,
          width: AppConstants.defaultBorderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        ),
        labelStyle: textTheme.labelMedium!,
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.darkDivider : AppColors.divider,
        thickness: AppConstants.defaultBorderWidth,
      ),
      listTileTheme: ListTileThemeData(
        tileColor:
            isDark ? AppColors.darkSettingsTileBg : AppColors.settingsTileBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.listTileHorizontal,
          vertical: AppPaddings.listTileVertical,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.secondary,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSecondary,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(colorScheme.primary),
        trackColor: WidgetStatePropertyAll(colorScheme.primary.withValues(alpha: 0.4)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const StadiumBorder(),
      ),
    );
  }
}