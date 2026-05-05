import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'chat_service.dart';

class MessageService {
  final FirebaseFirestore _firestore;
  final ChatService _chats;

  MessageService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _chats = ChatService(firestore: firestore);

  Future<void> sendMessage(MessageModel message) async {
    final chatId = await _chats.createOrGetChat(message.senderId, message.receiverId);
    await _firestore.collection('messages').add(message.toMap());
    await _chats.updateChatLastMessage(chatId, message);
    await _chats.updateUserLastSeen(chatId, message.senderId);

    final chatDoc = await _firestore.collection('chats').doc(chatId).get();
    if (chatDoc.exists) {
      final chat = ChatModel.fromMap(chatDoc.data() as Map<String, dynamic>);
      final currentUnread = chat.getUserCount(message.receiverId);
      await _chats.updateUnreadCount(chatId, message.receiverId, currentUnread + 1);
    }
  }

  Stream<List<MessageModel>> getMessagesStream(String userId1, String userId2) {
    return _firestore.collection('messages').snapshots().asyncMap((snapshot) async {
      final participants = [userId1, userId2]..sort();
      final chatId = '${participants[0]}_${participants[1]}';
      final chatDoc = await _firestore.collection('chats').doc(chatId).get();

      ChatModel? chat;
      if (chatDoc.exists) {
        chat = ChatModel.fromMap(chatDoc.data() as Map<String, dynamic>);
      }

      final messages = <MessageModel>[];
      for (var doc in snapshot.docs) {
        final message = MessageModel.fromMap(doc.data());
        if ((message.senderId == userId1 && message.receiverId == userId2) ||
            (message.senderId == userId2 && message.receiverId == userId1)) {
          bool includeMessage = true;
          if (chat != null) {
            final deletedAt = chat.getUserDeletedAt(userId1);
            if (deletedAt != null && message.timestamp.isBefore(deletedAt)) {
              includeMessage = false;
            }
          }
          if (includeMessage) messages.add(message);
        }
      }
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return messages;
    });
  }

  Future<void> markMessageAsRead(String messageId) async {
    await _firestore.collection('messages').doc(messageId).update({'isRead': true});
  }

  Future<void> deleteMessage(String messageId) async {
    await _firestore.collection('messages').doc(messageId).delete();
  }

  Future<void> editMessage(String messageId, String newContent) async {
    await _firestore.collection('messages').doc(messageId).update({
      'content': newContent,
      'isEdited': true,
      'editedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
