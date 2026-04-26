// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/constants/app_paddings.dart';
// import '../../../core/constants/app_spacings.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import 'package:chat_app/features/widgets/app_empty_state.dart';
// import '../bloc/friend_requests_bloc.dart';
// import '../widgets/friend_request_tile.dart';

// class FriendRequestsScreen extends StatelessWidget {
//   const FriendRequestsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return BlocProvider(
//       create: (_) => FriendRequestsBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             loc.friendRequestsTitle,
//             style: AppTextStyles.authTitle.copyWith(fontSize: 20),
//           ),
//           centerTitle: true,
//           backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             const SizedBox(height: AppSpacings.sm),
//             // Segmented Control
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: AppPaddings.screenHorizontal),
//               child: BlocBuilder<FriendRequestsBloc, FriendRequestsState>(
//                 builder: (context, state) {
//                   int activeIndex = 0;
//                   if (state is FriendRequestsLoaded) activeIndex = state.activeTab;
//                   if (state is FriendRequestsEmpty) activeIndex = state.activeTab;

//                   return Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         _SegmentButton(
//                           label: loc.received,
//                           isActive: activeIndex == 0,
//                           onTap: () => context.read<FriendRequestsBloc>().add(TabChanged(0)),
//                         ),
//                         _SegmentButton(
//                           label: loc.sent,
//                           isActive: activeIndex == 1,
//                           onTap: () => context.read<FriendRequestsBloc>().add(TabChanged(1)),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: AppSpacings.sm),
            
//             // List
//             Expanded(
//               child: BlocBuilder<FriendRequestsBloc, FriendRequestsState>(
//                 builder: (context, state) {
//                   if (state is FriendRequestsLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (state is FriendRequestsEmpty) {
//                     return AppEmptyState(
//                       iconPath: AssetPaths.friendsIcon,
//                       title: loc.notificationEmptyState,
//                       subtitle: '',
//                     );
//                   }

//                   if (state is FriendRequestsLoaded) {
//                     return ListView.separated(
//                       padding: const EdgeInsets.only(bottom: AppSpacings.screen),
//                       itemCount: state.requests.length,
//                       separatorBuilder: (context, index) => const Divider(height: 1),
//                       itemBuilder: (context, index) {
//                         final request = state.requests[index];
//                         return FriendRequestTile(
//                           request: request,
//                           onAccept: () => context.read<FriendRequestsBloc>().add(AcceptRequestPressed(request.id)),
//                           onDecline: () => context.read<FriendRequestsBloc>().add(DeclineRequestPressed(request.id)),
//                           onCancel: () => context.read<FriendRequestsBloc>().add(CancelRequestPressed(request.id)),
//                         );
//                       },
//                     );
//                   }

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

// class _SegmentButton extends StatelessWidget {
//   final String label;
//   final bool isActive;
//   final VoidCallback onTap;

//   const _SegmentButton({
//     required this.label,
//     required this.isActive,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           decoration: BoxDecoration(
//             color: isActive ? AppColors.primary : Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             label,
//             style: TextStyle(
//               color: isActive ? AppColors.onPrimary : AppColors.textSecondary,
//               fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
//               fontSize: 13,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
