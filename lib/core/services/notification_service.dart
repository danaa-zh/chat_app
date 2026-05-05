import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/data/models/notification_model.dart';

class NotificationService {
  final FirebaseFirestore _firestore;
  NotificationService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createNotification(NotificationModel notification) async {
    await _firestore.collection('notifications').doc(notification.id).set(notification.toMap());
  }

  Stream<List<NotificationModel>> getNotificationsStream(String userId) =>
      _firestore.collection('notifications')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => NotificationModel.fromMap(doc.data())).toList());

  Future<void> markNotificationAsRead(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).update({'isRead': true});
  }

  Future<void> markAllNotificationsAsRead(String userId) async {
    final notifications = await _firestore.collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();
    final batch = _firestore.batch();
    for (var doc in notifications.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  Future<void> deleteNotification(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).delete();
  }

  Future<void> deleteNotificationsByTypeAndUser(
    String userId,
    NotificationType type,
    String relatedUserId,
  ) async {
    final notifications = await _firestore.collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('type', isEqualTo: type.name)
        .get();
    final batch = _firestore.batch();
    for (var doc in notifications.docs) {
      final data = doc.data();
      if (data['data'] != null &&
          (data['data']['senderId'] == relatedUserId || data['data']['userId'] == relatedUserId)) {
        batch.delete(doc.reference);
      }
    }
    await batch.commit();
  }

  Future<void> notifyUser({
    required String userId,
    required String title,
    required String body,
    required NotificationType type,
    required Map<String, dynamic> data,
  }) async {
    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      title: title,
      body: body,
      type: type,
      data: data,
      createdAt: DateTime.now(),
    );
    await createNotification(notification);
  }
}
