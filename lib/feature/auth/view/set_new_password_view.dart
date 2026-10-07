import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_auth_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class SetNewPasswordView extends StatefulWidget {
  const SetNewPasswordView({super.key});

  @override
  State<SetNewPasswordView> createState() => _SetNewPasswordViewState();
}

class _SetNewPasswordViewState extends State<SetNewPasswordView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Obx(
                              () => CustomTextField(
                                label: 'New Password',
                                hintText: 'Enter your password here',
                                controller: controller.newPasswordController,
                                obscureText: controller.isNewPasswordHidden.value,
                                validator: controller.validatePassword,
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
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (val != controller.newPasswordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
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
                          ],
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Change Password',
                        height: 54.h,
                        borderRadius: 28.r,
                        onPressed: () => controller.setNewPassword(_formKey),
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
