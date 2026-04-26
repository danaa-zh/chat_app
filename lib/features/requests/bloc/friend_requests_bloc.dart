// import 'package:flutter_bloc/flutter_bloc.dart';

// // Events
// abstract class FriendRequestsEvent {}

// class TabChanged extends FriendRequestsEvent {
//   final int tabIndex;
//   TabChanged(this.tabIndex);
// }

// class AcceptRequestPressed extends FriendRequestsEvent {
//   final String requestId;
//   AcceptRequestPressed(this.requestId);
// }

// class DeclineRequestPressed extends FriendRequestsEvent {
//   final String requestId;
//   DeclineRequestPressed(this.requestId);
// }

// class CancelRequestPressed extends FriendRequestsEvent {
//   final String requestId;
//   CancelRequestPressed(this.requestId);
// }

// // States
// abstract class FriendRequestsState {}

// class FriendRequestsInitial extends FriendRequestsState {}

// class FriendRequestsLoading extends FriendRequestsState {}

// class FriendRequestsLoaded extends FriendRequestsState {
//   final List<FriendRequest> requests;
//   final int activeTab; // 0 for Received, 1 for Sent
  
//   FriendRequestsLoaded(this.requests, this.activeTab);
// }

// class FriendRequestsEmpty extends FriendRequestsState {
//   final int activeTab;
//   FriendRequestsEmpty(this.activeTab);
// }

// // Models
// enum RequestStatus { pending, accepted, declined }

// class FriendRequest {
//   final String id;
//   final String userId;
//   final String name;
//   final String email;
//   final String? avatarUrl;
//   final DateTime timestamp;
//   final RequestStatus status;
//   final bool isReceived;

//   FriendRequest({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.email,
//     this.avatarUrl,
//     required this.timestamp,
//     required this.status,
//     required this.isReceived,
//   });
// }

// // Bloc
// class FriendRequestsBloc extends Bloc<FriendRequestsEvent, FriendRequestsState> {
//   FriendRequestsBloc() : super(FriendRequestsInitial()) {
//     on<TabChanged>(_onTabChanged);
//     on<AcceptRequestPressed>(_onAcceptRequest);
//     on<DeclineRequestPressed>(_onDeclineRequest);
//     on<CancelRequestPressed>(_onCancelRequest);
    
//     // Initial load
//     add(TabChanged(0));
//   }

//   final List<FriendRequest> _allMockRequests = [
//     FriendRequest(
//       id: 'r1',
//       userId: 'u1',
//       name: 'Alice Freeman',
//       email: '@alice_f',
//       timestamp: DateTime.now().subtract(const Duration(hours: 2)),
//       status: RequestStatus.pending,
//       isReceived: true,
//     ),
//     FriendRequest(
//       id: 'r2',
//       userId: 'u2',
//       name: 'Bob Smith',
//       email: '@bob_smith',
//       timestamp: DateTime.now().subtract(const Duration(days: 1)),
//       status: RequestStatus.pending,
//       isReceived: false,
//     ),
//   ];

//   void _onTabChanged(TabChanged event, Emitter<FriendRequestsState> emit) {
//     emit(FriendRequestsLoading());
    
//     final filtered = _allMockRequests
//         .where((r) => event.tabIndex == 0 ? r.isReceived : !r.isReceived)
//         .toList();
    
//     if (filtered.isEmpty) {
//       emit(FriendRequestsEmpty(event.tabIndex));
//     } else {
//       emit(FriendRequestsLoaded(filtered, event.tabIndex));
//     }
//   }

//   void _onAcceptRequest(AcceptRequestPressed event, Emitter<FriendRequestsState> emit) {
//     // Logic to accept
//   }

//   void _onDeclineRequest(DeclineRequestPressed event, Emitter<FriendRequestsState> emit) {
//     // Logic to decline
//   }

//   void _onCancelRequest(CancelRequestPressed event, Emitter<FriendRequestsState> emit) {
//     // Logic to cancel
//   }
// }
