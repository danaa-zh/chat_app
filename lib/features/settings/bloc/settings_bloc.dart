// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Events
// abstract class SettingsEvent {}

// class ThemeModeChanged extends SettingsEvent {
//   final ThemeMode mode;
//   ThemeModeChanged(this.mode);
// }

// class LanguageChanged extends SettingsEvent {
//   final String languageCode;
//   LanguageChanged(this.languageCode);
// }

// // States
// class SettingsState {
//   final ThemeMode themeMode;
//   final String languageCode;

//   SettingsState({
//     required this.themeMode,
//     required this.languageCode,
//   });

//   SettingsState copyWith({
//     ThemeMode? themeMode,
//     String? languageCode,
//   }) {
//     return SettingsState(
//       themeMode: themeMode ?? this.themeMode,
//       languageCode: languageCode ?? this.languageCode,
//     );
//   }
// }

// // Bloc
// class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
//   SettingsBloc() : super(SettingsState(
//     themeMode: ThemeMode.system,
//     languageCode: 'en',
//   )) {
//     on<ThemeModeChanged>((event, emit) {
//       emit(state.copyWith(themeMode: event.mode));
//     });

//     on<LanguageChanged>((event, emit) {
//       emit(state.copyWith(languageCode: event.languageCode));
//     });
//   }
// }
