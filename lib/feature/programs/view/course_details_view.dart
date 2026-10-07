import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/programs_controller.dart';

class CourseDetailsView extends GetView<ProgramsController> {
  const CourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Course Details'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Preview / Video player
              Obx(() {
                if (controller.isEnrolled.value && controller.selectedTab.value == 0) {
                  final currentLesson = controller.lessons[controller.currentLessonIndex.value];
                  return Container(
                    height: 195,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        // Background Video Poster / Thumbnail
                        Positioned.fill(
                          child: Image.asset(
                            AppImages.solarBanner,
                            fit: BoxFit.cover,
                            color: Colors.black.withValues(alpha: 0.55),
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                        // Play/Pause Center Action
                        Center(
                          child: GestureDetector(
                            onTap: controller.togglePlayPause,
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(
                                controller.isVideoPlaying.value
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                        // Current Lesson Playing Title Pill
                        Positioned(
                          bottom: 12,
                          left: 14,
                          right: 14,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  controller.isVideoPlaying.value ? 'PLAYING' : 'PAUSED',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  currentLesson['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: 184,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          AppImages.solarBanner,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFFF1F5F9),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                            child: const Text(
                              'Solar Energy System Developer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
              const SizedBox(height: 16),
              // Title & Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Solar Energy System Developer',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const Text(
                    '\$11,500',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Badges
              Row(
                children: [
                  _buildTag('BASIC', const Color(0xFFEBF5FF), const Color(0xFF2563EB)),
                  const SizedBox(width: 8),
                  _buildTag('3h 20m', const Color(0xFFEDF9F1), AppColors.primary),
                  const SizedBox(width: 8),
                  _buildTag('3 lessons', const Color(0xFFF1F5F9), const Color(0xFF64748B)),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'About the Programs.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'In shadows deep where no one dares to tread, one-eyed spirit born of dread. She clings to those whom fortune has forsaken, A weight of woe from which no soul has waken. Misfortune trails her steps like creeping mist, No charm prayer can break her iron fist. She whispers ruin through midnight air— Beware the gaze of Likho.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),
              // Segmented Tab Bar (Video | Resources)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => GestureDetector(
                          onTap: () => controller.toggleTab(0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: controller.selectedTab.value == 0
                                  ? AppColors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                'Video',
                                style: TextStyle(
                                  color: controller.selectedTab.value == 0
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => GestureDetector(
                          onTap: () => controller.toggleTab(1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: controller.selectedTab.value == 1
                                  ? AppColors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                'Resources',
                                style: TextStyle(
                                  color: controller.selectedTab.value == 1
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
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
              const SizedBox(height: 20),
              // Tab Content based on Enrollment status
              Obx(() {
                if (!controller.isEnrolled.value) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6FCF7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFD4EED8)),
                        ),
                        child: const Center(
                          child: Text(
                            'Enroll in this program to unlock all video lectures and resources.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      CustomButton(
                        text: 'Enroll Now',
                        height: 52,
                        borderRadius: 26,
                        onPressed: controller.enroll,
                      ),
                    ],
                  );
                }                // If Enrolled & Completed:
                if (controller.isCourseCompleted.value) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6FCF7),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD4EED8)),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.workspace_premium_outlined, size: 40, color: AppColors.primary),
                        const SizedBox(height: 10),
                        const Text(
                          'Course Completed!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'You have finished Solar Energy System Developer. Download your certificate below.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 18),
                        CustomButton(
                          text: 'Get Certificate',
                          icon: const Icon(Icons.download_rounded, color: Colors.white, size: 20),
                          height: 48,
                          borderRadius: 24,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }

                if (controller.selectedTab.value == 0) {
                  // Video Playlist
                  return Column(
                    children: [
                      ...List.generate(controller.lessons.length, (index) {
                        final lesson = controller.lessons[index];
                        final isPlaying = controller.currentLessonIndex.value == index;
                        return _buildPlaylistItem(
                          lesson['title']!,
                          lesson['duration']!,
                          isPlaying,
                          onTap: () => controller.playLesson(index),
                        );
                      }),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: 'Mark Course as Complete',
                        isOutlined: true,
                        onPressed: controller.completeCourse,
                      ),
                    ],
                  );
                } else {
                  // Resources
                  return Column(
                    children: [
                      _buildResourceItem(
                        'Solar Design Handbook.pdf',
                        'PDF • 2.4 MB',
                        onDownload: () => controller.downloadResource('Solar Design Handbook.pdf'),
                      ),
                      _buildResourceItem(
                        'Wiring Diagrams.pdf',
                        'PDF • 1.1 MB',
                        onDownload: () => controller.downloadResource('Wiring Diagrams.pdf'),
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: 'Mark Course as Complete',
                        isOutlined: true,
                        onPressed: controller.completeCourse,
                      ),
                    ],
                  );
                }
              }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textCol,
        ),
      ),
    );
  }

  Widget _buildPlaylistItem(String title, String duration, bool isPlaying, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isPlaying ? const Color(0xFFEDF9F1) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isPlaying ? AppColors.primary : AppColors.border,
            width: isPlaying ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isPlaying ? const Color(0xFFD4EED8) : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: isPlaying ? AppColors.primary : AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isPlaying ? FontWeight.bold : FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceItem(String filename, String info, {VoidCallback? onDownload}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.description_outlined, color: Color(0xFF2563EB), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  info,
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDownload,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.arrow_downward_rounded, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
