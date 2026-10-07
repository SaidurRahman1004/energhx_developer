import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 32.h),
                      // App Logo
                      Center(
                        child: Image.asset(
                          AppImages.appLogo,
                          width: 88.w,
                          height: 88.h,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.bolt, size: 64, color: AppColors.primary),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Title
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 36.h),
                      // Form with validators
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            CustomTextField(
                              label: 'Email',
                              hintText: 'Enter your email here',
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: controller.validateEmail,
                            ),
                            SizedBox(height: 18.h),
                            // Password Field
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
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Text(
                              'Forgot your password?',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF64748B),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      // Log In Pill Button
                      CustomButton(
                        text: 'Log In',
                        height: 54.h,
                        borderRadius: 28.r,
                        onPressed: () => controller.login(_formKey),
                      ),
                      const Spacer(),
                      // Sign Up Footer Link
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.textPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (Get.previousRoute == AppRoutes.signUp) {
                                  Get.back();
                                } else {
                                  Get.toNamed(AppRoutes.signUp);
                                }
                              },
                              child: Text(
                                'Sign up',
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
          },
        ),
      ),
    );
  }
}
