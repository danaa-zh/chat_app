import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/data/models/friend_request_model.dart';
import 'package:chat_app/data/models/notification_model.dart';
import 'notification_service.dart';
import 'friendship_service.dart';

class FriendRequestService {
  final FirebaseFirestore _firestore;
  final NotificationService _notifications;
  final FriendshipService _friendships;

  FriendRequestService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _notifications = NotificationService(firestore: firestore),
        _friendships = FriendshipService(firestore: firestore);

  Future<void> sendFriendRequest(FriendRequestModel request) async {
    await _firestore.collection('friendRequests').doc(request.id).set(request.toMap());
    await _notifications.notifyUser(
      userId: request.receiverId,
      title: 'New Friend Request',
      body: 'You have received a new friend request',
      type: NotificationType.friendRequest,
      data: {'senderId': request.senderId, 'requestId': request.id},
    );
  }

  Future<void> cancelFriendRequest(String requestId) async {
    final doc = await _firestore.collection('friendRequests').doc(requestId).get();
    if (doc.exists) {
      final request = FriendRequestModel.fromMap(doc.data() as Map<String, dynamic>);
      await _firestore.collection('friendRequests').doc(requestId).delete();
      await _notifications.deleteNotificationsByTypeAndUser(
        request.receiverId, NotificationType.friendRequest, request.senderId,
      );
    }
  }

  Future<void> respondToFriendRequest(String requestId, FriendRequestStatus status) async {
    await _firestore.collection('friendRequests').doc(requestId).update({
      'status': status.name,
      'respondedAt': DateTime.now().millisecondsSinceEpoch,
    });

    final doc = await _firestore.collection('friendRequests').doc(requestId).get();
    final request = FriendRequestModel.fromMap(doc.data() as Map<String, dynamic>);

    if (status == FriendRequestStatus.accepted) {
      await _friendships.createFriendship(request.senderId, request.receiverId);
      await _notifications.notifyUser(
        userId: request.senderId,
        title: 'Friend Request Accepted',
        body: 'Your friend request has been accepted',
        type: NotificationType.friendRequestAccepted,
        data: {'userId': request.receiverId},
      );
    } else if (status == FriendRequestStatus.rejected) {
      await _notifications.notifyUser(
        userId: request.senderId,
        title: 'Friend Request Rejected',
        body: 'Your friend request has been rejected',
        type: NotificationType.friendRequestRejected,
        data: {'userId': request.receiverId},
      );
      await _notifications.deleteNotificationsByTypeAndUser(
        request.receiverId, NotificationType.friendRequest, request.senderId,
      );
    }
  }

  Stream<List<FriendRequestModel>> getFriendRequestsStream(String userId) =>
      _firestore.collection('friendRequests')
          .where('receiverId', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => FriendRequestModel.fromMap(doc.data())).toList());

  Stream<List<FriendRequestModel>> getSentFriendRequestsStream(String userId) =>
      _firestore.collection('friendRequests')
          .where('senderId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => FriendRequestModel.fromMap(doc.data())).toList());

  Future<FriendRequestModel?> getFriendRequest(String senderId, String receiverId) async {
    final query = await _firestore.collection('friendRequests')
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .where('status', isEqualTo: 'pending')
        .get();
    return query.docs.isNotEmpty
        ? FriendRequestModel.fromMap(query.docs.first.data())
        : null;
  }
}
