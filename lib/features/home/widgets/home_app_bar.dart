import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:chat_app/core/controllers/home_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeController controller;
  final AuthController authController;

  const HomeAppBar({
    super.key,
    required this.controller,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.textPrimary,
      elevation: AppConstants.elevation,
      title: Obx(
        () => Text(
          controller.isSearching
              ? context.loc.searchResults
              : context.loc.messages,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        Obx(
          () => controller.isSearching
              ? IconButton(
                  onPressed: controller.clearSearch,
                  icon: const Icon(Icons.clear_rounded),
                )
              : _NotificationButton(controller: controller),
        ),
        const SizedBox(width: AppSpacings.sm),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NotificationButton extends StatelessWidget {
  final HomeController controller;
  const _NotificationButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final unreadNotifications = controller.getUnreadNotificationsCount();
      return Stack(
        children: [
          IconButton(
            onPressed: controller.openNotifications,
            icon: const Icon(Icons.notifications_outlined),
          ),
          if (unreadNotifications > 0)
            Positioned(
              right: AppSpacings.xs,
              top: AppSpacings.xs,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacings.xxxs,
                  horizontal: AppSpacings.xxs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Text(
                  unreadNotifications > 99
                      ? '99+'
                      : unreadNotifications.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
