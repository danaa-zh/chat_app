import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/asset_paths.dart';
import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:chat_app/core/extensions/context_extention.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    
    return Obx(
      () => OutlinedButton(
        onPressed: authController.isLoading
            ? null
            : () => authController.signInWithGoogle(),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(
            double.infinity,
            AppSpacings.fifty,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetPaths.googleIcon,
              width: AppConstants.googleIconSize,
              height: AppConstants.googleIconSize,
            ),
            SizedBox(width: AppSpacings.md),
            Text(
              context.loc.signInWithGoogle,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}