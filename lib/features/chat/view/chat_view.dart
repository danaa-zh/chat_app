import 'package:chat_app/core/controllers/chat_controller.dart';
import 'package:chat_app/features/chat/view/widgets/chat_app_bar.dart';
import 'package:chat_app/features/chat/view/widgets/chat_empty_state.dart';
import 'package:chat_app/features/chat/view/widgets/chat_message_input.dart';
import 'package:chat_app/features/chat/view/widgets/chat_message_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with WidgetsBindingObserver {
  late String chatId;
  late ChatController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    chatId = Get.arguments?['chatId'] ?? '';

    if (!Get.isRegistered<ChatController>(tag: chatId)) {
      Get.put(ChatController(), tag: chatId);
    }
    controller = Get.find<ChatController>(tag: chatId);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        controller.onChatResumed();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        controller.onChatPaused();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(controller: controller, chatId: chatId),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => controller.messages.isEmpty
                ? const ChatEmptyState()
                : ChatMessageList(controller: controller)),
          ),
          ChatMessageInput(controller: controller),
        ],
      ),
    );
  }
}
