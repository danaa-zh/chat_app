import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RequestsEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const RequestsEmptyState({super.key, required this.icon, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppConstants.emptyIconSize,
              height: AppConstants.emptyIconSize,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.hero),
              ),
              child: Icon(icon, size: AppSpacings.hero, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacings.xl),
            Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacings.sm),
            Text(message, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
