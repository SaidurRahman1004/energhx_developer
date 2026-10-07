import 'package:get/get.dart';
import '../../../core/constants/app_images.dart';

class CourseModel {
  final String title;
  final String description;
  final String duration;
  final String lessons;
  final String level;
  final String image;
  final String price;
  final double progress;

  const CourseModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.lessons,
    required this.level,
    required this.image,
    required this.price,
    this.progress = 0.0,
  });
}

class CoursesController extends GetxController {
  final selectedProgram = RxnString('Solar Energy System Developer');

  final programList = <String>[
    'Solar Energy System Developer',
    'Wind Energy System Developer',
    'Biomass Energy System Developer',
  ].obs;

  // Solar Energy Courses (populated when Solar Energy System Developer is selected)
  final solarCourses = <CourseModel>[
    const CourseModel(
      title: 'Solar Energy System Developer',
      description:
          'This Programme provides the theoretical and practical fundamentals for prospective developers who aspire to get certified in solar technologies.',
      duration: '3h 20m',
      lessons: '3 lessons',
      level: 'BASIC',
      image: AppImages.solarBanner,
      price: '\$11,500',
      progress: 0.65,
    ),
    const CourseModel(
      title: 'Commercial Photovoltaic System Design',
      description:
          'Master CAD layout, string inverter sizing, voltage drop calculations, and three-phase interconnection standards.',
      duration: '5h 45m',
      lessons: '6 lessons',
      level: 'INTERMEDIATE',
      image: AppImages.programCardBanner,
      price: '\$14,200',
      progress: 0.25,
    ),
    const CourseModel(
      title: 'Solar Battery Storage & Microgrids',
      description:
          'Design off-grid and hybrid backup systems, lithium BMS management, and smart microgrid power distribution.',
      duration: '6h 15m',
      lessons: '8 lessons',
      level: 'ADVANCED',
      image: AppImages.powerCourse,
      price: '\$16,800',
      progress: 0.0,
    ),
  ];

  List<CourseModel> get currentCourses {
    if (selectedProgram.value == 'Solar Energy System Developer') {
      return solarCourses;
    }
    // Other programs currently have no courses as requested
    return [];
  }

  void selectProgram(String? program) {
    selectedProgram.value = program;
  }
}
