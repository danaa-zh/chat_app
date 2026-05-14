import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/controllers/main_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: AppSpacings.xxl,
            offset: const Offset(0, AppSpacings.sm),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => Get.find<MainController>().changeTabIndex(1),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: AppConstants.elevation,
        icon: const Icon(Icons.chat_rounded, size: AppSpacings.xxl),
        label: Text(
          context.loc.newChat,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
