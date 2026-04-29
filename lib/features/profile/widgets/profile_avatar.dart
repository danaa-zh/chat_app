// import 'package:chat_app/core/controllers/profile_controller.dart';
import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.user,
    required this.isEditing,
  });

  final UserModel user;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: AppConstants.avatarRadius,
          backgroundColor: AppColors.primary,
          child: user.photoURL.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    user.photoURL,
                    width: AppConstants.avatarSize,
                    height: AppConstants.avatarSize,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _AvatarFallback(user: user),
                  ),
                )
              : _AvatarFallback(user: user),
        ),
        if (isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: _EditAvatarButton(context: context),
          ),
      ],
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Text(
      user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _EditAvatarButton extends StatelessWidget {
  const _EditAvatarButton({required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.section),
        border: Border.all(
          color: Colors.white,
          width: AppSpacings.xxxs,
        ),
      ),
      child: IconButton(
        onPressed: () => Get.snackbar(
          'Info',
          context.loc.photoUpdateComingSoon,
          snackPosition: SnackPosition.BOTTOM,
        ),
        icon: const Icon(
          Icons.camera_alt,
          size: AppSpacings.section,
          color: Colors.white,
        ),
      ),
    );
  }
}