import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class AuthFooterLink extends StatelessWidget {
  final String leadingText;
  final String actionText;
  final VoidCallback onPressed;

  const AuthFooterLink({
    super.key,
    required this.leadingText,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(leadingText, style: AppTextStyles.bodySecondary),
        TextButton(
          onPressed: onPressed,
          child: Text(actionText),
        ),
      ],
    );
  }
}
