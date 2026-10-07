import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/certificate_service.dart';
import '../../../core/services/video_cache_service.dart';

class LessonItem {
  final String title;
  final String duration;
  final String videoUrl;

  const LessonItem({
    required this.title,
    required this.duration,
    required this.videoUrl,
  });
}

class ProgramsController extends GetxController {
  // Details.png vs Details (1).png state
  final isEnrolled = false.obs;

  // After Enrolement.png (Modules list) vs After Enrolement (1)/(2).png (Inside Module)
  final isModuleStarted = false.obs;
  final activeModuleId = 1.obs;

  // Basic Content (0) vs Content (1)
  final selectedContentType = 0.obs;

  // Active playing lesson index
  final currentLessonIndex = 0.obs;

  // Course completion state (After Enrolement (3).png)
  final isCourseCompleted = false.obs;
  final isDownloadingCert = false.obs;
  final lastDownloadedCertPath = RxnString();

  // Video Player state
  VideoPlayerController? videoPlayerController;
  final isVideoInitialized = false.obs;
  final isVideoPlaying = false.obs;
  final isVideoLoading = false.obs;

  // Fast-streaming & cacheable lesson videos
  final List<LessonItem> basicLessons = const [
    LessonItem(
      title: 'Introduction to Solar Systems',
      duration: '08:24',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    ),
    LessonItem(
      title: 'Photovoltaic Panel Design',
      duration: '12:10',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    ),
    LessonItem(
      title: 'Installation & Wiring',
      duration: '15:45',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    ),
    LessonItem(
      title: 'Inverter Configuration & Grid Connection',
      duration: '14:20',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyBlazes.mp4',
    ),
    LessonItem(
      title: 'Safety, Grounding & Standards',
      duration: '11:15',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    ),
    LessonItem(
      title: 'Testing, Commissioning & Maintenance',
      duration: '16:30',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
    ),
  ];

  final List<LessonItem> mainContentLessons = const [
    LessonItem(
      title: 'Solar Cell Physics & Chemistry',
      duration: '10:15',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    ),
    LessonItem(
      title: 'MPPT Tracking & DC-DC Optimization',
      duration: '14:40',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    ),
    LessonItem(
      title: 'Commercial Three-Phase Interconnection',
      duration: '18:50',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    ),
    LessonItem(
      title: 'Battery Energy Storage System (BESS)',
      duration: '15:30',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyBlazes.mp4',
    ),
    LessonItem(
      title: 'Protection Relays & Anti-Islanding',
      duration: '12:05',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    ),
    LessonItem(
      title: 'SCADA Monitoring & Performance Ratio',
      duration: '13:45',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
    ),
  ];

  List<LessonItem> get currentLessons =>
      selectedContentType.value == 0 ? basicLessons : mainContentLessons;

  void enroll() {
    isEnrolled.value = true;
    Get.snackbar(
      'Enrolled Successfully',
      'You have unlocked all course materials and video lectures.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void startModule(int moduleId) {
    activeModuleId.value = moduleId;
    isModuleStarted.value = true;
    currentLessonIndex.value = 0;
    loadVideo(currentLessons[0].videoUrl);
  }

  void backToModulesOverview() {
    isModuleStarted.value = false;
    pauseVideo();
  }

  void selectContentType(int type) {
    if (selectedContentType.value != type) {
      selectedContentType.value = type;
      currentLessonIndex.value = 0;
      loadVideo(currentLessons[0].videoUrl);
    }
  }

  void playLesson(int index) {
    currentLessonIndex.value = index;
    loadVideo(currentLessons[index].videoUrl);
  }

  /// Loads video using local disk caching for high performance and smooth playback.
  Future<void> loadVideo(String url) async {
    try {
      isVideoLoading.value = true;
      final oldController = videoPlayerController;
      videoPlayerController = null;
      isVideoInitialized.value = false;
      if (oldController != null) {
        try {
          await oldController.pause();
          await oldController.dispose();
        } catch (_) {}
      }

      // Check if video is already cached on device disk
      final cachedFile = await VideoCacheService.getCachedVideoFile(url);
      VideoPlayerController controller;

      if (cachedFile != null) {
        debugPrint('[ProgramsController] Playing from cache: ${cachedFile.path}');
        controller = VideoPlayerController.file(cachedFile);
      } else {
        debugPrint('[ProgramsController] Streaming and downloading to cache: $url');
        controller = VideoPlayerController.networkUrl(Uri.parse(url));
        // Cache in background for instant future loads
        VideoCacheService.cacheVideo(url);
      }

      videoPlayerController = controller;
      await controller.initialize();
      controller.setLooping(true);
      await controller.play();
      isVideoInitialized.value = true;
      isVideoPlaying.value = true;
    } catch (e) {
      debugPrint('[ProgramsController] Video load caught error: $e');
      isVideoInitialized.value = false;
      isVideoPlaying.value = false;
    } finally {
      isVideoLoading.value = false;
    }
  }

  void togglePlayPause() {
    if (videoPlayerController != null && videoPlayerController!.value.isInitialized) {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
        isVideoPlaying.value = false;
      } else {
        videoPlayerController!.play();
        isVideoPlaying.value = true;
      }
    } else {
      if (currentLessons.isNotEmpty) {
        loadVideo(currentLessons[currentLessonIndex.value].videoUrl);
      }
    }
  }

  void pauseVideo() {
    if (videoPlayerController != null && videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
      isVideoPlaying.value = false;
    }
  }

  void completeCourse() {
    isCourseCompleted.value = true;
    Get.snackbar(
      'Course Completed!',
      'Congratulations! You have completed Solar Energy System Developer.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  /// Generates the actual PDF certificate and saves it to device storage.
  Future<void> downloadCertificate() async {
    if (isDownloadingCert.value) return;

    try {
      isDownloadingCert.value = true;

      final filePath = await CertificateService.generateAndSaveCertificate(
        studentName: 'Zahirul Piash',
        programTitle: 'Solar Energy System Developer',
      );

      lastDownloadedCertPath.value = filePath;

      Get.snackbar(
        'Certificate Downloaded',
        'Saved to device: $filePath',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        icon: const Icon(Icons.workspace_premium, color: Colors.white),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 4),
        mainButton: TextButton(
          onPressed: () => CertificateService.openCertificate(filePath),
          child: const Text(
            'OPEN',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );

      // Also trigger open file so the user immediately sees it
      await CertificateService.openCertificate(filePath);
    } catch (e) {
      debugPrint('[ProgramsController] Certificate download error: $e');
      Get.snackbar(
        'Download Error',
        'Failed to save certificate: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isDownloadingCert.value = false;
    }
  }

  void openReviewModal() {
    final rating = 5.obs;
    final reviewController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              'Review Course',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'How was your learning experience?',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating.value ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: const Color(0xFFF59E0B),
                      size: 32.sp,
                    ),
                    onPressed: () => rating.value = index + 1,
                  );
                }),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: reviewController,
              maxLines: 3,
              style: GoogleFonts.plusJakartaSans(fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Share your thoughts about this course...',
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  color: AppColors.textMuted,
                ),
                fillColor: const Color(0xFFF8FAFC),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Review Submitted',
                    'Thank you for your valuable feedback!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.primary,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                  );
                },
                child: Text(
                  'Submit Review',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}
