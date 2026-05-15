import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MessageTime extends StatelessWidget {
  final String timeText;

  const MessageTime({super.key, required this.timeText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.md),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacings.xxs, horizontal: AppSpacings.md),
          decoration: BoxDecoration(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Text(
            timeText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}
