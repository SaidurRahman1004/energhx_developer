import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Blue Informational Notice
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFDBEAFE), width: 0.93),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: const Color(0xFF2563EB),
                      size: 18.sp,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'This document was automatically retrieved based on your selected Utility Provider, Jurisdiction, and Engineering Services. Content is dynamically generated from backend regulatory data sources.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5.sp,
                          color: const Color(0xFF1D4ED8),
                          height: 1.45,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // 2. Document Overview Section
              Text(
                'Document Overview',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Grid connection terms, metering arrangements, net metering credit schedule, and utility service obligations as mandated by the utility provider.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              SizedBox(height: 14.h),

              // Metadata: Total Pages & Last Updated
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Pages',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.sp,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        '12 pages',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 48.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Updated',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.sp,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'June 2026',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Table of Contents Card (Numbered 1-4)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11.12.r),
                  border: Border.all(color: const Color(0xFFE1E5E2), width: 0.93),
                ),
                child: Column(
                  children: [
                    _buildTocRow('1', 'Terms & Conditions'),
                    const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                    _buildTocRow('2', 'Obligations & Rights'),
                    const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                    _buildTocRow('3', 'Regulatory Compliance'),
                    const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                    _buildTocRow('4', 'Signatures & Execution'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // 3. Section 2: Signatory Information Card (Exact Figma spec)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11.12.r),
                  border: Border.all(color: const Color(0xFFE1E5E2), width: 0.93),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildSectionBadge('2'),
                        SizedBox(width: 8.w),
                        Text(
                          'Signatory Information',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildFieldLabel('Full Legal Name'),
                    SizedBox(height: 6.h),
                    _buildInputField(
                      controller: controller.legalNameController,
                      hintText: 'Full name',
                    ),
                    SizedBox(height: 14.h),
                    _buildFieldLabel('Email Address'),
                    SizedBox(height: 6.h),
                    _buildInputField(
                      controller: controller.emailController,
                      hintText: 'Legal email address',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 14.h),
                    _buildFieldLabel('Date'),
                    SizedBox(height: 6.h),
                    _buildDateField(context),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // 4. Section 3: Digital Signature Card (Exact Figma spec)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11.12.r),
                  border: Border.all(color: const Color(0xFFE1E5E2), width: 0.93),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildSectionBadge('3'),
                        SizedBox(width: 8.w),
                        Text(
                          'Digital Signature',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Top Mode Switcher: Draw Signature | Type Signature
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectTab(0),
                              child: Container(
                                height: 38.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: controller.selectedTab.value == 0
                                        ? const Color(0xFFE1E5E2)
                                        : Colors.transparent,
                                    width: 0.93,
                                  ),
                                  boxShadow: controller.selectedTab.value == 0
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.03),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 15.sp,
                                      color: controller.selectedTab.value == 0
                                          ? const Color(0xFF0F172A)
                                          : const Color(0xFF94A3B8),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Draw Signature',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12.sp,
                                        fontWeight: controller.selectedTab.value == 0
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        color: controller.selectedTab.value == 0
                                            ? const Color(0xFF0F172A)
                                            : const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectTab(1),
                              child: Container(
                                height: 38.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: controller.selectedTab.value == 1
                                        ? const Color(0xFFE1E5E2)
                                        : Colors.transparent,
                                    width: 0.93,
                                  ),
                                  boxShadow: controller.selectedTab.value == 1
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.03),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.title_rounded,
                                      size: 15.sp,
                                      color: controller.selectedTab.value == 1
                                          ? const Color(0xFF0F172A)
                                          : const Color(0xFF94A3B8),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Type Signature',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12.sp,
                                        fontWeight: controller.selectedTab.value == 1
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        color: controller.selectedTab.value == 1
                                            ? const Color(0xFF0F172A)
                                            : const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Centered Upload Signature Action Link
                    GestureDetector(
                      onTap: () => controller.selectTab(2),
                      child: Obx(
                        () {
                          final isUploadActive = controller.selectedTab.value == 2;
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_upload_outlined,
                                  size: 16.sp,
                                  color: isUploadActive
                                      ? AppColors.primary
                                      : const Color(0xFF64748B),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Upload Signature',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.sp,
                                    fontWeight: isUploadActive
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isUploadActive
                                        ? AppColors.primary
                                        : const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Dynamic Interactive Signature Canvas / Field
                    Obx(() {
                      final mode = controller.selectedTab.value;
                      if (mode == 0) {
                        return _buildDrawSignatureBox();
                      } else if (mode == 1) {
                        return _buildTypeSignatureBox();
                      } else {
                        return _buildUploadSignatureBox();
                      }
                    }),
                    SizedBox(height: 10.h),

                    // Bottom info label & Clear action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          final mode = controller.selectedTab.value;
                          String hint = 'Draw your signature in the box above';
                          if (mode == 1) {
                            hint = 'Type your name to generate signature';
                          } else if (mode == 2) {
                            hint = controller.uploadedSignatureFile.value != null
                                ? 'Uploaded signature preview'
                                : 'Tap box above to select signature';
                          }
                          return Text(
                            hint,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.sp,
                              color: const Color(0xFF94A3B8),
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: controller.clearSignature,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
                            ),
                            child: Text(
                              'Clear',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.sp,
                                color: const Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),

              // 5. Done Button (Exact Figma pill button)
              Obx(
                () {
                  final isSigned = controller.isSignatureProvided;
                  return SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: controller.submitAgreement,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSigned
                            ? const Color(0xFF2DAD00)
                            : const Color(0xFFCCE8C4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // --- Draw Signature Box with Figma dotted guideline ---
  Widget _buildDrawSignatureBox() {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: const Color(0xFFCBD5E1),
        strokeWidth: 1.2,
        dashWidth: 5.0,
        dashGap: 3.5,
        radius: 8.r,
      ),
      child: Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Subtle Figma Center Guideline: ------------ X ------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const _DottedLine(color: Color(0xFF93C5FD)),
                    ),
                  ),
                  Text(
                    '✕',
                    style: TextStyle(
                      color: const Color(0xFF60A5FA),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const _DottedLine(color: Color(0xFF93C5FD)),
                    ),
                  ),
                ],
              ),
              // Interactive drawing canvas
              Signature(
                controller: controller.signatureController,
                height: 140.h,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Type Signature Box with real handwritten cursive script ---
  Widget _buildTypeSignatureBox() {
    return Column(
      children: [
        // Input text field to type name
        Container(
          height: 42.h,
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xFFE1E5E2), width: 0.93),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller.typedSignatureController,
            style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'Type your name to create signature',
              hintStyle: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF94A3B8),
                fontSize: 12.5.sp,
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        // Preview box with cursive handwriting signature
        CustomPaint(
          painter: _DashedBorderPainter(
            color: const Color(0xFFCBD5E1),
            strokeWidth: 1.2,
            dashWidth: 5.0,
            dashGap: 3.5,
            radius: 8.r,
          ),
          child: Container(
            height: 110.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Guideline
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const _DottedLine(color: Color(0xFFCBD5E1)),
                ),
                // Rendered signature
                Obx(
                  () => Text(
                    controller.typedSignatureController.text.isEmpty
                        ? 'Your Signature'
                        : controller.typedSignatureController.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dancingScript(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w700,
                      color: controller.typedSignatureController.text.isEmpty
                          ? const Color(0xFFCBD5E1)
                          : const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Upload Signature Box with ImagePicker ---
  Widget _buildUploadSignatureBox() {
    return GestureDetector(
      onTap: controller.pickSignatureImage,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: const Color(0xFFCBD5E1),
          strokeWidth: 1.2,
          dashWidth: 5.0,
          dashGap: 3.5,
          radius: 8.r,
        ),
        child: Container(
          height: 140.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Obx(() {
              final file = controller.uploadedSignatureFile.value;
              if (file != null) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      file,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.refresh_rounded, color: Colors.white, size: 16.sp),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDF9F1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.cloud_upload_outlined,
                      color: AppColors.primary,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Upload Signature Image',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'PNG, JPG of your signature from device',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.sp,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTocRow(String num, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            child: Text(
              num,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF2DAD00),
                fontWeight: FontWeight.w700,
                fontSize: 13.5.sp,
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionBadge(String num) {
    return Container(
      width: 22.r,
      height: 22.r,
      decoration: const BoxDecoration(
        color: Color(0xFF2DAD00),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          num,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 12.5.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE1E5E2), width: 0.93),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, color: const Color(0xFF0F172A)),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: const Color(0xFF94A3B8),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickDate(context),
      child: Container(
        height: 46.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFE1E5E2), width: 0.93),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: controller.dateController,
                enabled: false,
                style: GoogleFonts.plusJakartaSans(fontSize: 13.sp, color: const Color(0xFF0F172A)),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Select date',
                  hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 16.sp,
              color: const Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final length = math.min(dashWidth, metric.length - distance);
        final extract = metric.extractPath(distance, distance + length);
        canvas.drawPath(extract, paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.radius != radius;
  }
}

class _DottedLine extends StatelessWidget {
  final Color color;
  const _DottedLine({required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 4.0;
        const dashSpace = 3.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(count, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
