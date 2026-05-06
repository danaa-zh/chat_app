import 'package:flutter/material.dart';
import 'package:chat_app/l10n/generated/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
  
  // Also add theme for convenience
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  // AppColors get appColors => AppTheme.appColors;
}