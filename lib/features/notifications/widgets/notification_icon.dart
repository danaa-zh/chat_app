import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const NotificationIcon({super.key, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.networkImageSize,
      height: AppConstants.networkImageSize,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.block),
      ),
      child: Icon(icon, color: iconColor, size: AppSpacings.xxl),
    );
  }
}
