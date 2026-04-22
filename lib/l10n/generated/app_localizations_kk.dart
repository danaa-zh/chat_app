// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appName => 'AlmaTalk';

  @override
  String get splashLoading => 'Жүктелуде...';

  @override
  String get loginTitle => 'Қош келдіңіз';

  @override
  String get loginSubtitle => 'Жалғастыру үшін кіріңіз';

  @override
  String get emailHint => 'Электрондық пошта';

  @override
  String get passwordHint => 'Құпиясөз';

  @override
  String get signInButton => 'Кіру';

  @override
  String get forgotPassword => 'Құпиясөзді ұмыттыңыз ба?';

  @override
  String get noAccount => 'Аккаунтыңыз жоқ па?';

  @override
  String get signUp => 'Тіркелу';

  @override
  String get invalidEmailError => 'Дұрыс email енгізіңіз.';

  @override
  String get passwordRequiredError => 'Құпиясөз міндетті.';

  @override
  String get passwordTooShortError => 'Құпиясөз кемі 6 таңбадан тұруы керек.';

  @override
  String get authInvalidCredentials => 'Кіру деректері қате.';

  @override
  String get authUserNotFound => 'Пайдаланушы табылмады.';

  @override
  String get authWrongPassword => 'Құпиясөз қате.';

  @override
  String get authNetworkError => 'Желі қатесі. Интернетті тексеріңіз.';

  @override
  String get authUnknownError => 'Қате орын алды. Қайтадан көріңіз.';

  @override
  String get signInWithGoogle => 'Google арқылы кіру';

  @override
  String get signInError => 'Кіру сәтсіз аяқталды. Қайта көріңіз.';

  @override
  String get tabChats => 'Чаттар';

  @override
  String get tabFriends => 'Достар';

  @override
  String get tabFindFriends => 'Достарды табу';

  @override
  String get tabProfile => 'Профиль';

  @override
  String get profileTitle => 'Профиль';

  @override
  String greeting(String name) {
    return 'Сәлем, $name!';
  }

  @override
  String get email => 'Электрондық пошта';

  @override
  String get signOut => 'Шығу';

  @override
  String get settingsTitle => 'Параметрлер';

  @override
  String get settingsThemeMode => 'Тақырып режимі';

  @override
  String get settingsLanguage => 'Тіл';

  @override
  String get themeModeSystem => 'Жүйелік';

  @override
  String get themeModeLight => 'Жарық';

  @override
  String get themeModeDark => 'Қараңғы';

  @override
  String get languageEnglish => 'Ағылшын';

  @override
  String get languageRussian => 'Орыс';

  @override
  String get languageKazakh => 'Қазақ';

  @override
  String get emptyTitle => 'Әзірге бос';

  @override
  String get emptySubtitle => 'Әрекеттен кейін контент пайда болады.';
}
