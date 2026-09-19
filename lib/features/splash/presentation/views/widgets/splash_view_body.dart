import 'package:bookly/core/utils/app_router.dart';
import 'package:bookly/features/auth/data/repos/auth_repo_impl.dart';
import 'package:bookly/features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/assets_manager.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateNext();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Image.asset(AssetsManager.logo),
        ),
        SizedBox(height: 16.h),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 9),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }

  /// `go` rather than `push` so the splash is replaced instead of being left
  /// on the back stack.
  void navigateNext() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final isSignedIn = AuthRepoImpl(FirebaseAuth.instance).currentUser != null;
      GoRouter.of(context).go(
        isSignedIn ? AppRouter.kHomeView : AppRouter.kLoginView,
      );
    });
  }
}
