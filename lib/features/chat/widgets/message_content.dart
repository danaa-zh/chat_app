import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageContent extends StatelessWidget {
  final MessageModel message;
  final bool isMyMessage;

  const MessageContent({super.key, required this.message, required this.isMyMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.md, horizontal: AppSpacings.block),
      decoration: BoxDecoration(
        color: isMyMessage ? AppColors.primary : AppColors.card,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.section),
          topRight: Radius.circular(AppRadius.section),
          bottomLeft: Radius.circular(isMyMessage ? AppRadius.section : AppRadius.xs),
          bottomRight: Radius.circular(isMyMessage ? AppRadius.xs : AppRadius.section),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: AppSpacings.lg, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isMyMessage ? Colors.white : AppColors.textPrimary,
                ),
          ),
          if (message.isEdited) ...[
            const SizedBox(height: AppSpacings.xxs),
            Text(
              context.loc.edited,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isMyMessage ? Colors.white.withValues(alpha: 0.7) : AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
