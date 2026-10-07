import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class SettingsController extends GetxController {
  final userName = 'Zahirul Piash'.obs;
  final userEmail = 'piash2215@gmail.com'.obs;

  // Edit Profile Form Controllers
  final firstNameController = TextEditingController(text: 'Zahirul');
  final lastNameController = TextEditingController(text: 'Piash');
  final otherNameController = TextEditingController();
  final emailController = TextEditingController(text: 'piash2215@gmail.com');
  final streetNumberController = TextEditingController();
  final streetAddressController = TextEditingController();
  final countryController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  // Change Password Form Controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isNewPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  void toggleNewPasswordVisibility() {
    isNewPasswordHidden.value = !isNewPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void saveProfile() {
    Get.back();
    Get.snackbar('Success', 'Profile updated successfully');
  }

  void updatePassword() {
    Get.back();
    Get.snackbar('Success', 'Password updated successfully');
  }

  void logOut() {
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    otherNameController.dispose();
    emailController.dispose();
    streetNumberController.dispose();
    streetAddressController.dispose();
    countryController.dispose();
    provinceController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
