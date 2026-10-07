import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../controller/quiz_controller.dart';

class QuizListView extends GetView<QuizController> {
  const QuizListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Quiz's"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.62,
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  final moduleTitle = 'Modules ${index + 1}';
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Yellow Quiz Banner Illustration
                        SizedBox(
                          height: 118.h,
                          width: double.infinity,
                          child: Image.asset(
                            AppImages.quizBanner,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFFFEF3C7),
                              child: const Center(
                                child: Icon(
                                  Icons.quiz_rounded,
                                  color: Color(0xFFD97706),
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  moduleTitle,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    _buildBadge(
                                      'Content 1',
                                      const Color(0xFFF1F5F9),
                                      const Color(0xFF64748B),
                                    ),
                                    SizedBox(width: 6.w),
                                    _buildBadge(
                                      '20 Question',
                                      const Color(0xFFEDF9F1),
                                      AppColors.primary,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                                SizedBox(height: 8.h),
                                SizedBox(
                                  width: double.infinity,
                                  height: 36.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      padding: EdgeInsets.zero,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.quizTitle.value = moduleTitle;
                                      Get.toNamed(AppRoutes.quizDetail);
                                    },
                                    child: Text(
                                      'Start',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildBadge(String text, Color bg, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
