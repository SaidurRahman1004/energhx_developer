import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class ServiceAgreementController extends GetxController {
  final legalNameController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();

  final isDrawSignature = true.obs;

  late final SignatureController signatureController;

  @override
  void onInit() {
    super.onInit();
    signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.transparent,
    );
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
              primary: Color(0xFF2DAD00),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void toggleSignatureType(bool isDraw) {
    isDrawSignature.value = isDraw;
  }

  void clearSignature() {
    signatureController.clear();
  }

  void submitAgreement() {
    Get.back();
    Get.snackbar(
      'Success',
      'Service Agreement signed successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2DAD00),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    legalNameController.dispose();
    emailController.dispose();
    dateController.dispose();
    signatureController.dispose();
    super.onClose();
  }
}
