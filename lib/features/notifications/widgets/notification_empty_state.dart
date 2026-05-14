import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.blockLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppConstants.emptyIconSize,
              height: AppConstants.emptyIconSize,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Icon(Icons.notifications_outlined, size: AppConstants.infoIconSize, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacings.xxl),
            Text(context.loc.noNotifications, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacings.sm),
            Text(
              context.loc.notificationsEmptyMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
