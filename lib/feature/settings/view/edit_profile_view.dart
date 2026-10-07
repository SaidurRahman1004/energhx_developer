import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controller/settings_controller.dart';

class EditProfileView extends GetView<SettingsController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with camera icon
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 84.r,
                      height: 84.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFEDF9F1), width: 3),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppImages.homeAvatar,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const CircleAvatar(
                            backgroundColor: AppColors.primarySubtle,
                            child: Icon(Icons.person, size: 48, color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              CustomTextField(
                label: 'First Name',
                hintText: 'Enter your first name here',
                controller: controller.firstNameController,
              ),
              SizedBox(height: 14.h),

              CustomTextField(
                label: 'Last Name',
                hintText: 'Enter your last name here',
                controller: controller.lastNameController,
              ),
              SizedBox(height: 14.h),

              CustomTextField(
                label: 'Other Name',
                hintText: 'Enter your other name here',
                controller: controller.otherNameController,
              ),
              SizedBox(height: 14.h),

              CustomTextField(
                label: 'Email',
                hintText: 'Enter your email here',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 14.h),

              // Sex Dropdown
              _buildDropdownField(
                label: 'Sex',
                hint: 'Choose your sex',
                value: 'Male',
                items: ['Male', 'Female', 'Other'],
                onChanged: (val) {},
              ),
              SizedBox(height: 14.h),

              CustomTextField(
                label: 'Street Number',
                hintText: 'Enter number',
                controller: controller.streetNumberController,
              ),
              SizedBox(height: 14.h),

              CustomTextField(
                label: 'Street Address',
                hintText: 'Street address',
                controller: controller.streetAddressController,
              ),
              SizedBox(height: 14.h),

              // Country Dropdown
              _buildDropdownField(
                label: 'Country',
                hint: 'Choose country',
                value: 'Canada',
                items: ['Canada', 'United States', 'United Kingdom', 'Australia', 'Bangladesh'],
                onChanged: (val) {},
              ),
              SizedBox(height: 14.h),

              // Province Dropdown
              _buildDropdownField(
                label: 'Province',
                hint: 'Choose province',
                value: 'Ontario',
                items: ['Ontario', 'Quebec', 'British Columbia', 'Alberta', 'Manitoba'],
                onChanged: (val) {},
              ),
              SizedBox(height: 14.h),

              CustomTextField(
                label: 'City',
                hintText: 'City',
                controller: controller.cityController,
              ),
              SizedBox(height: 14.h),

              CustomTextField(
                label: 'Postal Code',
                hintText: 'Postal code',
                controller: controller.postalCodeController,
              ),
              SizedBox(height: 28.h),

              CustomButton(
                text: 'Save',
                onPressed: controller.saveProfile,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.border, width: 1.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                hint,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13.sp,
                ),
              ),
              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary, size: 22.sp),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
