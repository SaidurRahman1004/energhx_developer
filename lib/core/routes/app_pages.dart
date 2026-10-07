import 'package:get/get.dart';
import '../../feature/auth/controller/auth_controller.dart';
import '../../feature/auth/view/forgot_password_view.dart';
import '../../feature/auth/view/login_view.dart';
import '../../feature/auth/view/otp_verification_view.dart';
import '../../feature/auth/view/set_new_password_view.dart';
import '../../feature/auth/view/sign_up_view.dart';
import '../../feature/courses/controller/courses_controller.dart';
import '../../feature/dashboard/controller/dashboard_controller.dart';
import '../../feature/dashboard/view/dashboard_view.dart';
import '../../feature/documents/controller/service_agreement_controller.dart';
import '../../feature/documents/view/service_agreement_view.dart';
import '../../feature/experience/controller/experience_controller.dart';
import '../../feature/home/controller/home_controller.dart';
import '../../feature/onboarding/controller/onboarding_controller.dart';
import '../../feature/onboarding/view/onboarding_view.dart';
import '../../feature/programs/controller/programs_controller.dart';
import '../../feature/programs/view/course_details_view.dart';
import '../../feature/programs/view/program_details_view.dart';
import '../../feature/quiz/controller/quiz_controller.dart';
import '../../feature/quiz/view/quiz_detail_view.dart';
import '../../feature/quiz/view/quiz_list_view.dart';
import '../../feature/settings/controller/settings_controller.dart';
import '../../feature/settings/view/change_password_view.dart';
import '../../feature/settings/view/edit_profile_view.dart';
import '../../feature/notifications/controller/notifications_controller.dart';
import '../../feature/notifications/view/notifications_view.dart';
import '../../feature/splash/controller/splash_controller.dart';
import '../../feature/splash/view/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(
          () => OnboardingController(),
          fenix: true,
        );
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.setNewPassword,
      page: () => const SetNewPasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DashboardController>(
          () => DashboardController(),
          fenix: true,
        );
        Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
        Get.lazyPut<ProgramsController>(
          () => ProgramsController(),
          fenix: true,
        );
        Get.lazyPut<CoursesController>(() => CoursesController(), fenix: true);
        Get.lazyPut<ExperienceController>(
          () => ExperienceController(),
          fenix: true,
        );
        Get.lazyPut<SettingsController>(
          () => SettingsController(),
          fenix: true,
        );
      }),
    ),
    GetPage(
      name: AppRoutes.programDetails,
      page: () => const ProgramDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProgramsController>(
          () => ProgramsController(),
          fenix: true,
        );
      }),
    ),
    GetPage(
      name: AppRoutes.courseDetails,
      page: () => const CourseDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProgramsController>(
          () => ProgramsController(),
          fenix: true,
        );
      }),
    ),
    GetPage(
      name: AppRoutes.quizzes,
      page: () => const QuizListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<QuizController>(() => QuizController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.quizDetail,
      page: () => const QuizDetailView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<QuizController>(() => QuizController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(
          () => SettingsController(),
          fenix: true,
        );
      }),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(
          () => SettingsController(),
          fenix: true,
        );
      }),
    ),
    GetPage(
      name: AppRoutes.serviceAgreement,
      page: () => const ServiceAgreementView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ServiceAgreementController>(
          () => ServiceAgreementController(),
          fenix: true,
        );
      }),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NotificationsController>(
          () => NotificationsController(),
          fenix: true,
        );
      }),
    ),
  ];
}
