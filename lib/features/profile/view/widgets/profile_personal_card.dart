import 'package:chat_app/core/controllers/profile_controller.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/features/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/constants/app_paddings.dart';

class ProfilePersonalCard extends StatelessWidget {
  const ProfilePersonalCard({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.section),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.loc.personalInfo,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacings.section),
            TextField(
              controller: controller.displayNameController,
              enabled: controller.isEditing,
              decoration: InputDecoration(
                labelText: context.loc.displayNameHint,
                prefixIcon: const Icon(Icons.person_outlined),
              ),
            ),
            const SizedBox(height: AppSpacings.xxl),
            TextField(
              controller: controller.emailController,
              enabled: false,
              decoration: InputDecoration(
                labelText: context.loc.email,
                prefixIcon: const Icon(Icons.email_outlined),
                helperText: context.loc.emailCannotBeChanged,
              ),
            ),
            if (controller.isEditing) ...[
              const SizedBox(height: AppSpacings.section),
              AuthButton(
                text: context.loc.settingsSave,
                onPressed: controller.updateProfile,
                isLoading: controller.isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}