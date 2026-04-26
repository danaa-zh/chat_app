// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/constants/app_paddings.dart';
// // import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import '../bloc/settings_bloc.dart';
// import '../widgets/settings_action_tile.dart';
// import '../widgets/settings_radio_tile.dart';
// import '../widgets/settings_section.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(loc.settingsTitle, style: AppTextStyles.authTitle.copyWith(fontSize: 20)),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: AppPaddings.screenHorizontal),
//         child: Column(
//           children: [
//             const SizedBox(height: 16),
            
//             // App Settings Section
//             SettingsSection(
//               title: loc.settingsAppSettings.toUpperCase(),
//               children: [
//                 BlocBuilder<SettingsBloc, SettingsState>(
//                   builder: (context, state) {
//                     return SettingsActionTile(
//                       icon: Icons.palette_outlined,
//                       title: loc.settingsThemeMode,
//                       subtitle: _getThemeName(loc, state.themeMode),
//                       onTap: () => _showThemePicker(context, loc),
//                     );
//                   },
//                 ),
//                 BlocBuilder<SettingsBloc, SettingsState>(
//                   builder: (context, state) {
//                     return SettingsActionTile(
//                       icon: Icons.language_rounded,
//                       title: loc.settingsChangeLanguage,
//                       subtitle: _getLanguageName(state.languageCode),
//                       onTap: () => _showLanguagePicker(context, loc),
//                     );
//                   },
//                 ),
//               ],
//             ),

//             // Account Section
//             SettingsSection(
//               title: loc.settingsAccount.toUpperCase(),
//               children: [
//                 SettingsActionTile(
//                   icon: Icons.lock_outline_rounded,
//                   title: loc.changePasswordTitle,
//                   onTap: () {
//                     // Navigate to change password
//                   },
//                 ),
//                 SettingsActionTile(
//                   icon: Icons.logout_rounded,
//                   title: loc.signOut,
//                   textColor: AppColors.error,
//                   onTap: () {
//                     // Sign out logic
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getThemeName(AppLocalizations loc, ThemeMode mode) {
//     switch (mode) {
//       case ThemeMode.system:
//         return loc.themeSystem;
//       case ThemeMode.light:
//         return loc.themeLight;
//       case ThemeMode.dark:
//         return loc.themeDark;
//     }
//   }

//   String _getLanguageName(String code) {
//     switch (code) {
//       case 'en':
//         return 'English';
//       case 'ru':
//         return 'Русский';
//       case 'kk':
//         return 'Қазақша';
//       default:
//         return 'English';
//     }
//   }

//   void _showThemePicker(BuildContext context, AppLocalizations loc) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (_) {
//         return BlocBuilder<SettingsBloc, SettingsState>(
//           bloc: context.read<SettingsBloc>(),
//           builder: (context, state) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SettingsRadioTile<ThemeMode>(
//                     title: loc.themeSystem,
//                     value: ThemeMode.system,
//                     groupValue: state.themeMode,
//                     onChanged: (mode) {
//                       if (mode != null) {
//                         context.read<SettingsBloc>().add(ThemeModeChanged(mode));
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                   SettingsRadioTile<ThemeMode>(
//                     title: loc.themeLight,
//                     value: ThemeMode.light,
//                     groupValue: state.themeMode,
//                     onChanged: (mode) {
//                       if (mode != null) {
//                         context.read<SettingsBloc>().add(ThemeModeChanged(mode));
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                   SettingsRadioTile<ThemeMode>(
//                     title: loc.themeDark,
//                     value: ThemeMode.dark,
//                     groupValue: state.themeMode,
//                     onChanged: (mode) {
//                       if (mode != null) {
//                         context.read<SettingsBloc>().add(ThemeModeChanged(mode));
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void _showLanguagePicker(BuildContext context, AppLocalizations loc) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (_) {
//         return BlocBuilder<SettingsBloc, SettingsState>(
//           bloc: context.read<SettingsBloc>(),
//           builder: (context, state) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SettingsRadioTile<String>(
//                     title: 'English',
//                     value: 'en',
//                     groupValue: state.languageCode,
//                     onChanged: (code) {
//                       if (code != null) {
//                         context.read<SettingsBloc>().add(LanguageChanged(code));
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                   SettingsRadioTile<String>(
//                     title: 'Русский',
//                     value: 'ru',
//                     groupValue: state.languageCode,
//                     onChanged: (code) {
//                       if (code != null) {
//                         context.read<SettingsBloc>().add(LanguageChanged(code));
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                   SettingsRadioTile<String>(
//                     title: 'Қазақша',
//                     value: 'kk',
//                     groupValue: state.languageCode,
//                     onChanged: (code) {
//                       if (code != null) {
//                         context.read<SettingsBloc>().add(LanguageChanged(code));
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
