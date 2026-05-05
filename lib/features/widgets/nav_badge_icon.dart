import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NavBadgeIcon extends StatelessWidget {
  final IconData icon;
  final int count;

  const NavBadgeIcon({
    super.key,
    required this.icon,
    this.count = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(icon),
        if (count > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              constraints: const BoxConstraints(
                minWidth: AppSpacings.lg,
                minHeight: AppSpacings.lg,
              ),
              child: Text(
                count > 99 ? '99+' : count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppSpacings.sm,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}