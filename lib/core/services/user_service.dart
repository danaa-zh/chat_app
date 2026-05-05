import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/data/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore;
  UserService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async =>
      _firestore.collection('users').doc(user.id).set(user.toMap());

  Future<UserModel?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.exists ? UserModel.fromMap(doc.data() as Map<String, dynamic>) : null;
  }

  Future<void> updateUserOnlineStatus(String userId, bool isOnline) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      await _firestore.collection('users').doc(userId).update({
        'isOnline': isOnline,
        'lastSeen': Timestamp.now(),
      });
    }
  }

  Future<void> deleteUser(String userId) async =>
      _firestore.collection('users').doc(userId).delete();

  Stream<UserModel?> getUserStream(String userId) =>
      _firestore.collection('users').doc(userId).snapshots()
          .map((doc) => doc.exists ? UserModel.fromMap(doc.data() as Map<String, dynamic>) : null);

  Future<void> updateUser(UserModel user) async =>
      _firestore.collection('users').doc(user.id).update(user.toMap());

  Stream<List<UserModel>> getAllUsersStream() =>
      _firestore.collection('users').snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());
}
