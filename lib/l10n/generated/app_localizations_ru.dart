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
  String get splashTagline => 'Мгновенная связь с друзьями';

  @override
  String get splashLoading => 'Загрузка...';

  @override
  String get loginTitle => 'С возвращением';

  @override
  String get loginSubtitle => 'Войдите, чтобы продолжить';

  @override
  String get signIn => 'Войти';

  @override
  String get signUp => 'Регистрация';

  @override
  String get userNotFoundError => 'Аккаунт с таким email не найден.';

  @override
  String get goToRegister => 'Создать аккаунт';

  @override
  String get orContinueWith => 'или войти через';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get sendResetLink => 'Отправить ссылку';

  @override
  String get rememberPassword => 'Вспомнили пароль?';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get dontHaveAccount => 'Нет аккаунта?';

  @override
  String get displayNameHint => 'Отображаемое имя';

  @override
  String get emailAddressHint => 'Электронная почта';

  @override
  String get passwordHint => 'Пароль';

  @override
  String get confirmPasswordHint => 'Подтвердите пароль';

  @override
  String get currentPasswordHint => 'Текущий пароль';

  @override
  String get newPasswordHint => 'Новый пароль';

  @override
  String get confirmNewPasswordHint => 'Подтвердите новый пароль';

  @override
  String get invalidEmailError => 'Введите корректный email.';

  @override
  String get passwordRequiredError => 'Пароль обязателен.';

  @override
  String get passwordTooShortError => 'Пароль должен быть не менее 6 символов.';

  @override
  String get fieldRequiredError => 'Это поле обязательно.';

  @override
  String get passwordMismatchError => 'Пароли не совпадают.';

  @override
  String get authInvalidCredentials => 'Неверные данные. Попробуйте еще раз.';

  @override
  String get authUserNotFound => 'Пользователь не найден.';

  @override
  String get authWrongPassword => 'Неверный пароль.';

  @override
  String get authNetworkError => 'Ошибка сети. Проверьте соединение.';

  @override
  String get authUnknownError => 'Что-то пошло не так. Попробуйте еще раз.';

  @override
  String get authEmailAlreadyInUse => 'Этот email уже зарегистрирован.';

  @override
  String get authWeakPassword => 'Пароль слишком слабый.';

  @override
  String get forgotPasswordSubtitle =>
      'Введите email для получения ссылки на сброс пароля';

  @override
  String get emailSentTitle => 'Email отправлен!';

  @override
  String get emailSentTo => 'Ссылка для сброса пароля отправлена на:';

  @override
  String get emailSentInstruction =>
      'Проверьте почту и следуйте инструкциям для сброса пароля';

  @override
  String get checkSpamNote =>
      'Не получили письмо? Проверьте папку спам или попробуйте снова';

  @override
  String get resendEmail => 'Отправить повторно';

  @override
  String get edit => 'Редактировать';

  @override
  String get cancel => 'Отмена';

  @override
  String get onlineLabel => 'В сети';

  @override
  String get offlineLabel => 'Не в сети';

  @override
  String get emailCannotBeChanged => 'Email нельзя изменить';

  @override
  String get photoUpdateComingSoon => 'Обновление фото скоро появится!';

  @override
  String get chatsTitle => 'Чаты';

  @override
  String get searchConversations => 'Поиск бесед';

  @override
  String get filterAll => 'Все';

  @override
  String get filterUnread => 'Непрочитанные';

  @override
  String get filterRequest => 'Запросы';

  @override
  String get filterActive => 'Активные';

  @override
  String get newChat => 'Новый чат';

  @override
  String get noConversationsYet => 'Нет активных чатов';

  @override
  String get noConversationsDescription => 'Начните общение со своими друзьями';

  @override
  String get viewFriends => 'Список друзей';

  @override
  String get findPeople => 'Найти людей';

  @override
  String get friendsTitle => 'Друзья';

  @override
  String get searchFriends => 'Поиск друзей';

  @override
  String get online => 'в сети';

  @override
  String get offline => 'не в сети';

  @override
  String get lastSeen => 'был(а) недавно';

  @override
  String get addFriend => 'Добавить';

  @override
  String get friendRequestsTitle => 'Запросы в друзья';

  @override
  String get received => 'Полученные';

  @override
  String get sent => 'Отправленные';

  @override
  String get accept => 'Принять';

  @override
  String get decline => 'Отклонить';

  @override
  String get pending => 'В ожидании';

  @override
  String get accepted => 'Принято';

  @override
  String get requestSent => 'Запрос отправлен';

  @override
  String get notificationsTitle => 'Уведомления';

  @override
  String get markAllRead => 'Прочитать все';

  @override
  String get notificationEmptyState => 'У вас пока нет уведомлений';

  @override
  String get notificationWelcomeTitle => 'Добро пожаловать в AlmaTalk!';

  @override
  String get notificationWelcomeDesc =>
      'Мы рады видеть вас здесь. Начните общаться прямо сейчас!';

  @override
  String get notificationRequestAcceptedTitle => 'Запрос принят';

  @override
  String get notificationNewRequestTitle => 'Новый запрос в друзья';

  @override
  String get notificationReminderTitle => 'Напоминание';

  @override
  String get notificationReminderDesc =>
      'Не забудьте проверить непрочитанные сообщения.';

  @override
  String get notificationSystemUpdateTitle => 'Обновление системы';

  @override
  String get notificationSystemUpdateDesc =>
      'Доступна новая версия приложения.';

  @override
  String get typeMessage => 'Введите сообщение...';

  @override
  String get send => 'Отправить';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsAppSettings => 'Настройки приложения';

  @override
  String get settingsAccount => 'Аккаунт';

  @override
  String get settingsThemeMode => 'Режим темы';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Темная';

  @override
  String get settingsChangeLanguage => 'Язык';

  @override
  String get settingsSelectLanguage => 'Выбор языка';

  @override
  String get settingsSave => 'Сохранить изменения';

  @override
  String get settingsSignOut => 'Выйти';

  @override
  String get settingsDeleteAccount => 'Удалить аккаунт';

  @override
  String get changePasswordTitle => 'Изменить пароль';

  @override
  String get updatePassword => 'Обновить пароль';

  @override
  String get passwordUpdatedSuccess => 'Пароль успешно изменен';

  @override
  String get signOut => 'Выйти';

  @override
  String get fullName => 'Полное имя';

  @override
  String get email => 'Электронная почта';

  @override
  String get username => 'Имя пользователя';

  @override
  String get personalInfo => 'Личная информация';

  @override
  String get findPeopleTitle => 'Поиск людей';

  @override
  String get searchUsers => 'Поиск пользователей...';

  @override
  String get noUsersFound => 'Пользователи не найдены';

  @override
  String get searchToFindFriends =>
      'Ищите пользователей, чтобы добавить их в друзья';

  @override
  String get declined => 'Отклонено';

  @override
  String get accountTypePremium => 'Премиум';

  @override
  String get accountTypeStandard => 'Стандартный';

  @override
  String get noChatsFound => 'Чаты не найдены';

  @override
  String get failedToLoadChats => 'Не удалось загрузить чаты';

  @override
  String get failedToLoadMessages => 'Не удалось загрузить сообщения';

  @override
  String get failedToSearchUsers => 'Не удалось найти пользователей';

  @override
  String get errorPasswordsDoNotMatch => 'Пароли не совпадают';

  @override
  String notificationRequestAcceptedDesc(String name) {
    return '$name принял(а) ваш запрос в друзья.';
  }

  @override
  String notificationNewRequestDesc(String name) {
    return 'У вас новый запрос в друзья от $name.';
  }
}
