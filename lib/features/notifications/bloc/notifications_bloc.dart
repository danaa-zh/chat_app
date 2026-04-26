// import 'package:flutter_bloc/flutter_bloc.dart';

// // Events
// abstract class NotificationsEvent {}

// class LoadNotifications extends NotificationsEvent {}

// class MarkAllReadPressed extends NotificationsEvent {}

// class DismissNotificationPressed extends NotificationsEvent {
//   final String id;
//   DismissNotificationPressed(this.id);
// }

// // States
// abstract class NotificationsState {}

// class NotificationsInitial extends NotificationsState {}

// class NotificationsLoading extends NotificationsState {}

// class NotificationsLoaded extends NotificationsState {
//   final List<AppNotification> notifications;
//   NotificationsLoaded(this.notifications);
// }

// class NotificationsEmpty extends NotificationsState {}

// // Models
// enum NotificationType { welcome, requestAccepted, newRequest, reminder, systemUpdate }

// class AppNotification {
//   final String id;
//   final DateTime timestamp;
//   final NotificationType type;
//   final bool isRead;
//   final String? data; // For storing placeholder values like names

//   AppNotification({
//     required this.id,
//     required this.timestamp,
//     required this.type,
//     this.isRead = false,
//     this.data,
//   });
// }

// // Bloc
// class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
//   NotificationsBloc() : super(NotificationsInitial()) {
//     on<LoadNotifications>(_onLoadNotifications);
//     on<MarkAllReadPressed>(_onMarkAllRead);
//     on<DismissNotificationPressed>(_onDismissNotification);
    
//     add(LoadNotifications());
//   }

//   final List<AppNotification> _mockNotifications = [
//     AppNotification(
//       id: '1',
//       timestamp: DateTime.now().subtract(const Duration(days: 2)),
//       type: NotificationType.welcome,
//     ),
//     AppNotification(
//       id: '2',
//       timestamp: DateTime.now().subtract(const Duration(hours: 5)),
//       type: NotificationType.systemUpdate,
//     ),
//     AppNotification(
//       id: '3',
//       timestamp: DateTime.now().subtract(const Duration(hours: 1)),
//       type: NotificationType.newRequest,
//       data: 'Alice',
//     ),
//     AppNotification(
//       id: '4',
//       timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
//       type: NotificationType.requestAccepted,
//       data: 'Bob',
//     ),
//     AppNotification(
//       id: '5',
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       type: NotificationType.reminder,
//     ),
//   ];

//   void _onLoadNotifications(LoadNotifications event, Emitter<NotificationsState> emit) {
//     emit(NotificationsLoading());
//     if (_mockNotifications.isEmpty) {
//       emit(NotificationsEmpty());
//     } else {
//       emit(NotificationsLoaded(List.from(_mockNotifications)));
//     }
//   }

//   void _onMarkAllRead(MarkAllReadPressed event, Emitter<NotificationsState> emit) {
//     // Logic to mark all as read
//   }

//   void _onDismissNotification(DismissNotificationPressed event, Emitter<NotificationsState> emit) {
//     _mockNotifications.removeWhere((n) => n.id == event.id);
//     add(LoadNotifications());
//   }
// }
