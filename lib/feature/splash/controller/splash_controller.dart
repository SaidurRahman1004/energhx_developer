import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  bool _hasNavigated = false;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    debugPrint('[SplashController] onInit called');
    _startNavigationTimer();
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('[SplashController] onReady called');
    if (_timer == null || !_timer!.isActive) {
      _startNavigationTimer();
    }
  }

  void _startNavigationTimer() {
    _timer?.cancel();
    // Automatically transition to onboarding after 2.5 seconds
    _timer = Timer(const Duration(milliseconds: 2500), () {
      debugPrint('[SplashController] Timer fired -> navigating to onboarding');
      navigateToNext();
    });
  }

  void navigateToNext() {
    if (_hasNavigated) return;
    _hasNavigated = true;
    _timer?.cancel();
    debugPrint('[SplashController] navigateToNext executed');
    Get.offAllNamed(AppRoutes.onboarding);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
