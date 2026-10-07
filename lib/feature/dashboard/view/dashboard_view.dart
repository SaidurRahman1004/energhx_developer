import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../courses/view/courses_view.dart';
import '../../experience/view/experience_view.dart';
import '../../home/view/home_view.dart';
import '../../programs/view/programs_view.dart';
import '../../settings/view/settings_view.dart';
import '../controller/dashboard_controller.dart';
import 'widgets/custom_bottom_nav_bar.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(),
      const ProgramsView(),
      const CoursesView(),
      const ExperienceView(),
      const SettingsView(),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTabIndex,
        ),
      ),
    );
  }
}
