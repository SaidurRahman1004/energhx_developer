import 'package:get/get.dart';

class HomeController extends GetxController {
  final userName = 'Alex Mascon'.obs;
  final allProgramsCount = 3.obs;
  final enrolledProgramsCount = 0.obs;
  final completedProgramsCount = 0.obs;

  // Ready for API integration
  void fetchOverviewData() {
    // API call placeholder
  }
}
