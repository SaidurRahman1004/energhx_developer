import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/dashed_border_container.dart';
import '../controller/programs_controller.dart';

class CourseDetailsView extends GetView<ProgramsController> {
  const CourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Course Details',
        onBackPressed: () {
          if (controller.isModuleStarted.value) {
            controller.backToModulesOverview();
          } else {
            Get.back();
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Preview Card (Sunset Solar Panels Banner)
              Container(
                width: double.infinity,
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
                    // Banner Image with Bottom Shadowed Title Overlay
                    SizedBox(
                      height: 170.h,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            AppImages.solarBanner,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFF1E293B),
                              child: const Center(
                                child: Icon(Icons.solar_power, color: AppColors.primary, size: 48),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withValues(alpha: 0.8),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Text(
                                'Solar Energy System Developer',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Solar Energy System Developer',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              _buildTag(
                                'BASIC',
                                const Color(0xFFEBF5FF),
                                const Color(0xFF2563EB),
                              ),
                              SizedBox(width: 8.w),
                              _buildTag(
                                '3h 20m',
                                const Color(0xFFEDF9F1),
                                AppColors.primary,
                              ),
                              SizedBox(width: 8.w),
                              _buildTag(
                                '3 lessons',
                                const Color(0xFFF1F5F9),
                                const Color(0xFF64748B),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // 2. About the Programs.
              Text(
                'About the Programs.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'In shadows deep where no one dares to tread, one-eyed pirit born of dread. She clings to those whom fortune has forsaken,A weight of woe from which no soul has waken. Misfortune trails her steps like creeping mist, No charm prayer can break her iron fist. She whispers ruin throughmidnight air— Beware the gaze of Likho.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              SizedBox(height: 22.h),

              // 3. Dynamic Section:
              // - Modules Grid (After Enrolement.png) OR
              // - Video Player + Tabs + Lessons List (After Enrolement (1) & (2).png)
              Obx(() {
                if (!controller.isModuleStarted.value) {
                  return _buildModulesGrid();
                } else {
                  return _buildModuleVideoSection();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  // --- Section A: Modules Grid (After Enrolement.png) ---
  Widget _buildModulesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modules',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 14.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 0.60,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            final moduleNumber = index + 1;
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
                  SizedBox(
                    height: 116.h,
                    width: double.infinity,
                    child: Image.asset(
                      AppImages.powerCourse,
                      fit: BoxFit.cover,
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
                            'Modules $moduleNumber',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Wrap(
                            spacing: 4.w,
                            runSpacing: 4.h,
                            children: [
                              _buildTag(
                                'BASIC',
                                const Color(0xFFEBF5FF),
                                const Color(0xFF2563EB),
                                fontSize: 8.5.sp,
                              ),
                              _buildTag(
                                '3h 20m',
                                const Color(0xFFEDF9F1),
                                AppColors.primary,
                                fontSize: 8.5.sp,
                              ),
                              _buildTag(
                                '3 lessons',
                                const Color(0xFFF1F5F9),
                                const Color(0xFF64748B),
                                fontSize: 8.5.sp,
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
                              onPressed: () => controller.startModule(moduleNumber),
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
        SizedBox(height: 24.h),
      ],
    );
  }

  // --- Section B: Video Player, Tabs, Lessons, Quiz Actions (After Enrolement (1), (2), (3).png) ---
  Widget _buildModuleVideoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Segmented Tabs: Basic Content | Content
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectContentType(0),
                  child: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: controller.selectedContentType.value == 0
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Center(
                        child: Text(
                          'Basic Content',
                          style: GoogleFonts.plusJakartaSans(
                            color: controller.selectedContentType.value == 0
                                ? Colors.white
                                : const Color(0xFF64748B),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectContentType(1),
                  child: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: controller.selectedContentType.value == 1
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Center(
                        child: Text(
                          'Content',
                          style: GoogleFonts.plusJakartaSans(
                            color: controller.selectedContentType.value == 1
                                ? Colors.white
                                : const Color(0xFF64748B),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18.h),

        // Real Video Player Container
        Container(
          height: 195.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Obx(() {
            if (controller.isVideoLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (controller.isVideoInitialized.value &&
                controller.videoPlayerController != null) {
              return GestureDetector(
                onTap: controller.togglePlayPause,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: controller.videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(controller.videoPlayerController!),
                      ),
                    ),
                    // Centered Play/Pause Button
                    AnimatedOpacity(
                      opacity: controller.isVideoPlaying.value ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 54.r,
                        height: 54.r,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Fallback preview
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppImages.solarBanner,
                    fit: BoxFit.cover,
                    color: Colors.black.withValues(alpha: 0.65),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final currentList = controller.currentLessons;
                    if (currentList.isNotEmpty) {
                      controller.loadVideo(
                        currentList[controller.currentLessonIndex.value].videoUrl,
                      );
                    }
                  },
                  child: Container(
                    width: 54.r,
                    height: 54.r,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        SizedBox(height: 20.h),

        // Video Lessons Playlist
        Obx(() {
          final lessons = controller.currentLessons;
          return Column(
            children: List.generate(lessons.length, (index) {
              final lesson = lessons[index];
              final isPlaying = controller.currentLessonIndex.value == index;

              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: GestureDetector(
                  onTap: () => controller.playLesson(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isPlaying ? const Color(0xFFEDF9F1) : Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: isPlaying ? AppColors.primary : const Color(0xFFE2E8F0),
                        width: isPlaying ? 1.2 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Play Icon box
                        Container(
                          width: 36.r,
                          height: 36.r,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4EED8),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Center(
                            child: Icon(
                              isPlaying && controller.isVideoPlaying.value
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: AppColors.primary,
                              size: 22.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                lesson.duration,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF64748B),
                                  fontWeight: FontWeight.w400,
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
            }),
          );
        }),
        SizedBox(height: 18.h),

        // Bottom Actions: Completed Card vs View Quiz / Mark Course as Complete
        Obx(() {
          if (controller.isCourseCompleted.value) {
            return _buildCourseCompletedSection();
          } else {
            return Column(
              children: [
                // View Quiz Button
                CustomButton(
                  text: 'View Quiz',
                  isOutlined: true,
                  height: 52.h,
                  borderRadius: 26.r,
                  onPressed: () => Get.toNamed(AppRoutes.quizzes),
                ),
                SizedBox(height: 14.h),
                // Mark Course as Complete Button
                CustomButton(
                  text: 'Mark Course as Complete',
                  isOutlined: true,
                  height: 52.h,
                  borderRadius: 26.r,
                  onPressed: controller.completeCourse,
                ),
                SizedBox(height: 20.h),
              ],
            );
          }
        }),
      ],
    );
  }

  // --- Section C: Completed Course Card (After Enrolement (3).png) ---
  Widget _buildCourseCompletedSection() {
    return Column(
      children: [
        DashedBorderContainer(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          color: const Color(0xFFBCE7C6),
          backgroundColor: const Color(0xFFF6FCF7),
          borderRadius: 16.r,
          child: Column(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                size: 40.sp,
                color: AppColors.primary,
              ),
              SizedBox(height: 12.h),
              Text(
                'Course Completed!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'You have finished Solar Energy System Developer. Download your certificate below.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5.sp,
                    color: const Color(0xFF64748B),
                    height: 1.45,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    onPressed: controller.isDownloadingCert.value
                        ? null
                        : controller.downloadCertificate,
                    child: controller.isDownloadingCert.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.download_rounded, color: Colors.white, size: 20),
                              SizedBox(width: 8.w),
                              Text(
                                'Get Certificate',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Review Button
        CustomButton(
          text: 'Review',
          isOutlined: true,
          height: 52.h,
          borderRadius: 26.r,
          onPressed: controller.openReviewModal,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  static Widget _buildTag(
    String text,
    Color bg,
    Color textCol, {
    double? fontSize,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: fontSize ?? 10.sp,
          fontWeight: FontWeight.w600,
          color: textCol,
        ),
      ),
    );
  }
}
