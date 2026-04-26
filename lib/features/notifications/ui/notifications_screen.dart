// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../../../core/constants/app_paddings.dart';
// // import '../../../core/constants/app_spacings.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import 'package:chat_app/features/widgets/app_empty_state.dart';
// import '../bloc/notifications_bloc.dart';
// import '../widgets/notification_tile.dart';

// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return BlocProvider(
//       create: (_) => NotificationsBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             loc.notificationsTitle,
//             style: AppTextStyles.authTitle.copyWith(fontSize: 20),
//           ),
//           centerTitle: true,
//           backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
//           elevation: 0,
//           actions: [
//             BlocBuilder<NotificationsBloc, NotificationsState>(
//               builder: (context, state) {
//                 if (state is NotificationsLoaded) {
//                   return TextButton(
//                     onPressed: () => context.read<NotificationsBloc>().add(MarkAllReadPressed()),
//                     child: Text(
//                       loc.markAllRead,
//                       style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//                     ),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//             const SizedBox(width: 8),
//           ],
//         ),
//         body: BlocBuilder<NotificationsBloc, NotificationsState>(
//           builder: (context, state) {
//             if (state is NotificationsLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is NotificationsEmpty) {
//               return AppEmptyState(
//                 iconPath: AssetPaths.notificationIcon,
//                 title: loc.notificationEmptyState,
//                 subtitle: '',
//               );
//             }

//             if (state is NotificationsLoaded) {
//               return ListView.builder(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 itemCount: state.notifications.length,
//                 itemBuilder: (context, index) {
//                   final notification = state.notifications[index];
//                   return NotificationTile(
//                     notification: notification,
//                     onDismiss: () => context.read<NotificationsBloc>().add(DismissNotificationPressed(notification.id)),
//                   );
//                 },
//               );
//             }

//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }
