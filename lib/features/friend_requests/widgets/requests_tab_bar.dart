import 'package:chat_app/core/controllers/friend_requests_controller.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestsTabBar extends StatelessWidget {
  final FriendRequestsController controller;

  const RequestsTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppPaddings.block),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Obx(() => Row(
            children: [
              _TabButton(
                icon: Icons.inbox,
                label: context.loc.receivedRequests(controller.receivedRequests.length),
                isSelected: controller.selectedTabIndex == 0,
                onTap: () => controller.changeTab(0),
              ),
              _TabButton(
                icon: Icons.send,
                label: context.loc.sentRequests(controller.sentRequests.length),
                isSelected: controller.selectedTabIndex == 1,
                onTap: () => controller.changeTab(1),
              ),
            ],
          )),
    );
  }
}

class _TabButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({required this.icon, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : AppColors.textSecondary;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacings.md),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: AppSpacings.sm),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
