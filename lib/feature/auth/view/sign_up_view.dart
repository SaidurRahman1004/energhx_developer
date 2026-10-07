import 'dart:io';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/dashed_border_container.dart';
import '../controller/auth_controller.dart';
import 'widgets/searchable_picker_bottom_sheet.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              // App Logo
              Center(
                child: Image.asset(
                  AppImages.appLogo,
                  width: 84.w,
                  height: 84.h,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.bolt, size: 64, color: AppColors.primary),
                ),
              ),
              SizedBox(height: 18.h),
              // Title
              Text(
                'Create Account',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 28.h),

              // Form wrapper for Sign Up fields
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. First Name
                    CustomTextField(
                      label: 'First Name',
                      hintText: 'Enter your first name here',
                      controller: controller.firstNameController,
                      validator: (v) => controller.validateName(v, 'First name'),
                    ),
                    SizedBox(height: 16.h),

                    // 2. Last Name
                    CustomTextField(
                      label: 'Last Name',
                      hintText: 'Enter your last name here',
                      controller: controller.lastNameController,
                      validator: (v) => controller.validateName(v, 'Last name'),
                    ),
                    SizedBox(height: 16.h),

                    // 3. Other Name (Optional)
                    CustomTextField(
                      label: 'Other Name',
                      hintText: 'Enter your other name here',
                      controller: controller.otherNameController,
                    ),
                    SizedBox(height: 16.h),

                    // 4. Company Name
                    CustomTextField(
                      label: 'Company Name',
                      hintText: 'Enter your company name',
                      controller: controller.companyNameController,
                      validator: (v) => controller.validateRequired(v, 'Company name'),
                    ),
                    SizedBox(height: 16.h),

                    // 5. Sex (Dropdown)
                    _buildSexDropdownField(controller: controller),
                    SizedBox(height: 16.h),

                    // 6. Email
                    CustomTextField(
                      label: 'Email',
                      hintText: 'Enter your email here',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                    ),
                    SizedBox(height: 16.h),

                    // 7. Password
                    Obx(
                      () => CustomTextField(
                        label: 'Password',
                        hintText: 'Enter your password here',
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordHidden.value,
                        validator: controller.validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 22.sp,
                            color: AppColors.textMuted,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 8. Photo Upload Box (Dashed border)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Photo',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Obx(() {
                          final photoPath = controller.uploadedPhotoPath.value;
                          final photoName = controller.uploadedPhotoName.value;

                          if (photoPath != null && photoPath.isNotEmpty) {
                            return Container(
                              height: 52.h,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDF9F1),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.primary, width: 1.0),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.r),
                                    child: Image.file(
                                      File(photoPath),
                                      width: 36.r,
                                      height: 36.r,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Icon(
                                        Icons.image,
                                        size: 24.sp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      photoName ?? 'Photo selected',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textPrimary,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: AppColors.textSecondary,
                                      size: 20.sp,
                                    ),
                                    onPressed: controller.removePhoto,
                                    tooltip: 'Remove photo',
                                  ),
                                ],
                              ),
                            );
                          }

                          return DashedBorderContainer(
                            height: 52.h,
                            color: AppColors.border,
                            borderRadius: 8.r,
                            backgroundColor: Colors.white,
                            onTap: controller.pickPhoto,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_upload_outlined,
                                    color: AppColors.textMuted,
                                    size: 22.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Upload photo',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: AppColors.textMuted,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // 9. Street Number
                    CustomTextField(
                      label: 'Street Number',
                      hintText: 'Enter number',
                      controller: controller.streetNumberController,
                      validator: (v) => controller.validateRequired(v, 'Street number'),
                    ),
                    SizedBox(height: 16.h),

                    // 10. Street Address
                    CustomTextField(
                      label: 'Street Address',
                      hintText: 'Street address',
                      controller: controller.streetAddressController,
                      validator: controller.validateStreetAddress,
                    ),
                    SizedBox(height: 16.h),

                    // 11. Country (Searchable Bottom Sheet with flags & search)
                    Obx(
                      () => _buildSelectField(
                        label: 'Country',
                        hintText: 'Choose country',
                        value: controller.selectedCountry.value == 'Choose country'
                            ? null
                            : controller.selectedCountry.value,
                        leading: controller.selectedCountryFlag.value.isNotEmpty
                            ? Text(
                                controller.selectedCountryFlag.value,
                                style: TextStyle(fontSize: 20.sp),
                              )
                            : null,
                        isLoading: controller.isLoadingCountries.value,
                        errorText: controller.countryError.value,
                        onTap: () => _openCountryPicker(context, controller),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 12. Province / State / Division (Dynamic based on selected country)
                    Obx(
                      () => _buildSelectField(
                        label: controller.regionLabel.value,
                        hintText: controller.regionHint.value,
                        value: (controller.selectedProvince.value ==
                                    controller.regionHint.value ||
                                controller.selectedProvince.value ==
                                    'Choose province' ||
                                controller.selectedProvince.value.isEmpty)
                            ? null
                            : controller.selectedProvince.value,
                        isLoading: controller.isLoadingStates.value,
                        errorText: controller.provinceError.value,
                        onTap: () => _openProvincePicker(context, controller),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 13. City (Dropdown & Searchable Bottom Sheet based on Country/Province)
                    Obx(
                      () => _buildSelectField(
                        label: 'City',
                        hintText: 'Choose city',
                        value: (controller.selectedCity.value == 'Choose city' ||
                                controller.selectedCity.value.isEmpty)
                            ? null
                            : controller.selectedCity.value,
                        isLoading: controller.isLoadingCities.value,
                        errorText: controller.cityError.value,
                        onTap: () => _openCityPicker(context, controller),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 14. Postal Code (Dynamic label, hint & context-aware validation)
                    Obx(
                      () => CustomTextField(
                        label: controller.postalCodeLabel.value,
                        hintText: controller.postalCodeHint.value,
                        controller: controller.postalCodeController,
                        validator: controller.validatePostalCode,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Consumer Pill Button
              CustomButton(
                text: 'Consumer',
                height: 54.h,
                borderRadius: 28.r,
                onPressed: () => controller.register(_formKey),
              ),
              SizedBox(height: 20.h),

              // Bottom Footer
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textPrimary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Get.previousRoute == AppRoutes.login) {
                          Get.back();
                        } else {
                          Get.offNamed(AppRoutes.login);
                        }
                      },
                      child: Text(
                        'Log in',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCountryPicker(BuildContext context, AuthController controller) {
    if (controller.allCountries.isEmpty && controller.isLoadingCountries.value) {
      Get.snackbar(
        'Loading Countries',
        'Please wait while countries are loading...',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    SearchablePickerBottomSheet.show<csc.Country>(
      context: context,
      title: 'Select Country',
      searchHint: 'Search country by name or code...',
      items: controller.allCountries.map((c) {
        final isSelected = controller.selectedCountryCode.value == c.isoCode;
        return PickerItem<csc.Country>(
          data: c,
          title: c.name,
          subtitle: '${c.phoneCode} • ${c.isoCode}',
          leading: Text(c.flag, style: TextStyle(fontSize: 22.sp)),
          isSelected: isSelected,
        );
      }).toList(),
      onSelected: (c) => controller.selectCountry(c),
    );
  }

  void _openProvincePicker(BuildContext context, AuthController controller) {
    if (controller.selectedCountryCode.value.isEmpty) {
      Get.snackbar(
        'Select Country First',
        'Please select a country before choosing ${controller.regionLabel.value.toLowerCase()}',
        backgroundColor: Colors.amber.shade700,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    if (controller.isLoadingStates.value) {
      Get.snackbar(
        'Loading',
        'Loading regions, please wait...',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    SearchablePickerBottomSheet.show<csc.State>(
      context: context,
      title: 'Select ${controller.regionLabel.value}',
      searchHint: 'Search ${controller.regionLabel.value.toLowerCase()}...',
      allowCustomEntry: true,
      onCustomSelected: (customVal) => controller.selectCustomProvince(customVal),
      items: controller.availableStates.map((s) {
        final isSelected = controller.selectedProvince.value == s.name;
        return PickerItem<csc.State>(
          data: s,
          title: s.name,
          subtitle: s.isoCode.isNotEmpty ? 'Code: ${s.isoCode}' : null,
          leading: const Icon(Icons.location_on_outlined, color: AppColors.primary),
          isSelected: isSelected,
        );
      }).toList(),
      onSelected: (s) => controller.selectProvince(s),
    );
  }

  void _openCityPicker(BuildContext context, AuthController controller) {
    if (controller.selectedCountryCode.value.isEmpty) {
      Get.snackbar(
        'Select Country First',
        'Please select a country first',
        backgroundColor: Colors.amber.shade700,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    if (controller.isLoadingCities.value) {
      Get.snackbar(
        'Loading',
        'Loading cities, please wait...',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
      return;
    }

    SearchablePickerBottomSheet.show<String>(
      context: context,
      title: 'Select City',
      searchHint: 'Search or enter custom city...',
      allowCustomEntry: true,
      emptyMessage: 'No preset cities found. Enter custom city below.',
      onCustomSelected: (customVal) => controller.selectCity(customVal),
      items: controller.availableCities.map((cityName) {
        final isSelected = controller.selectedCity.value == cityName;
        return PickerItem<String>(
          data: cityName,
          title: cityName,
          leading: const Icon(Icons.apartment_rounded, color: AppColors.primary),
          isSelected: isSelected,
        );
      }).toList(),
      onSelected: (cityName) => controller.selectCity(cityName),
    );
  }

  Widget _buildSelectField({
    required String label,
    required String hintText,
    String? value,
    Widget? leading,
    bool isLoading = false,
    String? errorText,
    required VoidCallback onTap,
  }) {
    final hasError = errorText != null && errorText.isNotEmpty;
    final hasValue = value != null && value.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: hasError ? AppColors.error : AppColors.border,
                width: hasError ? 1.2 : 1.0,
              ),
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading,
                  SizedBox(width: 10.w),
                ],
                Expanded(
                  child: Text(
                    hasValue ? value : hintText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
                      color: hasValue ? AppColors.textPrimary : AppColors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isLoading)
                  SizedBox(
                    width: 18.r,
                    height: 18.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  )
                else
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted,
                    size: 24.sp,
                  ),
              ],
            ),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              errorText,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                color: AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSexDropdownField({
    required AuthController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sex',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Obx(() {
          final hasError = controller.sexError.value != null &&
              controller.sexError.value!.isNotEmpty;
          final value = controller.selectedSex.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: hasError ? AppColors.error : AppColors.border,
                    width: hasError ? 1.2 : 1.0,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textMuted,
                      size: 24,
                    ),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: value == 'Choose sex'
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Choose sex',
                        child: Text('Choose sex'),
                      ),
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                      DropdownMenuItem(
                        value: 'Other',
                        child: Text('Other'),
                      ),
                    ],
                    onChanged: (newVal) {
                      if (newVal != null) {
                        controller.selectedSex.value = newVal;
                        if (newVal != 'Choose sex') {
                          controller.sexError.value = null;
                        }
                      }
                    },
                  ),
                ),
              ),
              if (hasError) ...[
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    controller.sexError.value!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: AppColors.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ],
    );
  }
}
