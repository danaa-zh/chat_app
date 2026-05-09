import 'package:chat_app/core/controllers/home_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSearchResults extends StatelessWidget {
  const HomeSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.block,
        vertical: AppPaddings.sm,
      ),
      child: Row(
        children: [
          Obx(
            () => Text(
              context.loc.foundResults(controller.filteredChats.length),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: controller.clearSearch,
            child: Text(
              context.loc.clear,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
