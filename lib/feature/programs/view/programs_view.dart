import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/routes/app_routes.dart';
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
                imageUrl: AppImages.programCardBanner,
                onTap: () => Get.toNamed(AppRoutes.programDetails),
              ),
              ProgramCard(
                title: 'Solar Energy System Developer',
                imageUrl: AppImages.programCardBanner,
                onTap: () => Get.toNamed(AppRoutes.programDetails),
              ),
              ProgramCard(
                title: 'Solar Energy System Developer',
                imageUrl: AppImages.programCardBanner,
                onTap: () => Get.toNamed(AppRoutes.programDetails),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
