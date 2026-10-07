import 'package:get/get.dart';

class CoursesController extends GetxController {
  final selectedProgram = RxnString();
  final programList = <String>[
    'Solar Energy System Developer',
    'Wind Energy System Developer',
    'Biomass Energy System Developer',
  ].obs;
}
