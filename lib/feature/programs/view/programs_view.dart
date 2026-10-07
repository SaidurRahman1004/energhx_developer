import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/programs_controller.dart';
import 'widgets/program_card.dart';

class ProgramsView extends GetView<ProgramsController> {
  const ProgramsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Your all Programs'),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgramCard(
                title: 'Solar Energy System Developer',
                imageUrl: AppImages.solarBanner,
                onTap: () => Get.toNamed(AppRoutes.programDetails),
              ),
              ProgramCard(
                title: 'Wind Energy System Developer',
                imageUrl: AppImages.windBanner,
                onTap: () => Get.toNamed(AppRoutes.programDetails),
              ),
              ProgramCard(
                title: 'Biomass Energy System Developer',
                imageUrl: AppImages.biomassBanner,
                onTap: () => Get.toNamed(AppRoutes.programDetails),
              ),
              const SizedBox(height: 8),
              // Upgrade banner with exact Figma mint styling
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF9F1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFBCE7C6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upgrade to Standard Plan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Unlock advanced courses and take the next step toward becoming a Certified Associate.”',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 14),
                    CustomButton(
                      text: 'Upgrade Now',
                      height: 44,
                      borderRadius: 22,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
