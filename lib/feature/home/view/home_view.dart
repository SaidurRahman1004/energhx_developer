import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../controller/home_controller.dart';
import 'widgets/overview_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      AppImages.homeAvatar,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primarySubtle,
                        child: Icon(Icons.person, color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back !',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.userName.value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.notifications),
                    child: Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2DAD00).withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(81.r),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              AppIcons.homeBell,
                              width: 42.w,
                              height: 42.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 9.w,
                            right: 9.w,
                            child: Container(
                              width: 8.r,
                              height: 8.r,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              // Card 1: All Program (Green solid)
              Obx(
                () => OverviewCard(
                  icon: Icons.school_outlined,
                  count: '${controller.allProgramsCount.value}',
                  label: 'All Program',
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              // Card 2: Enrolled Programs (Mint light with subtle green border)
              Obx(
                () => OverviewCard(
                  icon: Icons.menu_book_outlined,
                  count: '${controller.enrolledProgramsCount.value}',
                  label: 'Enrolled Programs',
                  backgroundColor: const Color(0xFFEDF9F1),
                  textColor: const Color(0xFF0F172A),
                  iconColor: AppColors.primary,
                  borderColor: const Color(0xFFBCE7C6),
                ),
              ),
              const SizedBox(height: 12),
              // Card 3: Completed Programs (Mint light with subtle green border)
              Obx(
                () => OverviewCard(
                  icon: Icons.workspace_premium_outlined,
                  count: '${controller.completedProgramsCount.value}',
                  label: 'Completed Programs',
                  backgroundColor: const Color(0xFFEDF9F1),
                  textColor: const Color(0xFF0F172A),
                  iconColor: AppColors.primary,
                  borderColor: const Color(0xFFBCE7C6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
