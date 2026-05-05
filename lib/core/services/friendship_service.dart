import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/data/models/friendship_model.dart';
import 'package:chat_app/data/models/notification_model.dart';
import 'notification_service.dart';

class FriendshipService {
  final FirebaseFirestore _firestore;
  final NotificationService _notifications;

  FriendshipService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _notifications = NotificationService(firestore: firestore);

  Future<void> createFriendship(String user1Id, String user2Id) async {
    final ids = [user1Id, user2Id]..sort();
    final friendshipId = '${ids[0]}_${ids[1]}';
    final friendship = FriendshipModel(
      id: friendshipId,
      user1Id: ids[0],
      user2Id: ids[1],
      createdAt: DateTime.now(),
    );
    await _firestore.collection('friendships').doc(friendshipId).set(friendship.toMap());
  }

  Future<void> removeFriendship(String user1Id, String user2Id) async {
    final ids = [user1Id, user2Id]..sort();
    final friendshipId = '${ids[0]}_${ids[1]}';
    await _firestore.collection('friendships').doc(friendshipId).delete();
    await _notifications.notifyUser(
      userId: user2Id,
      title: 'Friend Removed',
      body: 'You are no longer friends',
      type: NotificationType.friendRemoved,
      data: {'userId': user1Id},
    );
  }

  Future<void> blockUser(String blockerId, String blockedId) async {
    final ids = [blockerId, blockedId]..sort();
    final friendshipId = '${ids[0]}_${ids[1]}';
    await _firestore.collection('friendships').doc(friendshipId).update({
      'isBlocked': true,
      'blockedBy': blockerId,
    });
  }

  Future<void> unblockUser(String user1Id, String user2Id) async {
    final ids = [user1Id, user2Id]..sort();
    final friendshipId = '${ids[0]}_${ids[1]}';
    await _firestore.collection('friendships').doc(friendshipId).update({
      'isBlocked': false,
      'blockedBy': null,
    });
  }

  Stream<List<FriendshipModel>> getFriendsStream(String userId) {
    return _firestore.collection('friendships').where('user1Id', isEqualTo: userId).snapshots()
        .asyncMap((snapshot1) async {
      final snapshot2 = await _firestore.collection('friendships').where('user2Id', isEqualTo: userId).get();
      final friendships = [
        ...snapshot1.docs.map((doc) => FriendshipModel.fromMap(doc.data())),
        ...snapshot2.docs.map((doc) => FriendshipModel.fromMap(doc.data())),
      ];
      return friendships.where((f) => !f.isBlocked).toList();
    });
  }

  Future<FriendshipModel?> getFriendships(String userId, String user2Id) async {
    final ids = [userId, user2Id]..sort();
    final friendshipId = '${ids[0]}_${ids[1]}';
    final doc = await _firestore.collection('friendships').doc(friendshipId).get();
    return doc.exists ? FriendshipModel.fromMap(doc.data() as Map<String, dynamic>) : null;
  }

  Future<bool> isUserBlocked(String userId, String otherUserId) async {
    final ids = [userId, otherUserId]..sort();
    final friendshipId = '${ids[0]}_${ids[1]}';
    final doc = await _firestore.collection('friendships').doc(friendshipId).get();
    if (doc.exists) {
      final friendship = FriendshipModel.fromMap(doc.data() as Map<String, dynamic>);
      return friendship.isBlocked;
    }
    return false;
  }

  Future<bool> isUnfriendly(String userId, String otherUserId) async {
    final ids = [userId, otherUserId]..sort();
    final friendshipId = '${ids[0]}_${ids[1]}';
    final doc = await _firestore.collection('friendships').doc(friendshipId).get();
    return !doc.exists || (doc.exists && doc.data() == null);
  }
}
