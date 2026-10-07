import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/dashed_border_container.dart';
import '../controller/programs_controller.dart';

class ProgramDetailsView extends GetView<ProgramsController> {
  const ProgramDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Solar Energy System Devel..'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              // 4 Course Cards Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.58,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Battery Clamp Cover Image from Figma
                        SizedBox(
                          height: 120.h,
                          width: double.infinity,
                          child: Image.asset(
                            AppImages.powerCourse,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFFF1F5F9),
                              child: const Center(
                                child: Icon(Icons.bolt, color: AppColors.primary, size: 36),
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
                                  'Power Course',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  'Oln shadows deep where no one dares to tread...',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF64748B),
                                    height: 1.35,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6.h),
                                Wrap(
                                  spacing: 4.w,
                                  runSpacing: 4.h,
                                  children: [
                                    _buildMiniBadge('BASIC', const Color(0xFFEBF5FF), const Color(0xFF2563EB)),
                                    _buildMiniBadge('3h 20m', const Color(0xFFEDF9F1), AppColors.primary),
                                    _buildMiniBadge('3 lessons', const Color(0xFFF1F5F9), const Color(0xFF64748B)),
                                  ],
                                ),
                                const Spacer(),
                                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                                SizedBox(height: 8.h),
                                // Reactive Start Button: Gray (#64748B) if locked, Green (AppColors.primary) if enrolled
                                Obx(() {
                                  final enrolled = controller.isEnrolled.value;
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 36.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: enrolled
                                            ? AppColors.primary
                                            : const Color(0xFF64748B),
                                        padding: EdgeInsets.zero,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (enrolled) {
                                          controller.isModuleStarted.value = false;
                                          Get.toNamed(AppRoutes.courseDetails);
                                        } else {
                                          Get.snackbar(
                                            'Enrollment Required',
                                            'Please tap "Enroll Now" below to unlock this course.',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: const Color(0xFF64748B),
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(16),
                                            borderRadius: 12,
                                          );
                                        }
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
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Bottom Section: Mint unlock banner & Enroll Now button if not enrolled (Details.png)
              Obx(() {
                if (controller.isEnrolled.value) {
                  return SizedBox(height: 24.h);
                }
                return Column(
                  children: [
                    SizedBox(height: 16.h),
                    DashedBorderContainer(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      color: const Color(0xFFBCE7C6),
                      backgroundColor: const Color(0xFFEDF9F1),
                      borderRadius: 16.r,
                      child: Text(
                        'Enroll in this program to unlock all video lectures and resources.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF475569),
                          height: 1.45,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: 'Enroll Now',
                      height: 52.h,
                      borderRadius: 26.r,
                      onPressed: controller.enroll,
                    ),
                    SizedBox(height: 16.h),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildMiniBadge(String text, Color bg, Color textCol) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 8.5.sp,
          fontWeight: FontWeight.w600,
          color: textCol,
        ),
      ),
    );
  }
}
