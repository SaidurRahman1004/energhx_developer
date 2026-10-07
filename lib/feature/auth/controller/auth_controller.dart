import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/routes/app_routes.dart';

class AuthController extends GetxController {
  // Login Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign Up Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final otherNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final selectedSex = 'Choose sex'.obs;
  final selectedCountry = 'Choose country'.obs;
  final selectedProvince = 'Choose province'.obs;
  final streetNumberController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final uploadedPhotoPath = RxnString();
  final uploadedPhotoName = RxnString();

  Future<void> pickPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        uploadedPhotoPath.value = image.path;
        uploadedPhotoName.value = image.name;
      }
    } catch (e) {
      debugPrint('[AuthController] pickPhoto error: $e');
    }
  }

  void removePhoto() {
    uploadedPhotoPath.value = null;
    uploadedPhotoName.value = null;
  }

  // Reset / Change Password
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // OTP
  final otpController = TextEditingController();
  final otpCountdown = 25.obs;
  final canResendOtp = false.obs;
  Timer? _timer;

  // Password Visibility
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isNewPasswordHidden = true.obs;

  // Loading state (ready for API integration)
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordHidden.value = !isNewPasswordHidden.value;
  }

  void startOtpTimer() {
    _timer?.cancel();
    otpCountdown.value = 25;
    canResendOtp.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpCountdown.value > 0) {
        otpCountdown.value--;
      } else {
        canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

  void login() {
    // API logic will be plugged here cleanly
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void sendResetCode() {
    startOtpTimer();
    Get.toNamed(AppRoutes.otpVerification);
  }

  void resendOtp() {
    if (canResendOtp.value) {
      startOtpTimer();
      Get.snackbar('Sent', 'A new OTP verification code has been sent');
    }
  }

  void verifyOtp() {
    Get.toNamed(AppRoutes.setNewPassword);
  }

  void setNewPassword() {
    Get.offAllNamed(AppRoutes.login);
  }

  void register() {
    // API registration logic
    Get.offAllNamed(AppRoutes.dashboard);
  }

  @override
  void onClose() {
    _timer?.cancel();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    otherNameController.dispose();
    companyNameController.dispose();
    streetNumberController.dispose();
    streetAddressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
