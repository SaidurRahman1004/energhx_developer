import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExperienceController extends GetxController {
  // Experience fields
  final workEngagementController = TextEditingController();
  final addressController = TextEditingController();
  final jobTitleController = TextEditingController();
  final startDateText = 'Select here'.obs;
  final endDateText = 'Select here'.obs;

  // Publication fields
  final publisherController = TextEditingController();
  final pubTitleController = TextEditingController();
  final authorsController = TextEditingController();
  final pagesController = TextEditingController();
  final selectedYear = 'Select here'.obs;

  // Reference fields
  final referenceNameController = TextEditingController();

  // Uploaded files
  final uploadedFileNames = <String>[].obs;

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
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
      final formatted = DateFormat('dd/MM/yyyy').format(picked);
      if (isStartDate) {
        startDateText.value = formatted;
      } else {
        endDateText.value = formatted;
      }
    }
  }

  void pickYear(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final currentYear = DateTime.now().year;
        final years = List.generate(40, (index) => (currentYear - index).toString());

        return AlertDialog(
          title: const Text('Select Year', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: years.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(years[index]),
                  onTap: () {
                    selectedYear.value = years[index];
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> pickFiles() async {
    try {
      final List<PlatformFile> files = await FilePicker.pickFiles(
        type: FileType.any,
      );

      if (files.isNotEmpty) {
        for (var file in files) {
          if (!uploadedFileNames.contains(file.name)) {
            uploadedFileNames.add(file.name);
          }
        }
        Get.snackbar(
          'Files Selected',
          '${files.length} file(s) attached successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF2DAD00),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      debugPrint('[ExperienceController] pickFiles error: $e');
    }
  }

  void removeFile(int index) {
    uploadedFileNames.removeAt(index);
  }

  void addExperience() {
    Get.snackbar(
      'Experience Added',
      'Experience item saved to list',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2DAD00),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  void addPublication() {
    Get.snackbar(
      'Publication Added',
      'Publication item saved to list',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2DAD00),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  void addReference() {
    Get.snackbar(
      'Reference Added',
      'Reference item saved to list',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2DAD00),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  void submitExperience() {
    Get.snackbar(
      'Success',
      'Experiences submitted successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF2DAD00),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    workEngagementController.dispose();
    addressController.dispose();
    jobTitleController.dispose();
    publisherController.dispose();
    pubTitleController.dispose();
    authorsController.dispose();
    pagesController.dispose();
    referenceNameController.dispose();
    super.onClose();
  }
}
