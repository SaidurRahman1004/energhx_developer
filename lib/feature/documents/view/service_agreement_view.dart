import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controller/service_agreement_controller.dart';

class ServiceAgreementView extends GetView<ServiceAgreementController> {
  const ServiceAgreementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Service Agreement'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blue info banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.infoBlueLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: AppColors.infoBlue, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'This document was automatically retrieved based on your selected Utility Provider, Jurisdiction, and Engineering Services. Content is dynamically generated from backend regulatory data sources.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.infoBlue,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Document Overview
              const Text(
                'Document Overview',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Grid connection terms, metering arrangements, net metering credit schedule, and utility service obligations as mandated by the utility provider.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Pages', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                      Text('12 pages', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last Updated', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                      Text('June 2028', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Table of Contents
              _buildTocTile('1', 'Terms & Conditions'),
              _buildTocTile('2', 'Obligations & Rights'),
              _buildTocTile('3', 'Regulatory Compliance'),
              _buildTocTile('4', 'Signatures & Execution'),
              const SizedBox(height: 20),

              // Section 2: Signatory Information
              Row(
                children: [
                  _buildSectionBadge('2'),
                  const SizedBox(width: 8),
                  const Text(
                    'Signatory Information',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Full Legal Name',
                hintText: 'Full name',
                controller: controller.legalNameController,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Email Address',
                hintText: 'Legal email address',
                controller: controller.emailController,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Date',
                hintText: 'Select date',
                controller: controller.dateController,
                readOnly: true,
                suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
                onTap: () => controller.pickDate(context),
              ),
              const SizedBox(height: 20),

              // Section 3: Digital Signature
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 1.0),
                ),
                child: Column(
                  children: [
                    // Section Header inside card
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                      child: Row(
                        children: [
                          _buildSectionBadge('3'),
                          const SizedBox(width: 8),
                          const Text(
                            'Digital Signature',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Signature Mode Switcher Tabs
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.edit_outlined, size: 16, color: AppColors.textPrimary),
                                      SizedBox(width: 6),
                                      Text(
                                        'Draw Signature',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.title_rounded, size: 16, color: AppColors.textMuted),
                                      SizedBox(width: 6),
                                      Text(
                                        'Type Signature',
                                        style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Upload Signature link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.file_upload_outlined, size: 16, color: AppColors.textSecondary),
                              SizedBox(width: 6),
                              Text(
                                'Upload Signature',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Signature canvas with dotted/dashed line
                          Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                            ),
                            child: Signature(
                              controller: controller.signatureController,
                              height: 140,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Draw your signature in the box above',
                                style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                              ),
                              GestureDetector(
                                onTap: controller.clearSignature,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: const Text(
                                    'Clear',
                                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              CustomButton(
                text: 'Done',
                height: 52,
                borderRadius: 26,
                onPressed: controller.submitAgreement,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTocTile(String num, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(num, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSectionBadge(String num) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          num,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
