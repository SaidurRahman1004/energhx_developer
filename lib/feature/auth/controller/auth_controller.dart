import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/routes/app_routes.dart';

class AuthController extends GetxController {
  // Form Keys for full validation
  final loginFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final setNewPasswordFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  // Sign Up Dropdown & Photo Error Observables
  final sexError = RxnString();
  final countryError = RxnString();
  final provinceError = RxnString();
  final photoError = RxnString();

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

  // Custom Validation Logic
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  void login([GlobalKey<FormState>? formKey]) {
    final isFormValid = (formKey != null)
        ? (formKey.currentState?.validate() ?? false)
        : (loginFormKey.currentState?.validate() ?? false);

    if (isFormValid) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  void sendResetCode([GlobalKey<FormState>? formKey]) {
    final isFormValid = (formKey != null)
        ? (formKey.currentState?.validate() ?? false)
        : (forgotPasswordFormKey.currentState?.validate() ?? false);

    if (isFormValid) {
      startOtpTimer();
      Get.toNamed(AppRoutes.otpVerification);
    }
  }

  void resendOtp() {
    if (canResendOtp.value) {
      startOtpTimer();
      Get.snackbar('Sent', 'A new OTP verification code has been sent');
    }
  }

  void verifyOtp() {
    if (otpController.text.trim().length != 4) {
      Get.snackbar(
        'Incomplete Code',
        'Please enter all 4 digits of the verification code',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    Get.toNamed(AppRoutes.setNewPassword);
  }

  void setNewPassword([GlobalKey<FormState>? formKey]) {
    final isFormValid = (formKey != null)
        ? (formKey.currentState?.validate() ?? false)
        : (setNewPasswordFormKey.currentState?.validate() ?? false);

    if (isFormValid) {
      if (newPasswordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Mismatch',
          'Passwords do not match',
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
        return;
      }
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void register([GlobalKey<FormState>? formKey]) {
    bool isCustomValid = true;

    // Validate Sex
    if (selectedSex.value == 'Choose sex' || selectedSex.value.isEmpty) {
      sexError.value = 'Please choose your sex';
      isCustomValid = false;
    } else {
      sexError.value = null;
    }

    // Validate Country
    if (selectedCountry.value == 'Choose country' || selectedCountry.value.isEmpty) {
      countryError.value = 'Please choose your country';
      isCustomValid = false;
    } else {
      countryError.value = null;
    }

    // Validate Province
    if (selectedProvince.value == 'Choose province' || selectedProvince.value.isEmpty) {
      provinceError.value = 'Please choose your province';
      isCustomValid = false;
    } else {
      provinceError.value = null;
    }

    final isFormValid = (formKey != null)
        ? (formKey.currentState?.validate() ?? false)
        : (signUpFormKey.currentState?.validate() ?? false);

    if (isFormValid && isCustomValid) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
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
