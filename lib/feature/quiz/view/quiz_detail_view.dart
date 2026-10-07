import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/quiz_controller.dart';

class QuizDetailView extends GetView<QuizController> {
  const QuizDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Obx(
          () => CustomAppBar(title: controller.quizTitle.value),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Tinted background container wrapping all questions (matching Figma Quiz (1).png)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3FD),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: List.generate(controller.questions.length, (qIndex) {
                    final q = controller.questions[qIndex];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: qIndex == controller.questions.length - 1 ? 0 : 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Vibrant Blue Header Card
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E75E8),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1E75E8).withValues(alpha: 0.25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              q.question,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.35,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          // 2. Options List
                          ...List.generate(q.options.length, (optIndex) {
                            final optionLabel = String.fromCharCode(97 + optIndex); // a, b, c, d
                            final optionText = q.options[optIndex];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Obx(() {
                                final isSelected =
                                    controller.selectedAnswers[q.id] == optIndex;

                                return GestureDetector(
                                  onTap: () => controller.selectOption(q.id, optIndex),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 11.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFC7EBD4)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF78C997)
                                            : const Color(0xFFE2E8F0),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        // Circular Letter Badge
                                        Container(
                                          width: 26.r,
                                          height: 26.r,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? const Color(0xFFA2DFB9)
                                                : const Color(0xFFEDF9F1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              optionLabel,
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: isSelected
                                                    ? const Color(0xFF166534)
                                                    : AppColors.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            optionText,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 13.5.sp,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 24.h),

              // Bottom Submit Pill Button
              CustomButton(
                text: 'Submit',
                height: 52.h,
                borderRadius: 26.r,
                onPressed: controller.submitQuiz,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
