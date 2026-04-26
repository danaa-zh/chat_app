import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/constants/asset_paths.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:chat_app/core/router/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacings.hero),
                Center(
                  child: Image.asset(
                    AssetPaths.logoMain,
                    width: AppSpacings.large,
                    height: AppSpacings.large,
                  ),
                ),
                SizedBox(height: AppSpacings.hero),
                Text(
                  context.loc.loginTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: AppSpacings.sm),
                Text(
                  context.loc.loginSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSpacings.screen),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: context.loc.emailAddressHint,
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: context.loc.emailAddressHint,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return context.loc.fieldRequiredError;
                    }
                    if (!GetUtils.isEmail(value!)) {
                      return context.loc.invalidEmailError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSpacings.lg),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: context.loc.passwordHint,
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: context.loc.passwordHint,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return context.loc.passwordRequiredError;
                    }
                    if (value!.length < 6) {
                      return context.loc.passwordTooShortError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSpacings.xl),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: Text(context.loc.forgotPassword),
                  ),
                ),
                SizedBox(height: AppSpacings.xxl),

                Obx(
                  () => ElevatedButton(
                    onPressed: authController.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              authController.signInWithEmailAndPassword(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: authController.isLoading
                        ? const CircularProgressIndicator()
                        : Text(context.loc.signIn),
                  ),
                ),

                SizedBox(height: AppSpacings.lg),

                Obx(() {
                  final error = authController.error;
                  if (error.isEmpty) return const SizedBox.shrink();

                  final isNotFound = authController.isUserNotFound;

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: AppSpacings.md),
                        child: Text(
                          isNotFound ? context.loc.userNotFoundError : error,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (isNotFound) ...[
                        SizedBox(height: AppSpacings.sm),
                        TextButton(
                          onPressed: () => Get.toNamed(AppRoutes.register),
                          child: Text(context.loc.goToRegister),
                        ),
                      ],
                    ],
                  );
                }),

                SizedBox(height: AppSpacings.xxl),

                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacings.md),
                      child: Text(
                        context.loc.orContinueWith,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                SizedBox(height: AppSpacings.xxl),

                Obx(
                  () => OutlinedButton(
                    onPressed: authController.isLoading
                        ? null
                        : () => authController.signInWithGoogle(),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, AppSpacings.fifty),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetPaths.googleIcon,
                          width: AppConstants.googleIconSize,
                          height: AppConstants.googleIconSize,
                        ),
                        SizedBox(width: AppSpacings.md),
                        Text(context.loc.signInWithGoogle),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSpacings.xxl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.loc.dontHaveAccount),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      child: Text(context.loc.signUp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
