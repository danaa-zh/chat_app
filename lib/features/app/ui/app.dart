// import 'package:chat_app/core/router/app_router.dart';
// import 'package:chat_app/features/chats/ui/chats_tab.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../core/constants/app_constants.dart';
// import '../../../core/router/app_router.dart';
// import '../../../core/theme/app_theme_old.dart';
// import '../../../data/repositories/auth_repository.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import '../bloc/app_bloc.dart';

// /// Корневой виджет приложения.
// ///
// /// Оборачивает всё в:
// /// 1. [BlocProvider] — предоставляет [AppBloc] всем виджетам ниже.
// /// 2. [MaterialApp.router] — настраивает тему, роутер и локализацию.
// ///
// /// Локализация подключена через стандартный механизм Flutter (intl + .arb).
// /// Сгенерированный класс [AppLocalizations] содержит:
// /// - [AppLocalizations.localizationsDelegates] — список всех делегатов,
// ///   включая наш и встроенные (Material, Cupertino, Widgets).
// /// - [AppLocalizations.supportedLocales] — список поддерживаемых языков,
// ///   который автоматически берётся из .arb файлов.
// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Создаём GoRouter один раз.
//     final router = AppRouter.create();

//     return BlocProvider(
//       // Создаём AppBloc и передаём ему AuthRepository.
//       create: (_) => AppBloc(authRepository: AuthRepository.instance),

//       child: MaterialApp.router(
//         // Заголовок приложения (виден в переключателе задач ОС).
//         title: AppConstants.appName,

//         // Убираем баннер «DEBUG» в правом верхнем углу.
//         debugShowCheckedModeBanner: false,

//         // ── Тема ─────────────────────────────────────────────
//         theme: AppTheme.light,
//         darkTheme: AppTheme.dark,
//         themeMode: ThemeMode.system,

//         // ── Навигация (GoRouter) ─────────────────────────────
//         routerConfig: router,

//         // ── Локализация ──────────────────────────────────────
//         // Список поддерживаемых языков — берётся из сгенерированного класса.
//         // Flutter автоматически определяет их из .arb файлов (en, ru).
//         supportedLocales: AppLocalizations.supportedLocales,

//         // Делегаты — говорят Flutter, как загружать строки.
//         // Сгенерированный список уже включает:
//         //   - AppLocalizations.delegate (наши строки из .arb файлов)
//         //   - GlobalMaterialLocalizations.delegate (встроенные строки Material)
//         //   - GlobalCupertinoLocalizations.delegate (iOS-стиль виджеты)
//         //   - GlobalWidgetsLocalizations.delegate (направление текста и т.д.)
//         localizationsDelegates: AppLocalizations.localizationsDelegates,
//       ),
//     );
//   }
// }

