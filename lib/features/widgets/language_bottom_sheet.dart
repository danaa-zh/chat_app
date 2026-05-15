import 'package:chat_app/core/controllers/language_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  static void show() {
    Get.bottomSheet(
      const LanguageBottomSheet(),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LanguageController>();

    return Padding(
      padding: const EdgeInsets.all(AppPaddings.block),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacings.lg),
          Text(
            context.loc.selectLanguage,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacings.lg),
          ...LanguageController.supportedLocales.map((locale) {
            return Obx(() {
              final isSelected =
                  controller.currentLocale.value.languageCode ==
                  locale.languageCode;
              return ListTile(
                leading: Text(
                  LanguageController.localeFlags[locale.languageCode] ?? '',
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(
                  LanguageController.localeLabels[locale.languageCode] ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  controller.changeLocale(locale);
                  Get.back();
                },
              );
            });
          }),
          const SizedBox(height: AppSpacings.lg),
        ],
      ),
    );
  }
}