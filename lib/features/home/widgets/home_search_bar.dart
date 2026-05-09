import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/controllers/home_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(AppPaddings.block),
      child: TextField(
        onChanged: controller.onSearchChanged,
        decoration: InputDecoration(
          hintText: context.loc.searchConversations,
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: AppConstants.googleIconSize,
          ),
          suffixIcon: Obx(
            () => controller.searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: controller.clearSearch,
                    icon: const Icon(Icons.clear_rounded),
                  )
                : const SizedBox.shrink(),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSpacings.lg,
            horizontal: AppSpacings.lg,
          ),
        ),
      ),
    );
  }
}
