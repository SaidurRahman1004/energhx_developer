import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controller/experience_controller.dart';

class ExperienceView extends GetView<ExperienceController> {
  const ExperienceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Work Experiences'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Experiences
              _buildSectionHeader('Experiences'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Work engagement name',
                      hintText: 'Write here',
                      controller: controller.workEngagementController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Address',
                      hintText: 'Write here',
                      controller: controller.addressController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Job title',
                      hintText: 'Write here',
                      controller: controller.jobTitleController,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Start Date',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: () => controller.pickDate(context, true),
                                child: Container(
                                  height: 52,
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.startDateText.value,
                                          style: TextStyle(
                                            color: controller.startDateText.value == 'Select here'
                                                ? AppColors.textMuted
                                                : AppColors.textPrimary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textMuted),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'End Date',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: () => controller.pickDate(context, false),
                                child: Container(
                                  height: 52,
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.endDateText.value,
                                          style: TextStyle(
                                            color: controller.endDateText.value == 'Select here'
                                                ? AppColors.textMuted
                                                : AppColors.textPrimary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textMuted),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              CustomButton(
                text: 'Add Experience',
                isOutlined: true,
                height: 48,
                borderRadius: 24,
                onPressed: controller.addExperience,
              ),
              const SizedBox(height: 24),

              // Section 2: Publications
              _buildSectionHeader('Publications'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Publisher',
                      hintText: 'Write here',
                      controller: controller.publisherController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Title',
                      hintText: 'Write here',
                      controller: controller.pubTitleController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: 'Authors',
                      hintText: 'Write here',
                      controller: controller.authorsController,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Pages',
                            hintText: 'Write here',
                            controller: controller.pagesController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Year',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: () => controller.pickYear(context),
                                child: Container(
                                  height: 52,
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.selectedYear.value,
                                          style: TextStyle(
                                            color: controller.selectedYear.value == 'Select here'
                                                ? AppColors.textMuted
                                                : AppColors.textPrimary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down_rounded, size: 22, color: AppColors.textMuted),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              CustomButton(
                text: 'Add Publication',
                isOutlined: true,
                height: 48,
                borderRadius: 24,
                onPressed: controller.addPublication,
              ),
              const SizedBox(height: 24),

              // Section 3: References
              _buildSectionHeader('References'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: CustomTextField(
                  label: 'Reference name',
                  hintText: 'Write here',
                  controller: controller.referenceNameController,
                ),
              ),
              const SizedBox(height: 14),
              CustomButton(
                text: 'Add Reference',
                isOutlined: true,
                height: 48,
                borderRadius: 24,
                onPressed: controller.addReference,
              ),
              const SizedBox(height: 24),

              // Section 4: Recommendation Letters
              _buildSectionHeader('Recommendation Letters'),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: controller.pickFiles,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary, width: 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.file_upload_outlined, color: AppColors.primary, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Upload Files',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Attached Files List
              Obx(() {
                if (controller.uploadedFileNames.isEmpty) return const SizedBox.shrink();
                return Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF9F1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFBCE7C6)),
                  ),
                  child: Column(
                    children: List.generate(controller.uploadedFileNames.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.attach_file, color: AppColors.primary, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                controller.uploadedFileNames[index],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18, color: AppColors.error),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => controller.removeFile(index),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                );
              }),
              const SizedBox(height: 28),
              CustomButton(
                text: 'Submit',
                height: 52,
                borderRadius: 26,
                onPressed: controller.submitExperience,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}
