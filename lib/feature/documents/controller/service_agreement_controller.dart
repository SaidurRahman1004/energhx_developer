import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

class ServiceAgreementController extends GetxController {
  // Signatory form fields
  final legalNameController = TextEditingController(text: 'Zahirul Piash');
  final emailController = TextEditingController(text: 'Pia2225@gmail.com');
  final dateController = TextEditingController();

  // Signature modes: 0: Draw, 1: Type, 2: Upload
  final selectedTab = 0.obs;

  // Draw Signature
  late final SignatureController signatureController;
  final isDrawNotEmpty = false.obs;

  // Type Signature
  final typedSignatureController = TextEditingController(text: 'Zahirul Piash');
  final typedSignatureText = 'Zahirul Piash'.obs;
  final isTypeNotEmpty = true.obs;

  // Upload Signature
  final uploadedSignatureFile = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Default current date
    final now = DateTime.now();
    dateController.text =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

    signatureController = SignatureController(
      penStrokeWidth: 2.8,
      penColor: const Color(0xFF0F172A),
      exportBackgroundColor: Colors.transparent,
    );

    signatureController.addListener(() {
      isDrawNotEmpty.value = signatureController.isNotEmpty;
    });

    typedSignatureController.addListener(() {
      typedSignatureText.value = typedSignatureController.text;
      isTypeNotEmpty.value = typedSignatureController.text.trim().isNotEmpty;
    });

    legalNameController.addListener(() {
      if (selectedTab.value != 1 || typedSignatureController.text.isEmpty) {
        typedSignatureController.text = legalNameController.text;
        typedSignatureText.value = legalNameController.text;
      }
    });
  }

  bool get isSignatureProvided {
    if (selectedTab.value == 0) return isDrawNotEmpty.value;
    if (selectedTab.value == 1) return isTypeNotEmpty.value;
    return uploadedSignatureFile.value != null;
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF22C55E),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void selectTab(int index) {
    selectedTab.value = index;
  }

  Future<void> pickSignatureImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 600,
        imageQuality: 90,
      );

      if (image != null) {
        final file = File(image.path);
        if (await file.exists()) {
          uploadedSignatureFile.value = file;
          selectedTab.value = 2;
        }
      }
    } catch (e) {
      debugPrint('[ServiceAgreementController] Error picking signature: $e');
    }
  }

  void clearSignature() {
    if (selectedTab.value == 0) {
      signatureController.clear();
      isDrawNotEmpty.value = false;
    } else if (selectedTab.value == 1) {
      typedSignatureController.clear();
      typedSignatureText.value = '';
      isTypeNotEmpty.value = false;
    } else {
      uploadedSignatureFile.value = null;
    }
  }

  void submitAgreement() {
    Get.back();
    Get.snackbar(
      'Agreement Executed',
      'Your Service Agreement has been signed and recorded.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF22C55E),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    legalNameController.dispose();
    emailController.dispose();
    dateController.dispose();
    typedSignatureController.dispose();
    signatureController.dispose();
    super.onClose();
  }
}
