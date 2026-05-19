# Локализация (intl + .arb)

Проект использует стандартный подход Flutter к локализации:
**пакет `intl`** + файлы `.arb` (Application Resource Bundle) + кодогенерация.

## Структура файлов

```
lib/
  l10n/
    app_en.arb          <- Английские строки (шаблонный файл)
    app_kk.arb          <- Казахские строки
    app_ru.arb          <- Русские строки
    generated/           <- Автоматически сгенерированный код 
      app_localizations.dart
      app_localizations_en.dart
      app_localizations_kk.dart
      app_localizations_ru.dart
l10n.yaml               <- Настройки генератора (в корне проекта)
```
