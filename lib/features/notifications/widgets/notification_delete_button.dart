import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationDeleteButton extends StatelessWidget {
  final VoidCallback onDelete;

  const NotificationDeleteButton({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onDelete,
      icon: Icon(Icons.close, color: AppColors.textSecondary, size: AppSpacings.lg),
    );
  }
}
