import 'package:flutter/material.dart';
import 'package:gas_user_app/presentation/custom_widgets/custom_toasts.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:gas_user_app/presentation/pages/splash_page/splash_page_controller.dart';
import 'package:gas_user_app/presentation/util/resources/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ToastContext.context = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    SplashPageController controller = Get.find<SplashPageController>();

    return Scaffold(
      body: Center(
        child: Lottie.asset(
          Assets.animations.splashAnimation.path,
          controller: controller.animationController,
          onLoaded: (composition) {
            controller.onAnimationLoaded(composition);
          },
          repeat: false,
          animate: true,
        ),
      ),
    );
  }
}
