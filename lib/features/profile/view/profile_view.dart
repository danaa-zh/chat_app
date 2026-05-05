import 'package:chat_app/core/controllers/profile_controller.dart';
import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/profile/view/widgets/profile_actions_card.dart';
import 'package:chat_app/features/profile/view/widgets/profile_avatar.dart';
import 'package:chat_app/features/profile/view/widgets/profile_info_header.dart';
import 'package:chat_app/features/profile/view/widgets/profile_personal_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.profile),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: controller.toggleEditing,
              child: Text(
                controller.isEditing ? context.loc.cancel : context.loc.edit,
                style: TextStyle(
                  color: controller.isEditing
                      ? AppColors.error
                      : AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final user = controller.currentUser;

        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Column(
            children: [
              ProfileAvatar(user: user, isEditing: controller.isEditing),
              ProfileInfoHeader(
                user: user,
                joinedDate: controller.getJoinedData(),
              ),
              const SizedBox(height: AppSpacings.screen),
              ProfilePersonalCard(controller: controller),
              const SizedBox(height: AppSpacings.screen),
              ProfileActionsCard(controller: controller),
              const SizedBox(height: AppSpacings.section),
              Text(
                AppConstants.appVersion,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        );
      }),
    );
  }
}
