import 'package:bookly/features/home/presentation/views/home_view.dart';
import 'package:bookly/features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/assets_manager.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
initSlidingAnimation();

navigateToHome();

  }




  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
            AssetsManager.logo
        ),
        slidingText(slidingAnimation: slidingAnimation)
      ],
    );
  }

  void initSlidingAnimation() {
    animationController=AnimationController(vsync: this,duration: Duration(seconds: 1));
    slidingAnimation=Tween<Offset>(begin: Offset(0, 9),end: Offset.zero).animate(animationController);
    animationController.forward();
  }
  void navigateToHome() {
    Future.delayed(Duration(seconds: 2),(){
      Get.to(()=>HomeView(),transition: Transition.fade,duration: kTransitionDuration);
    });
  }
}

