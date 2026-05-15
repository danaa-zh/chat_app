import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageStatus extends StatelessWidget {
  final MessageModel message;

  const MessageStatus({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacings.lg),
      child: Icon(
        message.isRead ? Icons.done_all : Icons.done,
        size: AppSpacings.md,
        color: message.isRead ? AppColors.primary : AppColors.textSecondary,
      ),
    );
  }
}
