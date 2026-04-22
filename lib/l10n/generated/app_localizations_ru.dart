// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'AlmaTalk';

  @override
  String get splashLoading => 'Загрузка...';

  @override
  String get loginTitle => 'Добро пожаловать';

  @override
  String get loginSubtitle => 'Войдите, чтобы продолжить';

  @override
  String get emailHint => 'Электронная почта';

  @override
  String get passwordHint => 'Пароль';

  @override
  String get signInButton => 'Войти';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get noAccount => 'Нет аккаунта?';

  @override
  String get signUp => 'Регистрация';

  @override
  String get invalidEmailError => 'Введите корректный email.';

  @override
  String get passwordRequiredError => 'Пароль обязателен.';

  @override
  String get passwordTooShortError => 'Минимум 6 символов.';

  @override
  String get authInvalidCredentials => 'Неверные данные для входа.';

  @override
  String get authUserNotFound => 'Пользователь не найден.';

  @override
  String get authWrongPassword => 'Неверный пароль.';

  @override
  String get authNetworkError => 'Ошибка сети. Проверьте интернет.';

  @override
  String get authUnknownError => 'Что-то пошло не так. Попробуйте снова.';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get signInError => 'Не удалось войти. Попробуйте ещё раз.';

  @override
  String get tabChats => 'Чаты';

  @override
  String get tabFriends => 'Друзья';

  @override
  String get tabFindFriends => 'Найти друзей';

  @override
  String get tabProfile => 'Профиль';

  @override
  String get profileTitle => 'Профиль';

  @override
  String greeting(String name) {
    return 'Привет, $name!';
  }

  @override
  String get email => 'Почта';

  @override
  String get signOut => 'Выйти';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsThemeMode => 'Тема';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get themeModeSystem => 'Системная';

  @override
  String get themeModeLight => 'Светлая';

  @override
  String get themeModeDark => 'Тёмная';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageKazakh => 'Казахский';

  @override
  String get emptyTitle => 'Пока пусто';

  @override
  String get emptySubtitle => 'Контент появится после действий.';
}
