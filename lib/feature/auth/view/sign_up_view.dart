import 'dart:io';
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
                      validator: (v) => controller.validateRequired(v, 'First name'),
                    ),
                    SizedBox(height: 16.h),

                    // 2. Last Name
                    CustomTextField(
                      label: 'Last Name',
                      hintText: 'Enter your last name here',
                      controller: controller.lastNameController,
                      validator: (v) => controller.validateRequired(v, 'Last name'),
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
                    _buildDropdownField(
                      label: 'Sex',
                      hintText: 'Choose sex',
                      rxValue: controller.selectedSex,
                      options: const ['Choose sex', 'Male', 'Female', 'Other'],
                      errorText: controller.sexError,
                    ),
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
                            color: AppColors.border, // #A1A1A1
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
                      validator: (v) => controller.validateRequired(v, 'Street address'),
                    ),
                    SizedBox(height: 16.h),

                    // 11. Country (Dropdown)
                    _buildDropdownField(
                      label: 'Country',
                      hintText: 'Choose country',
                      rxValue: controller.selectedCountry,
                      options: const [
                        'Choose country',
                        'United States',
                        'Canada',
                        'United Kingdom',
                        'Bangladesh',
                        'Germany',
                        'Australia'
                      ],
                      errorText: controller.countryError,
                    ),
                    SizedBox(height: 16.h),

                    // 12. Province (Dropdown)
                    _buildDropdownField(
                      label: 'Province',
                      hintText: 'Choose province',
                      rxValue: controller.selectedProvince,
                      options: const [
                        'Choose province',
                        'Ontario',
                        'California',
                        'Texas',
                        'Dhaka',
                        'Bavaria',
                        'Queensland'
                      ],
                      errorText: controller.provinceError,
                    ),
                    SizedBox(height: 16.h),

                    // 13. City
                    CustomTextField(
                      label: 'City',
                      hintText: 'City',
                      controller: controller.cityController,
                      validator: (v) => controller.validateRequired(v, 'City'),
                    ),
                    SizedBox(height: 16.h),

                    // 14. Postal Code
                    CustomTextField(
                      label: 'Postal Code',
                      hintText: 'Postal code',
                      controller: controller.postalCodeController,
                      validator: (v) => controller.validateRequired(v, 'Postal code'),
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
                        // Go back to Login cleanly
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

  Widget _buildDropdownField({
    required String label,
    required String hintText,
    required RxString rxValue,
    required List<String> options,
    RxnString? errorText,
  }) {
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
        Obx(() {
          final hasError = errorText?.value != null && errorText!.value!.isNotEmpty;
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
                    value: rxValue.value,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textMuted,
                      size: 24,
                    ),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: rxValue.value == hintText
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                    items: options.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      if (newVal != null) {
                        rxValue.value = newVal;
                        if (errorText != null && newVal != hintText) {
                          errorText.value = null;
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
                    errorText.value ?? '',
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
