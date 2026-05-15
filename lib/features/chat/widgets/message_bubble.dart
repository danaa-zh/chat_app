import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/features/chat/widgets/message_content.dart';
import 'package:chat_app/features/chat/widgets/message_status.dart';
import 'package:chat_app/features/chat/widgets/message_time.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMyMessage;
  final bool showTime;
  final String timeText;
  final VoidCallback? onLongPress;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMyMessage,
    required this.showTime,
    required this.timeText,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showTime) MessageTime(timeText: timeText),
        Row(
          mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMyMessage) const SizedBox(width: AppSpacings.sm),
            Flexible(
              child: GestureDetector(
                onLongPress: onLongPress,
                child: MessageContent(message: message, isMyMessage: isMyMessage),
              ),
            ),
            if (isMyMessage) ...[
              const SizedBox(width: AppSpacings.sm),
              MessageStatus(message: message),
            ],
          ],
        ),
      ],
    );
  }
}
