// import 'package:flutter_bloc/flutter_bloc.dart';

// // Events
// abstract class FindFriendsEvent {}

// class SearchUsersChanged extends FindFriendsEvent {
//   final String query;
//   SearchUsersChanged(this.query);
// }

// class AddFriendPressed extends FindFriendsEvent {
//   final String userId;
//   AddFriendPressed(this.userId);
// }

// // States
// abstract class FindFriendsState {}

// class FindFriendsInitial extends FindFriendsState {}

// class FindFriendsLoading extends FindFriendsState {}

// class FindFriendsLoaded extends FindFriendsState {
//   final List<UserSearchResult> results;
//   FindFriendsLoaded(this.results);
// }

// class FindFriendsEmpty extends FindFriendsState {}

// class FindFriendsError extends FindFriendsState {
//   final String message;
//   FindFriendsError(this.message);
// }

// // Model
// class UserSearchResult {
//   final String id;
//   final String name;
//   final String email;
//   final String? avatarUrl;
//   final bool isFriend;

//   UserSearchResult({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.avatarUrl,
//     this.isFriend = false,
//   });
// }

// // Bloc
// class FindFriendsBloc extends Bloc<FindFriendsEvent, FindFriendsState> {
//   FindFriendsBloc() : super(FindFriendsInitial()) {
//     on<SearchUsersChanged>(_onSearchChanged);
//     on<AddFriendPressed>(_onAddFriend);
//   }

//   void _onSearchChanged(SearchUsersChanged event, Emitter<FindFriendsState> emit) async {
//     if (event.query.isEmpty) {
//       emit(FindFriendsInitial());
//       return;
//     }

//     emit(FindFriendsLoading());

//     // Mock search logic
//     await Future.delayed(const Duration(milliseconds: 500));
    
//     final mockUsers = [
//       UserSearchResult(id: '1', name: 'Alice Freeman', email: '@alice_f'),
//       UserSearchResult(id: '2', name: 'Bob Smith', email: '@bob_smith', isFriend: true),
//       UserSearchResult(id: '3', name: 'Charlie Brown', email: '@charlie_b'),
//     ];

//     final results = mockUsers
//         .where((u) => u.name.toLowerCase().contains(event.query.toLowerCase()))
//         .toList();

//     if (results.isEmpty) {
//       emit(FindFriendsEmpty());
//     } else {
//       emit(FindFriendsLoaded(results));
//     }
//   }

//   void _onAddFriend(AddFriendPressed event, Emitter<FindFriendsState> emit) {
//     // Add friend logic
//   }
// }
