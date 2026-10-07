import 'dart:async';
import 'package:country_state_city/country_state_city.dart' as csc;
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

  // Sign Up Dropdown & Selection Error Observables
  final sexError = RxnString();
  final countryError = RxnString();
  final provinceError = RxnString();
  final cityError = RxnString();
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

  // Location Hierarchy & Observables
  final allCountries = <csc.Country>[].obs;
  final availableStates = <csc.State>[].obs;
  final availableCities = <String>[].obs;
  final isLoadingCountries = false.obs;
  final isLoadingStates = false.obs;
  final isLoadingCities = false.obs;

  final selectedCountry = 'Choose country'.obs;
  final selectedCountryCode = ''.obs;
  final selectedCountryFlag = ''.obs;

  final selectedProvince = 'Choose province'.obs;
  final selectedProvinceCode = ''.obs;

  final selectedCity = 'Choose city'.obs;

  final regionLabel = 'Province'.obs;
  final regionHint = 'Choose province'.obs;
  final postalCodeLabel = 'Postal Code'.obs;
  final postalCodeHint = 'Postal code'.obs;

  final streetNumberController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  final uploadedPhotoPath = RxnString();
  final uploadedPhotoName = RxnString();

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

  @override
  void onInit() {
    super.onInit();
    loadCountries();
  }

  Future<void> loadCountries() async {
    if (allCountries.isNotEmpty) return;
    isLoadingCountries.value = true;
    try {
      final list = await csc.getAllCountries();
      list.sort((a, b) => a.name.compareTo(b.name));
      allCountries.assignAll(list);
    } catch (e) {
      debugPrint('[AuthController] Error loading countries: $e');
    } finally {
      isLoadingCountries.value = false;
    }
  }

  Future<void> selectCountry(csc.Country country) async {
    selectedCountry.value = country.name;
    selectedCountryCode.value = country.isoCode;
    selectedCountryFlag.value = country.flag;
    countryError.value = null;

    _updateRegionAndPostalMetadata(country.isoCode);

    selectedProvince.value = regionHint.value;
    selectedProvinceCode.value = '';
    provinceError.value = null;

    selectedCity.value = 'Choose city';
    cityController.text = '';
    cityError.value = null;

    availableStates.clear();
    availableCities.clear();

    await loadStatesForCountry(country.isoCode);
  }

  void _updateRegionAndPostalMetadata(String isoCode) {
    switch (isoCode.toUpperCase()) {
      case 'CA':
        regionLabel.value = 'Province';
        regionHint.value = 'Choose province';
        postalCodeLabel.value = 'Postal Code';
        postalCodeHint.value = 'Postal code (e.g. M5V 2T6)';
        break;
      case 'US':
        regionLabel.value = 'State';
        regionHint.value = 'Choose state';
        postalCodeLabel.value = 'ZIP Code';
        postalCodeHint.value = 'ZIP code (e.g. 90210)';
        break;
      case 'BD':
        regionLabel.value = 'Division / District';
        regionHint.value = 'Choose division or district';
        postalCodeLabel.value = 'Postal Code';
        postalCodeHint.value = 'Postal code (e.g. 1205)';
        break;
      case 'GB':
        regionLabel.value = 'County / Region';
        regionHint.value = 'Choose county or region';
        postalCodeLabel.value = 'Postcode';
        postalCodeHint.value = 'Postcode (e.g. SW1A 1AA)';
        break;
      case 'AU':
        regionLabel.value = 'State / Territory';
        regionHint.value = 'Choose state or territory';
        postalCodeLabel.value = 'Postal Code';
        postalCodeHint.value = 'Postal code (e.g. 2000)';
        break;
      case 'IN':
        regionLabel.value = 'State / UT';
        regionHint.value = 'Choose state';
        postalCodeLabel.value = 'PIN Code';
        postalCodeHint.value = 'PIN code (e.g. 110001)';
        break;
      default:
        regionLabel.value = 'Province / State';
        regionHint.value = 'Choose province or state';
        postalCodeLabel.value = 'Postal Code';
        postalCodeHint.value = 'Postal code';
        break;
    }
  }

  Future<void> loadStatesForCountry(String countryCode) async {
    isLoadingStates.value = true;
    try {
      final states = await csc.getStatesOfCountry(countryCode);
      states.sort((a, b) => a.name.compareTo(b.name));
      availableStates.assignAll(states);
    } catch (e) {
      debugPrint('[AuthController] Error loading states: $e');
    } finally {
      isLoadingStates.value = false;
    }
  }

  Future<void> selectProvince(csc.State state) async {
    selectedProvince.value = state.name;
    selectedProvinceCode.value = state.isoCode;
    provinceError.value = null;

    selectedCity.value = 'Choose city';
    cityController.text = '';
    cityError.value = null;
    availableCities.clear();

    await loadCitiesForState(selectedCountryCode.value, state.isoCode);
  }

  void selectCustomProvince(String customProvince) {
    selectedProvince.value = customProvince;
    selectedProvinceCode.value = '';
    provinceError.value = null;

    selectedCity.value = 'Choose city';
    cityController.text = '';
    cityError.value = null;
    availableCities.clear();

    if (selectedCountryCode.value.isNotEmpty) {
      loadCitiesForState(selectedCountryCode.value, '');
    }
  }

  Future<void> loadCitiesForState(String countryCode, String stateCode) async {
    isLoadingCities.value = true;
    try {
      List<csc.City> cities = [];
      if (countryCode.isNotEmpty && stateCode.isNotEmpty) {
        cities = await csc.getStateCities(countryCode, stateCode);
      }
      if (cities.isEmpty && countryCode.isNotEmpty) {
        cities = await csc.getCountryCities(countryCode);
      }

      final cityNames = cities.map((c) => c.name).toSet().toList();
      cityNames.sort((a, b) => a.compareTo(b));
      availableCities.assignAll(cityNames);
    } catch (e) {
      debugPrint('[AuthController] Error loading cities: $e');
    } finally {
      isLoadingCities.value = false;
    }
  }

  void selectCity(String cityName) {
    selectedCity.value = cityName;
    cityController.text = cityName;
    cityError.value = null;
  }

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

  // Context-Aware Form Validation Logic
  String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return '$fieldName can only contain letters';
    }
    return null;
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

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

  String? validateStreetAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Street address is required';
    }
    if (value.trim().length < 3) {
      return 'Street address must be at least 3 characters';
    }
    return null;
  }

  String? validatePostalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '${postalCodeLabel.value} is required';
    }
    final code = value.trim();
    final country = selectedCountryCode.value.toUpperCase();

    if (country == 'US') {
      final zipRegex = RegExp(r'^\d{5}(-\d{4})?$');
      if (!zipRegex.hasMatch(code)) {
        return 'Enter a valid 5-digit ZIP code (e.g. 90210)';
      }
    } else if (country == 'CA') {
      final caRegex = RegExp(r'^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$');
      if (!caRegex.hasMatch(code)) {
        return 'Enter a valid postal code (e.g. M5V 2T6)';
      }
    } else if (country == 'BD') {
      final bdRegex = RegExp(r'^\d{4}$');
      if (!bdRegex.hasMatch(code)) {
        return 'Enter a valid 4-digit postal code (e.g. 1205)';
      }
    } else if (country == 'GB') {
      if (code.length < 5 || code.length > 8) {
        return 'Enter a valid UK postcode (e.g. SW1A 1AA)';
      }
    } else {
      if (code.length < 3) {
        return '${postalCodeLabel.value} must be at least 3 characters';
      }
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
      countryError.value = 'Please select your country';
      isCustomValid = false;
    } else {
      countryError.value = null;
    }

    // Validate Province
    if (selectedProvince.value == regionHint.value ||
        selectedProvince.value == 'Choose province' ||
        selectedProvince.value.isEmpty) {
      provinceError.value = 'Please select your ${regionLabel.value.toLowerCase()}';
      isCustomValid = false;
    } else {
      provinceError.value = null;
    }

    // Validate City
    if (selectedCity.value == 'Choose city' ||
        selectedCity.value.isEmpty ||
        cityController.text.trim().isEmpty) {
      cityError.value = 'Please select your city';
      isCustomValid = false;
    } else {
      cityError.value = null;
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
