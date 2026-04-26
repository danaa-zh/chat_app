// /// Константы имён и путей маршрутов.
// ///
// /// Используем константы вместо строк в коде, чтобы:
// /// 1. Автодополнение IDE подсказывало имена.
// /// 2. Опечатка вызовет ошибку компиляции, а не баг в рантайме.
// /// 3. Переименование маршрута — в одном месте.
// class RouteNames {
//   // ── Пути (paths) — используем в context.go() ─────────────────
//   /// Сплэш-экран (начальный маршрут).
//   static const String splash = '/';

//   /// Экран входа.
//   static const String login = '/login';

//   /// Экран регистрации.
//   static const String register = '/register';

//   /// Экран восстановления пароля.
//   static const String forgotPassword = '/forgot-password';

//   static const String chats = '/home/chats';
//   static const String friends = '/home/friends';
//   static const String findFriends = '/home/find-friends';

//   static const String profile = '/home/profile';
//   static const String main = chats;

//   // ── Имена (names) — используем в GoRoute(name: ...) ──────────
//   static const String splashName = 'splash';
//   static const String loginName = 'login';
//   static const String registerName = 'register';
//   static const String chatsName = 'chats';
//   static const String friendsName = 'friends';
//   static const String findFriendsName = 'find_friends';
//   static const String profileName = 'profile';
//   static const String forgotPasswordName = 'forgot_password';
//   static const String mainName = chatsName;
// }
