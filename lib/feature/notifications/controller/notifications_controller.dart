import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final String group; // 'Today' or 'Earlier'
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String? route;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.group,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.route,
    this.isRead = false,
  });
}

class NotificationsController extends GetxController {
  // 0: All, 1: Unread
  final selectedFilter = 0.obs;

  final notifications = <NotificationModel>[
    NotificationModel(
      id: '1',
      title: 'Course Enrolled Successfully',
      message:
          'You have successfully enrolled in "Solar Energy System Developer". All modules and video lectures are now unlocked.',
      time: '15m ago',
      group: 'Today',
      icon: Icons.school_rounded,
      iconColor: AppColors.primary,
      iconBgColor: const Color(0xFFEDF9F1),
      route: AppRoutes.courseDetails,
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'Certificate Ready for Download!',
      message:
          'Congratulations! Your verified Energhx Developer Certificate for Solar Energy Systems is ready to download.',
      time: '2h ago',
      group: 'Today',
      icon: Icons.workspace_premium_rounded,
      iconColor: const Color(0xFFF59E0B),
      iconBgColor: const Color(0xFFFEF3C7),
      route: AppRoutes.courseDetails,
      isRead: false,
    ),
    NotificationModel(
      id: '3',
      title: 'New Video Lecture Available',
      message:
          'Module 2: "Photovoltaic Panel Design & String Sizing" is now live with enhanced video playback.',
      time: '1d ago',
      group: 'Earlier',
      icon: Icons.play_circle_fill_rounded,
      iconColor: const Color(0xFF2563EB),
      iconBgColor: const Color(0xFFEFF6FF),
      route: AppRoutes.courseDetails,
      isRead: true,
    ),
    NotificationModel(
      id: '4',
      title: 'Quiz Passed with 95% Score',
      message:
          'Excellent work! You passed the Solar Energy Fundamentals Quiz and qualified for final developer certification.',
      time: '2d ago',
      group: 'Earlier',
      icon: Icons.quiz_rounded,
      iconColor: const Color(0xFF8B5CF6),
      iconBgColor: const Color(0xFFF5F3FF),
      route: AppRoutes.quizzes,
      isRead: true,
    ),
    NotificationModel(
      id: '5',
      title: 'Service Agreement Archived',
      message:
          'Your digitally signed Utility Grid Connection Agreement has been approved and securely registered.',
      time: '4d ago',
      group: 'Earlier',
      icon: Icons.assignment_turned_in_rounded,
      iconColor: const Color(0xFF0D9488),
      iconBgColor: const Color(0xFFCCFBF1),
      route: AppRoutes.serviceAgreement,
      isRead: true,
    ),
  ].obs;

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  List<NotificationModel> get filteredNotifications {
    if (selectedFilter.value == 1) {
      return notifications.where((n) => !n.isRead).toList();
    }
    return notifications;
  }

  void setFilter(int index) {
    selectedFilter.value = index;
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1 && !notifications[index].isRead) {
      notifications[index].isRead = true;
      notifications.refresh();
    }
  }

  void markAllAsRead() {
    for (final item in notifications) {
      item.isRead = true;
    }
    notifications.refresh();
    Get.snackbar(
      'Updated',
      'All notifications marked as read',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  void deleteNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  void clearAll() {
    notifications.clear();
  }

  void onNotificationTap(NotificationModel item) {
    markAsRead(item.id);
    if (item.route != null) {
      Get.toNamed(item.route!);
    }
  }
}
