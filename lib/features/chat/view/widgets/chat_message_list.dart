import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/controllers/chat_controller.dart';
import 'package:chat_app/features/chat/view/widgets/chat_message_options.dart';
import 'package:chat_app/features/chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessageList extends StatelessWidget {
  final ChatController controller;

  const ChatMessageList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller.scrollController,
      padding: const EdgeInsets.all(AppPaddings.block),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message = controller.messages[index];
        final isMyMessage = controller.isMyMessage(message);
        final showTime =
            index == 0 ||
            controller.messages[index - 1].timestamp
                    .difference(message.timestamp)
                    .inMinutes
                    .abs() >
                5;

        return MessageBubble(
          message: message,
          isMyMessage: isMyMessage,
          showTime: showTime,
          timeText: controller.formatMessageTime(message.timestamp),
          onLongPress: isMyMessage
              ? () => ChatMessageOptions.show(context, controller, message)
              : null,
        );
      },
    );
  }
}
