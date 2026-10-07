import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import '../controller/service_agreement_controller.dart';

class ServiceAgreementView extends GetView<ServiceAgreementController> {
  const ServiceAgreementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 64.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Center(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 38.r,
                height: 38.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF22C55E),
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Service Agreement',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Blue Info Notice Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F7FF),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFDBEAFE), width: 1.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: const Color(0xFF2563EB),
                      size: 20.sp,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'This document was automatically retrieved based on your selected Utility Provider, Jurisdiction, and Engineering Services. Content is dynamically generated from backend regulatory data sources.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: const Color(0xFF1E40AF),
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Grid connection terms, metering arrangements, net metering credit schedule, and utility service obligations as mandated by the utility provider.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              SizedBox(height: 16.h),

              // Total Pages & Last Updated
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Pages',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '12 pages',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 50.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Updated',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'June 2026',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Section 1: Table of Contents / Checklist Card (1-4)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
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

              // Section 2: Signatory Information Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
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
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Full Legal Name
                    _buildFieldLabel('Full Legal Name'),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: controller.legalNameController,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: const Color(0xFF1E293B),
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Full name',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          color: const Color(0xFF94A3B8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF22C55E), width: 1.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Email Address
                    _buildFieldLabel('Email Address'),
                    SizedBox(height: 6.h),
                    TextField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: const Color(0xFF1E293B),
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Legal email address',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 14.sp,
                          color: const Color(0xFF94A3B8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF22C55E), width: 1.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Date
                    _buildFieldLabel('Date'),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () => controller.pickDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: controller.dateController,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            color: const Color(0xFF1E293B),
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Select date',
                            hintStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 14.sp,
                              color: const Color(0xFF94A3B8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                            suffixIcon: const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: Color(0xFF64748B),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Section 3: Digital Signature Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
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
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Top Row: Draw Signature | Type Signature
                    Obx(
                      () {
                        final tab = controller.selectedTab.value;
                        return Column(
                          children: [
                            Row(
                              children: [
                                // Tab 0: Draw Signature
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.selectTab(0),
                                    child: Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(
                                          color: tab == 0
                                              ? const Color(0xFFCBD5E1)
                                              : Colors.transparent,
                                          width: 1.0,
                                        ),
                                        boxShadow: tab == 0
                                            ? [
                                                BoxShadow(
                                                  color: Colors.black.withValues(alpha: 0.04),
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
                                            size: 16.sp,
                                            color: tab == 0
                                                ? const Color(0xFF0F172A)
                                                : const Color(0xFF94A3B8),
                                          ),
                                          SizedBox(width: 6.w),
                                          Text(
                                            'Draw Signature',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 13.sp,
                                              fontWeight: tab == 0
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                              color: tab == 0
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
                                // Tab 1: Type Signature
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.selectTab(1),
                                    child: Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(
                                          color: tab == 1
                                              ? const Color(0xFFCBD5E1)
                                              : Colors.transparent,
                                          width: 1.0,
                                        ),
                                        boxShadow: tab == 1
                                            ? [
                                                BoxShadow(
                                                  color: Colors.black.withValues(alpha: 0.04),
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
                                            size: 16.sp,
                                            color: tab == 1
                                                ? const Color(0xFF0F172A)
                                                : const Color(0xFF94A3B8),
                                          ),
                                          SizedBox(width: 6.w),
                                          Text(
                                            'Type Signature',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 13.sp,
                                              fontWeight: tab == 1
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                              color: tab == 1
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
                            SizedBox(height: 12.h),

                            // Centered Link: Upload Signature
                            GestureDetector(
                              onTap: () => controller.selectTab(2),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.file_upload_outlined,
                                      size: 17.sp,
                                      color: tab == 2
                                          ? const Color(0xFF22C55E)
                                          : const Color(0xFF94A3B8),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Upload Signature',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 13.sp,
                                        fontWeight: tab == 2
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: tab == 2
                                            ? const Color(0xFF22C55E)
                                            : const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 14.h),

                    // Active Signature Area Box
                    Obx(() {
                      final tab = controller.selectedTab.value;
                      if (tab == 0) {
                        return _buildDrawSignatureBox();
                      } else if (tab == 1) {
                        return _buildTypeSignatureBox();
                      } else {
                        return _buildUploadSignatureBox();
                      }
                    }),
                    SizedBox(height: 10.h),

                    // Bottom info label & Clear button
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
                              fontSize: 11.5.sp,
                              color: const Color(0xFF94A3B8),
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: controller.clearSignature,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: isSigned ? controller.submitAgreement : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSigned
                            ? const Color(0xFF22C55E)
                            : const Color(0xFFC7E8CB),
                        disabledBackgroundColor: const Color(0xFFC7E8CB),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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

  // --- Clean Drawing Canvas ---
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
        height: 160.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Signature(
            controller: controller.signatureController,
            height: 160.h,
            backgroundColor: Colors.transparent,
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
        TextField(
          controller: controller.typedSignatureController,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: 'Type your name to create signature',
            hintStyle: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF94A3B8),
              fontSize: 13.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF22C55E), width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
            ),
          ),
        ),
        SizedBox(height: 10.h),
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
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(
              () {
                final text = controller.typedSignatureText.value;
                return Text(
                  text.trim().isEmpty ? 'Your Signature' : text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dancingScript(
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                    color: text.trim().isEmpty
                        ? const Color(0xFFCBD5E1)
                        : const Color(0xFF0F172A),
                  ),
                );
              },
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
          height: 150.h,
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
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Image.file(
                        file,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.change_circle_outlined, color: Colors.white, size: 14.sp),
                            SizedBox(width: 4.w),
                            Text(
                              'Change',
                              style: TextStyle(color: Colors.white, fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 46.r,
                    height: 46.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDF9F1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cloud_upload_outlined,
                      color: Color(0xFF22C55E),
                      size: 24,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Upload Signature Image',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'PNG, JPG of your signature from device',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5.sp,
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
          Container(
            width: 22.r,
            height: 22.r,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF9F1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: Text(
              num,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF22C55E),
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5.sp,
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
      width: 24.r,
      height: 24.r,
      decoration: const BoxDecoration(
        color: Color(0xFF22C55E),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          num,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 12.5.sp,
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
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1E293B),
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
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
    this.radius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final length = (distance + dashWidth < metric.length)
            ? dashWidth
            : metric.length - distance;
        final extractPath = metric.extractPath(distance, distance + length);
        canvas.drawPath(extractPath, paint);
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
