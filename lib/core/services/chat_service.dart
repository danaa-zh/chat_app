import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/data/models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore;
  ChatService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String> createOrGetChat(String userId1, String userId2) async {
    final participants = [userId1, userId2]..sort();
    final chatId = '${participants[0]}_${participants[1]}';
    final chatRef = _firestore.collection('chats').doc(chatId);
    final chatDoc = await chatRef.get();

    if (!chatDoc.exists) {
      final newChat = ChatModel(
        id: chatId,
        participants: participants,
        unreadCount: {userId1: 0, userId2: 0},
        deletedBy: {userId1: false, userId2: false},
        deletedAt: {userId1: null, userId2: null},
        lastSeenBy: {userId1: DateTime.now(), userId2: DateTime.now()},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await chatRef.set(newChat.toMap());
    } else {
      final existingChat = ChatModel.fromMap(chatDoc.data() as Map<String, dynamic>);
      if (existingChat.isDeletedBy(userId1)) await restoreChatForUser(chatId, userId1);
      if (existingChat.isDeletedBy(userId2)) await restoreChatForUser(chatId, userId2);
    }
    return chatId;
  }

  Stream<List<ChatModel>> getUserChatsStream(String userId) =>
      _firestore.collection('chats')
          .where('participants', arrayContains: userId)
          .orderBy('updatedAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatModel.fromMap(doc.data()))
              .where((chat) => !chat.isDeletedBy(userId))
              .toList());

  Future<void> updateChatLastMessage(String chatId, MessageModel message) async {
    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': message.content,
      'lastMessageTime': message.timestamp.millisecondsSinceEpoch,
      'lastMessageSenderId': message.senderId,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> updateUserLastSeen(String chatId, String userId) async {
    await _firestore.collection('chats').doc(chatId).update({
      'lastSeenBy.$userId': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> deleteChatForUser(String chatId, String userId) async {
    await _firestore.collection('chats').doc(chatId).update({
      'deletedBy.$userId': true,
      'deletedAt.$userId': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> restoreChatForUser(String chatId, String userId) async {
    await _firestore.collection('chats').doc(chatId).update({
      'deletedBy.$userId': false,
    });
  }

  Future<void> updateUnreadCount(String chatId, String userId, int count) async {
    await _firestore.collection('chats').doc(chatId).update({
      'unreadCount.$userId': count,
    });
  }

  Future<void> resetUnreadCount(String chatId, String userId) async {
    await _firestore.collection('chats').doc(chatId).update({
      'unreadCount.$userId': 0,
    });
  }
}
