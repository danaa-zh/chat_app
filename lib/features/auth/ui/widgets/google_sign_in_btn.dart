// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_spacings.dart';
// import '../../../../core/constants/asset_paths.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';

// class GoogleSignInButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final bool isLoading;

//   const GoogleSignInButton({
//     super.key,
//     required this.onPressed,
//     this.isLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;

//     return OutlinedButton.icon(
//       onPressed: isLoading ? null : onPressed,
//       icon: isLoading
//           ? const SizedBox(
//               height: AppSpacings.section,
//               width: AppSpacings.section,
//               child: CircularProgressIndicator(strokeWidth: 2),
//             )
//           : Image.asset(
//               AssetPaths.googleIcon,
//               height: AppSpacings.section,
//               width: AppSpacings.section,
//             ),
//       label: Text(loc.signInWithGoogle),
//       style: OutlinedButton.styleFrom(
//         minimumSize: const Size(double.infinity, AppSpacings.jumbo),
//       ),
//     );
//   }
// }