import 'package:chat_app/core/controllers/profile_controller.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/core/router/app_routes.dart';

class ProfileActionsCard extends StatelessWidget {
  const ProfileActionsCard({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _ActionTile(
            icon: Icons.security,
            iconColor: AppColors.primary,
            title: context.loc.changePasswordTitle,
            onTap: () => Get.toNamed(AppRoutes.changePassword),
          ),
          const Divider(height: 1, color: AppColors.border),
          _ActionTile(
            icon: Icons.delete_forever,
            iconColor: AppColors.error,
            title: context.loc.settingsDeleteAccount,
            onTap: controller.deleteAccount,
          ),
          const Divider(height: 1, color: AppColors.border),
          _ActionTile(
            icon: Icons.logout,
            iconColor: AppColors.error,
            title: context.loc.signOut,
            onTap: controller.signOut,
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}