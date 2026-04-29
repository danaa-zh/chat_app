import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/widgets/auth_button.dart';
import 'package:chat_app/features/widgets/google_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
// import 'package:chat_app/core/constants/asset_paths.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:chat_app/core/router/app_routes.dart';
// import 'package:chat_app/core/theme/app_theme.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  bool _obsecurePassword = true;
  bool _obsecureConfirmPassword = true;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      context.loc.signUp,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Fill in your details to get started",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSpacings.screen),
                // Display Name Field
                TextFormField(
                  controller: _displayNameController,
                  decoration: InputDecoration(
                    labelText: context.loc.displayNameHint,
                    prefixIcon: const Icon(Icons.person_outline),
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return context.loc.fieldRequiredError;
                    }
                    if (value!.length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSpacings.lg),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: context.loc.emailAddressHint,
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: 'Enter your email',
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
                  obscureText: _obsecurePassword,
                  decoration: InputDecoration(
                    labelText: context.loc.passwordHint,
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obsecurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obsecurePassword = !_obsecurePassword;
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
                SizedBox(height: AppSpacings.lg),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obsecureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: context.loc.confirmPasswordHint,
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: 'Confirm your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obsecureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obsecureConfirmPassword = !_obsecureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return context.loc.fieldRequiredError;
                    }
                    if (value != _passwordController.text) {
                      return context.loc.passwordMismatchError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSpacings.xxl),
                Obx(() => AuthButton(
                  text: context.loc.signUp,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authController.registerWithEmailAndPassword(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        _displayNameController.text.trim(),
                      );
                    }
                  },
                  isLoading: authController.isLoading,
                ),),
                SizedBox(height: AppSpacings.lg),
                const GoogleButton(),
                SizedBox(height: AppSpacings.lg),
                Obx(
                  () => authController.error.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: AppSpacings.md),
                          child: Text(
                            authController.error,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: AppSpacings.xxl),
                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.loc.alreadyHaveAccount),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
                      },
                      child: Text(context.loc.signIn),
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
