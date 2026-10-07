import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_auth_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class SetNewPasswordView extends GetView<AuthController> {
  const SetNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),
                      const CustomAuthHeader(title: 'Set New Password'),
                      SizedBox(height: 36.h),
                      Obx(
                        () => CustomTextField(
                          label: 'New Password',
                          hintText: 'Enter your password here',
                          controller: controller.newPasswordController,
                          obscureText: controller.isNewPasswordHidden.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isNewPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 22.sp,
                              color: AppColors.textMuted,
                            ),
                            onPressed: controller.toggleNewPasswordVisibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Obx(
                        () => CustomTextField(
                          label: 'Confirm Password',
                          hintText: 'Enter your password here',
                          controller: controller.confirmPasswordController,
                          obscureText: controller.isConfirmPasswordHidden.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 22.sp,
                              color: AppColors.textMuted,
                            ),
                            onPressed: controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Change Password',
                        height: 54.h,
                        borderRadius: 28.r,
                        onPressed: controller.setNewPassword,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
