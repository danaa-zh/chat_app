// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'AlmaTalk';

  @override
  String get splashLoading => 'Loading...';

  @override
  String get loginTitle => 'Welcome';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get emailHint => 'Email address';

  @override
  String get passwordHint => 'Password';

  @override
  String get signInButton => 'Sign In';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get invalidEmailError => 'Please enter a valid email.';

  @override
  String get passwordRequiredError => 'Password is required.';

  @override
  String get passwordTooShortError => 'Password must be at least 6 characters.';

  @override
  String get authInvalidCredentials => 'Invalid credentials. Please try again.';

  @override
  String get authUserNotFound => 'User not found.';

  @override
  String get authWrongPassword => 'Wrong password.';

  @override
  String get authNetworkError => 'Network error. Check your connection.';

  @override
  String get authUnknownError => 'Something went wrong. Please try again.';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get signInError => 'Sign-in failed. Please try again.';

  @override
  String get tabChats => 'Chats';

  @override
  String get tabFriends => 'Friends';

  @override
  String get tabFindFriends => 'Find Friends';

  @override
  String get tabProfile => 'Profile';

  @override
  String get profileTitle => 'Profile';

  @override
  String greeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get email => 'Email';

  @override
  String get signOut => 'Sign Out';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsThemeMode => 'Theme mode';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageKazakh => 'Kazakh';

  @override
  String get emptyTitle => 'Nothing here yet';

  @override
  String get emptySubtitle => 'Content will appear after actions.';
}
