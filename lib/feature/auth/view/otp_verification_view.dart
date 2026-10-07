import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_auth_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/auth_controller.dart';

class OtpVerificationView extends GetView<AuthController> {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 64.w,
      height: 64.w,
      textStyle: GoogleFonts.plusJakartaSans(
        fontSize: 22.sp,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border, width: 1.0),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.error, width: 1.2),
      ),
    );

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
                      SizedBox(height: 12.h),
                      const CustomAuthHeader(title: 'Verification Code'),
                      SizedBox(height: 48.h),
                      // 4-box Pinput
                      Pinput(
                        length: 4,
                        controller: controller.otpController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        errorPinTheme: errorPinTheme,
                        separatorBuilder: (index) => SizedBox(width: 14.w),
                        validator: (s) {
                          if (s == null || s.length < 4) {
                            return 'Please enter 4-digit code';
                          }
                          return null;
                        },
                        errorTextStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: AppColors.error,
                          fontWeight: FontWeight.w500,
                        ),
                        onCompleted: (pin) {
                          // Auto ready on complete
                        },
                      ),
                      SizedBox(height: 28.h),
                      // Didn't receive code? Resend code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF64748B),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.resendOtp,
                            child: Text(
                              'Resend code',
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.primary,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // Timer Pill Badge
                      Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.primarySubtle,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: 'Resend code at ',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF64748B),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '00:${controller.otpCountdown.value.toString().padLeft(2, '0')}',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: AppColors.textPrimary,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Verify',
                        height: 54.h,
                        borderRadius: 28.r,
                        onPressed: controller.verifyOtp,
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
