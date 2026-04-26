// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/constants/app_paddings.dart';
// import '../../../core/constants/app_spacings.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import 'package:chat_app/features/widgets/app_empty_state.dart';
// import 'package:chat_app/features/widgets/app_search_field.dart';
// import '../bloc/find_friends_bloc.dart';
// import '../widgets/find_person_tile.dart';

// class FindFriendsScreen extends StatelessWidget {
//   const FindFriendsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return BlocProvider(
//       create: (_) => FindFriendsBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             loc.findPeopleTitle,
//             style: AppTextStyles.authTitle.copyWith(fontSize: 20),
//           ),
//           centerTitle: true,
//           backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         body: Column(
//           children: [
//             // Search Field
//             Padding(
//               padding: const EdgeInsets.all(AppPaddings.screenHorizontal),
//               child: Builder(
//                 builder: (context) => AppSearchField(
//                   hintText: loc.searchUsers,
//                   onChanged: (value) {
//                     context.read<FindFriendsBloc>().add(SearchUsersChanged(value));
//                   },
//                 ),
//               ),
//             ),
            
//             // Results
//             Expanded(
//               child: BlocBuilder<FindFriendsBloc, FindFriendsState>(
//                 builder: (context, state) {
//                   if (state is FindFriendsLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (state is FindFriendsInitial) {
//                     return AppEmptyState(
//                       iconPath: AssetPaths.searchIcon,
//                       title: loc.findPeople,
//                       subtitle: loc.searchToFindFriends,
//                     );
//                   }

//                   if (state is FindFriendsEmpty) {
//                     return AppEmptyState(
//                       iconPath: AssetPaths.searchIcon,
//                       title: loc.noUsersFound,
//                       subtitle: loc.searchToFindFriends,
//                     );
//                   }

//                   if (state is FindFriendsLoaded) {
//                     return ListView.separated(
//                       padding: const EdgeInsets.only(bottom: AppSpacings.screen),
//                       itemCount: state.results.length,
//                       separatorBuilder: (context, index) => const Divider(height: 1),
//                       itemBuilder: (context, index) {
//                         final user = state.results[index];
//                         return FindPersonTile(
//                           user: user,
//                           onAddFriend: () {
//                             context.read<FindFriendsBloc>().add(AddFriendPressed(user.id));
//                           },
//                         );
//                       },
//                     );
//                   }

//                   if (state is FindFriendsError) {
//                     return Center(child: Text(loc.failedToSearchUsers));
//                   }

//                   // Initial state or empty query
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
