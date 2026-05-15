import 'package:chat_app/core/controllers/language_controller.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/core/router/app_pages.dart';
import 'package:chat_app/core/theme/app_theme.dart';
import 'package:chat_app/l10n/generated/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController(), permanent: true);
  Get.put(LanguageController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final langController = Get.find<LanguageController>();
      return GetMaterialApp(
        title: "AlmaTalk",
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        locale: langController.currentLocale.value,
        fallbackLocale: const Locale('en'),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('kk'), Locale('ru')],
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
