import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: controller.navigateToNext,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Eco pattern wallpaper background
            Image.asset(
              AppImages.splashBg,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.splashBackground,
              ),
            ),

            // 2. Centered App Logo
            Center(
              child: Image.asset(
                AppImages.appLogo,
                width: 194.w,
                height: 218.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.bolt,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
            ),

            // 3. Bottom Animated Green Dotted Spinner
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 36.h),
                  child: const _GreenDottedSpinner(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GreenDottedSpinner extends StatefulWidget {
  const _GreenDottedSpinner();

  @override
  State<_GreenDottedSpinner> createState() => _GreenDottedSpinnerState();
}

class _GreenDottedSpinnerState extends State<_GreenDottedSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int dotCount = 8;
    final double radius = 16.r;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 44.r,
          height: 44.r,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(dotCount, (index) {
              final double angle = (index * 2 * math.pi / dotCount) +
                  (_controller.value * 2 * math.pi);
              final double x = radius * math.cos(angle);
              final double y = radius * math.sin(angle);
              final double dotSize = 4.r + (index / dotCount) * 4.r;
              final double opacity = 0.2 + (index / dotCount) * 0.8;

              return Transform.translate(
                offset: Offset(x, y),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: opacity),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
