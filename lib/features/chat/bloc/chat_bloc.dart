// import 'package:flutter_bloc/flutter_bloc.dart';

// // Events
// abstract class ChatEvent {}

// class LoadMessages extends ChatEvent {
//   final String chatId;
//   LoadMessages(this.chatId);
// }

// class SendMessagePressed extends ChatEvent {
//   final String text;
//   SendMessagePressed(this.text);
// }

// // States
// abstract class ChatState {}

// class ChatInitial extends ChatState {}

// class ChatLoading extends ChatState {}

// class ChatLoaded extends ChatState {
//   final List<Message> messages;
//   final ChatContact contact;
//   ChatLoaded(this.messages, this.contact);
// }

// class ChatError extends ChatState {
//   final String message;
//   ChatError(this.message);
// }

// // Models
// class Message {
//   final String id;
//   final String text;
//   final DateTime timestamp;
//   final bool isOutgoing;
//   final bool isRead;

//   Message({
//     required this.id,
//     required this.text,
//     required this.timestamp,
//     required this.isOutgoing,
//     this.isRead = false,
//   });
// }

// class ChatContact {
//   final String id;
//   final String name;
//   final String? avatarUrl;
//   final bool isOnline;

//   ChatContact({
//     required this.id,
//     required this.name,
//     this.avatarUrl,
//     this.isOnline = false,
//   });
// }

// // Bloc
// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   ChatBloc() : super(ChatInitial()) {
//     on<LoadMessages>(_onLoadMessages);
//     on<SendMessagePressed>(_onSendMessage);
//   }

//   final List<Message> _mockMessages = [
//     Message(
//       id: '1',
//       text: 'Hey! How are you?',
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       isOutgoing: false,
//     ),
//     Message(
//       id: '2',
//       text: 'I am good, thanks! How about you?',
//       timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
//       isOutgoing: true,
//       isRead: true,
//     ),
//     Message(
//       id: '3',
//       text: 'Doing great! Want to grab coffee later?',
//       timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
//       isOutgoing: false,
//     ),
//   ];

//   void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
//     emit(ChatLoading());
//     // Simulate loading
//     await Future.delayed(const Duration(milliseconds: 500));
    
//     final contact = ChatContact(
//       id: event.chatId,
//       name: 'Alice Freeman',
//       isOnline: true,
//     );
    
//     emit(ChatLoaded(List.from(_mockMessages.reversed), contact));
//   }

//   void _onSendMessage(SendMessagePressed event, Emitter<ChatState> emit) {
//     if (state is ChatLoaded) {
//       final currentState = state as ChatLoaded;
//       final newMessage = Message(
//         id: DateTime.now().toString(),
//         text: event.text,
//         timestamp: DateTime.now(),
//         isOutgoing: true,
//       );
      
//       final updatedMessages = List<Message>.from(currentState.messages)..insert(0, newMessage);
//       emit(ChatLoaded(updatedMessages, currentState.contact));
//     }
//   }
// }
