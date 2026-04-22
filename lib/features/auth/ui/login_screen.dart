import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/constants/app_spacings.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../bloc/auth_bloc.dart';
import 'widgets/app_text_field.dart';
import 'widgets/auth_footer_link.dart';
import 'widgets/auth_header.dart';
import 'widgets/password_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.isSuccess != current.isSuccess ||
            previous.failure != current.failure,
        listener: (context, state) {
          if (state.isSuccess) {
            context.go(RouteNames.chats);
            return;
          }
          if (state.failure != AuthFailure.none) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(_failureText(loc, state.failure))),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppPaddings.screenHorizontal,
                  AppSpacings.hero,
                  AppPaddings.screenHorizontal,
                  AppSpacings.section,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthHeader(
                      title: loc.loginTitle,
                      subtitle: loc.loginSubtitle,
                    ),
                    const SizedBox(height: AppSpacings.screen),
                    AppTextField(
                      hintText: loc.emailHint,
                      iconPath: AssetPaths.emailIcon,
                      keyboardType: TextInputType.emailAddress,
                      hasError: state.emailError != AuthFieldError.none,
                      onChanged: context.read<AuthBloc>().onEmailChanged,
                    ),
                    if (state.emailError != AuthFieldError.none)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacings.xs),
                        child: Text(
                          _emailErrorText(loc, state.emailError),
                          style: AppTextStyles.timestamp,
                        ),
                      ),
                    const SizedBox(height: AppSpacings.lg),
                    PasswordTextField(
                      hintText: loc.passwordHint,
                      isObscured: state.isPasswordObscured,
                      hasError: state.passwordError != AuthFieldError.none,
                      onChanged: context.read<AuthBloc>().onPasswordChanged,
                      onToggleVisibility:
                          context.read<AuthBloc>().onTogglePasswordVisibility,
                    ),
                    if (state.passwordError != AuthFieldError.none)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacings.xs),
                        child: Text(
                          _passwordErrorText(loc, state.passwordError),
                          style: AppTextStyles.timestamp,
                        ),
                      ),
                    const SizedBox(height: AppSpacings.section),
                    ElevatedButton(
                      onPressed:
                          state.isLoading ? null : context.read<AuthBloc>().onSubmit,
                      child: state.isLoading
                          ? const SizedBox(
                              height: AppSpacings.xxl,
                              width: AppSpacings.xxl,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(loc.signInButton),
                    ),
                    const SizedBox(height: AppSpacings.sm),
                    TextButton(
                      onPressed: () {},
                      child: Text(loc.forgotPassword),
                    ),
                    const SizedBox(height: AppSpacings.lg),
                    AuthFooterLink(
                      leadingText: loc.noAccount,
                      actionText: loc.signUp,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _emailErrorText(AppLocalizations loc, AuthFieldError error) {
    switch (error) {
      case AuthFieldError.invalidEmail:
        return loc.invalidEmailError;
      case AuthFieldError.none:
      case AuthFieldError.requiredPassword:
      case AuthFieldError.shortPassword:
        return '';
    }
  }

  String _passwordErrorText(AppLocalizations loc, AuthFieldError error) {
    switch (error) {
      case AuthFieldError.requiredPassword:
        return loc.passwordRequiredError;
      case AuthFieldError.shortPassword:
        return loc.passwordTooShortError;
      case AuthFieldError.none:
      case AuthFieldError.invalidEmail:
        return '';
    }
  }

  String _failureText(AppLocalizations loc, AuthFailure failure) {
    switch (failure) {
      case AuthFailure.invalidCredentials:
        return loc.authInvalidCredentials;
      case AuthFailure.userNotFound:
        return loc.authUserNotFound;
      case AuthFailure.wrongPassword:
        return loc.authWrongPassword;
      case AuthFailure.network:
        return loc.authNetworkError;
      case AuthFailure.unknown:
        return loc.authUnknownError;
      case AuthFailure.none:
        return '';
    }
  }
}
