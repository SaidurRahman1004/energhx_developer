import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgramsController extends GetxController {
  final selectedTab = 0.obs; // 0 for Video, 1 for Resources
  final isEnrolled = false.obs;
  final isCourseCompleted = false.obs;

  // Active lesson playing
  final currentLessonIndex = 0.obs;
  final isVideoPlaying = false.obs;

  final lessons = [
    {
      'title': 'Introduction to Solar Systems',
      'duration': '08:24',
      'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    },
    {
      'title': 'Photovoltaic Panel Design',
      'duration': '12:10',
      'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    },
    {
      'title': 'Installation & Wiring',
      'duration': '15:45',
      'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    },
    {
      'title': 'Inverter Configurations',
      'duration': '10:15',
      'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    },
  ];

  void toggleTab(int index) {
    selectedTab.value = index;
  }

  void enroll() {
    isEnrolled.value = true;
    isVideoPlaying.value = true;
  }

  void completeCourse() {
    isCourseCompleted.value = true;
    Get.snackbar(
      'Congratulations!',
      'You have completed the Solar Energy System Developer course.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2DAD00),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  void playLesson(int index) {
    currentLessonIndex.value = index;
    isVideoPlaying.value = true;
  }

  void togglePlayPause() {
    isVideoPlaying.value = !isVideoPlaying.value;
  }

  void downloadResource(String fileName) {
    Get.snackbar(
      'Downloading',
      '$fileName is being downloaded...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E293B),
      colorText: Colors.white,
      icon: const Icon(Icons.downloading_rounded, color: Color(0xFF2DAD00)),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void downloadCertificate() {
    Get.snackbar(
      'Certificate Downloaded',
      'Your certificate has been saved to your downloads folder.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2DAD00),
      colorText: Colors.white,
      icon: const Icon(Icons.workspace_premium, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}
