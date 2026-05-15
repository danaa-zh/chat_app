import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  static const _key = 'locale';
  final _box = GetStorage();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('kk'),
    Locale('ru'),
  ];

  static const Map<String, String> localeLabels = {
    'en': 'English',
    'kk': 'Қазақша',
    'ru': 'Русский',
  };

  static const Map<String, String> localeFlags = {
    'en': '🇬🇧',
    'kk': '🇰🇿',
    'ru': '🇷🇺',
  };

  final Rx<Locale> currentLocale = const Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    currentLocale.value = _resolveInitialLocale();
    Get.updateLocale(currentLocale.value);
  }

  Locale _resolveInitialLocale() {
    // 1. Check saved preference
    final saved = _box.read<String>(_key);
    if (saved != null) {
      return _findSupported(saved) ?? const Locale('en');
    }

    // 2. Check device locale
    final deviceLocale = Get.deviceLocale;
    if (deviceLocale != null) {
      return _findSupported(deviceLocale.languageCode) ?? const Locale('en');
    }

    // 3. Default to English
    return const Locale('en');
  }

  Locale? _findSupported(String languageCode) {
    try {
      return supportedLocales.firstWhere(
        (l) => l.languageCode == languageCode,
      );
    } catch (_) {
      return null;
    }
  }

  void changeLocale(Locale locale) {
    currentLocale.value = locale;
    Get.updateLocale(locale);
    _box.write(_key, locale.languageCode);
  }

  String get currentFlag => localeFlags[currentLocale.value.languageCode] ?? '🇬🇧';
  String get currentLabel => localeLabels[currentLocale.value.languageCode] ?? 'English';
}