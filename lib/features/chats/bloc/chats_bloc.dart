// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// enum ChatsFilter { all, unread, request, active }

// class ChatPreview extends Equatable {
//   final String id;
//   final String name;
//   final String lastMessage;
//   final DateTime timestamp;
//   final String? avatarUrl;
//   final int unreadCount;
//   final bool isActive;
//   final bool isRequest;

//   const ChatPreview({
//     required this.id,
//     required this.name,
//     required this.lastMessage,
//     required this.timestamp,
//     this.avatarUrl,
//     this.unreadCount = 0,
//     this.isActive = false,
//     this.isRequest = false,
//   });

//   @override
//   List<Object?> get props => [id, name, lastMessage, timestamp, avatarUrl, unreadCount, isActive, isRequest];
// }

// abstract class ChatsState extends Equatable {
//   const ChatsState();
//   @override
//   List<Object?> get props => [];
// }

// class ChatsLoading extends ChatsState {}

// class ChatsLoaded extends ChatsState {
//   final List<ChatPreview> chats;
//   final ChatsFilter filter;
//   final String searchQuery;

//   const ChatsLoaded({
//     required this.chats,
//     this.filter = ChatsFilter.all,
//     this.searchQuery = '',
//   });

//   @override
//   List<Object?> get props => [chats, filter, searchQuery];

//   List<ChatPreview> get filteredChats {
//     return chats.where((chat) {
//       final matchesSearch = chat.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           chat.lastMessage.toLowerCase().contains(searchQuery.toLowerCase());
      
//       if (!matchesSearch) return false;

//       switch (filter) {
//         case ChatsFilter.all:
//           return true;
//         case ChatsFilter.unread:
//           return chat.unreadCount > 0;
//         case ChatsFilter.request:
//           return chat.isRequest;
//         case ChatsFilter.active:
//           return chat.isActive;
//       }
//     }).toList();
//   }
// }

// class ChatsEmpty extends ChatsState {
//   final String message;
//   const ChatsEmpty(this.message);
//   @override
//   List<Object?> get props => [message];
// }

// class ChatsError extends ChatsState {
//   final String message;
//   const ChatsError(this.message);
//   @override
//   List<Object?> get props => [message];
// }

// class ChatsBloc extends Cubit<ChatsState> {
//   ChatsBloc() : super(ChatsLoading());

//   void loadChats() async {
//     emit(ChatsLoading());
//     try {
//       // Имитация загрузки данных
//       await Future.delayed(const Duration(seconds: 1));
      
//       final mockChats = [
//         ChatPreview(
//           id: '1',
//           name: 'John Doe',
//           lastMessage: 'Hey, how are you?',
//           timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//           unreadCount: 2,
//           isActive: true,
//         ),
//         ChatPreview(
//           id: '2',
//           name: 'Jane Smith',
//           lastMessage: 'The meeting is at 3 PM',
//           timestamp: DateTime.now().subtract(const Duration(hours: 2)),
//           unreadCount: 0,
//           isActive: false,
//         ),
//         ChatPreview(
//           id: '3',
//           name: 'Design Group',
//           lastMessage: 'New mockups are ready!',
//           timestamp: DateTime.now().subtract(const Duration(days: 1)),
//           unreadCount: 0,
//           isRequest: true,
//         ),
//       ];

//       if (mockChats.isEmpty) {
//         emit(const ChatsEmpty('No chats found'));
//       } else {
//         emit(ChatsLoaded(chats: mockChats));
//       }
//     } catch (e) {
//       emit(const ChatsError('Failed to load chats'));
//     }
//   }

//   void updateFilter(ChatsFilter filter) {
//     if (state is ChatsLoaded) {
//       final currentState = state as ChatsLoaded;
//       emit(ChatsLoaded(
//         chats: currentState.chats,
//         filter: filter,
//         searchQuery: currentState.searchQuery,
//       ));
//     }
//   }

//   void updateSearch(String query) {
//     if (state is ChatsLoaded) {
//       final currentState = state as ChatsLoaded;
//       emit(ChatsLoaded(
//         chats: currentState.chats,
//         filter: currentState.filter,
//         searchQuery: query,
//       ));
//     }
//   }
// }
