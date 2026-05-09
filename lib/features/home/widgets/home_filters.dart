import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/controllers/home_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.block,
        vertical: AppPaddings.sm,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Obx(
              () => _FilterChip(
                label: context.loc.allChats(controller.allChats.length),
                onTap: () => controller.setFilter('All'),
                isSelected: controller.activeFilter == 'All',
              ),
            ),
            const SizedBox(width: AppSpacings.sm),
            Obx(
              () => _FilterChip(
                label: context.loc.recentChats(controller.getRecentCount()),
                onTap: () => controller.setFilter('Recent'),
                isSelected: controller.activeFilter == 'Recent',
              ),
            ),
            const SizedBox(width: AppSpacings.sm),
            Obx(
              () => _FilterChip(
                label: context.loc.activeChats(controller.getActiveCount()),
                onTap: () => controller.setFilter('Active'),
                isSelected: controller.activeFilter == 'Active',
              ),
            ),
            const SizedBox(width: AppSpacings.sm),
            Obx(
              () => _FilterChip(
                label: context.loc.unreadChats(controller.getUnreadCount()),
                onTap: () => controller.setFilter('Unread'),
                isSelected: controller.activeFilter == 'Unread',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const _FilterChip({
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacings.sm,
          horizontal: AppSpacings.lg,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(AppRadius.section),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
