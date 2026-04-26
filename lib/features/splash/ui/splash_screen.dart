// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../core/constants/app_constants.dart';
// import '../../../core/constants/app_spacings.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/router/route_names.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import '../../../data/repositories/auth_repository.dart';
// import '../bloc/splash_bloc.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import 'package:chat_app/features/ui_kit/ui_kit.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final bgTop = isDark ? AppColors.darkBackground : AppColors.background;
//     final bgMiddle = isDark ? AppColors.darkSurface : AppColors.surface;
//     final bgBottom = isDark ? AppColors.darkChipSelected : AppColors.tertiary;
//     final logoTint = isDark ? AppColors.darkNavActive : AppColors.navActive;
//     final subtitleColor =
//         isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

//     return BlocProvider(
//       create: (_) => SplashBloc(authRepository: AuthRepository.instance),
//       child: BlocListener<SplashBloc, SplashState>(
//         listenWhen: (previous, current) => previous.status != current.status,
//         listener: (context, state) {
//           if (state.status == SplashStatus.authenticated) {
//             context.go(RouteNames.chats);
//             return;
//           }
//           if (state.status == SplashStatus.unauthenticated) {
//             context.go(RouteNames.login);
//           }
//         },
//         child: Scaffold(
//           body: DecoratedBox(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [bgTop, bgMiddle, bgBottom],
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: -AppSpacings.section,
//                   right: -AppSpacings.section,
//                   child: Container(
//                     width: AppConstants.splashDecorationSizeLg,
//                     height: AppConstants.splashDecorationSizeLg,
//                     decoration: BoxDecoration(
//                       color: logoTint.withValues(alpha: 0.08),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: AppSpacings.block,
//                   left: -AppSpacings.block,
//                   child: Container(
//                     width: AppConstants.splashDecorationSizeMd,
//                     height: AppConstants.splashDecorationSizeMd,
//                     decoration: BoxDecoration(
//                       color: logoTint.withValues(alpha: 0.06),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SvgPicture.asset(
//                         AssetPaths.chatsIcon,
//                         width: AppConstants.splashLogoSize,
//                         height: AppConstants.splashLogoSize,
//                         colorFilter: ColorFilter.mode(logoTint, BlendMode.srcIn),
//                       ),
//                       const SizedBox(height: AppSpacings.block),
//                       Text(
//                         loc.appName,
//                         style: AppTextStyles.splashTitle,
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: AppSpacings.xs),
//                       Text(
//                         loc.splashTagline,
//                         style: AppTextStyles.splashSubtitle.copyWith(
//                           color: subtitleColor,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: AppSpacings.section),
//                       const AppLoadingIndicator(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
