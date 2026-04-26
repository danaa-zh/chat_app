// import 'package:chat_app/main.dart';
import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/constants/asset_paths.dart';
import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/theme/app_text_styles.dart';
// import 'package:chat_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:chat_app/core/router/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    // todo: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();

    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
  await Future.delayed(Duration(seconds: 2));

  final authController = Get.put(AuthController(), permanent: true);

  await Future.delayed(Duration(milliseconds: 500));

  if (authController.isAuthenticated) {
    Get.offAllNamed(AppRoutes.main);
  } else {
    Get.offAllNamed(AppRoutes.login);
  }
}

@override
  void dispose() {
    // todo: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController, 
          builder: (context, child){
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetPaths.logo,
                      width: AppConstants.logoWidthHeight,
                      height: AppConstants. logoWidthHeight
                    ),
                    const SizedBox(height: AppSpacings.xxs),
                    Text(
                      context.loc.appName,
                      style: AppTextStyles.textTheme.headlineMedium
                      ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
      )
    );
  }
}
