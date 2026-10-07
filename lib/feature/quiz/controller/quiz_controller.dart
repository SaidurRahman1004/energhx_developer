import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class QuizQuestion {
  final int id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}

class QuizController extends GetxController {
  // Key: Question ID, Value: Selected Option Index (0 = a, 1 = b, 2 = c, 3 = d)
  final selectedAnswers = <int, int>{}.obs;

  // Active module quiz title
  final quizTitle = 'Modules 1'.obs;

  // Questions matching Figma Quiz (1).png
  final List<QuizQuestion> questions = const [
    QuizQuestion(
      id: 1,
      question:
          '1. Which of the following is present in plant cells but absent in animal cells?',
      options: ['Mitochondria', 'Chloroplast', 'Ribosomes', 'Golgi body'],
      correctOptionIndex: 1, // b: Chloroplast
    ),
    QuizQuestion(
      id: 2,
      question: '2. The fluid inside the cell where organelles are embedded is-',
      options: ['Protoplasm', 'Cytosol', 'Nucleoplasm', 'Matrix'],
      correctOptionIndex: 1, // b: Cytosol
    ),
    QuizQuestion(
      id: 3,
      question: '3.Which organelle is called the “powerhouse of the cell”?',
      options: ['Ribosome', 'Mitochondria', 'Golgi apparatus', 'Lysosome'],
      correctOptionIndex: 1, // b: Mitochondria
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Default select option b for Question 1 to match Figma screenshot preview
    selectedAnswers[1] = 1;
  }

  void selectOption(int questionId, int optionIndex) {
    selectedAnswers[questionId] = optionIndex;
  }

  void submitQuiz() {
    if (selectedAnswers.length < questions.length) {
      Get.snackbar(
        'Incomplete Quiz',
        'Please answer all ${questions.length} questions before submitting.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE11D48),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    int score = 0;
    for (final q in questions) {
      if (selectedAnswers[q.id] == q.correctOptionIndex) {
        score++;
      }
    }

    final percentage = ((score / questions.length) * 100).toInt();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.r,
                height: 64.r,
                decoration: const BoxDecoration(
                  color: AppColors.primarySubtle,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primary,
                    size: 38.sp,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Quiz Completed!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'You scored $score out of ${questions.length} ($percentage%)',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Great job! Your understanding of this module has been successfully verified.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5.sp,
                  color: const Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  onPressed: () {
                    Get.back(); // close dialog
                    Get.back(); // return to Quiz list or Course details
                  },
                  child: Text(
                    'Done',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
