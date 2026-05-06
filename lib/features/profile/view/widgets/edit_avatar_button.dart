import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class EditAvatarButton extends StatelessWidget {
  const EditAvatarButton({super.key, required this.context});

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