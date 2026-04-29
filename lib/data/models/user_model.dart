import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String photoURL;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoURL = '',
    this.isOnline = false,
    required this.lastSeen,
    required this.createdAt,
  });

  static final UserModel empty = UserModel(
    id: '',
    email: '',
    displayName: '',
    photoURL: '',
    isOnline: false,
    lastSeen: DateTime.fromMillisecondsSinceEpoch(0),
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  bool get isEmpty => this == empty;
  bool get isNotEmpty => !isEmpty;
  String get fullName => displayName;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'isOnline': isOnline,
      'lastSeen': Timestamp.fromDate(lastSeen),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    DateTime parseDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
      return DateTime.now();
    }

    return UserModel(
      id: map['id'] as String? ?? '',
      email: map['email'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      photoURL: map['photoURL'] as String? ?? '',
      isOnline: map['isOnline'] as bool? ?? false,
      lastSeen: parseDate(map['lastSeen']),
      createdAt: parseDate(map['createdAt']),
    );
  }

  factory UserModel.fromFirebaseUser(User user, {String? displayName}) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: displayName ?? user.displayName ?? 'User',
      photoURL: user.photoURL ?? '',
      isOnline: true,
      lastSeen: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'isOnline': isOnline,
      'lastSeen': lastSeen.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      photoURL: json['photoURL'] as String? ?? '',
      isOnline: json['isOnline'] as bool? ?? false,
      lastSeen:
          DateTime.tryParse(json['lastSeen'] as String? ?? '') ??
          DateTime.now(),
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    displayName,
    photoURL,
    isOnline,
    lastSeen,
    createdAt,
  ];
}
