class AppRoutes {
  AppRoutes._();

  // Auth & Onboarding Flow
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String setNewPassword = '/set-new-password';
  static const String signUp = '/sign-up';

  // Main Dashboard (Shell)
  static const String dashboard = '/dashboard';

  // Feature Screens
  static const String home = '/home';
  static const String programs = '/programs';
  static const String programDetails = '/program-details';
  static const String courseDetails = '/course-details';
  static const String courses = '/courses';
  static const String experience = '/experience';
  static const String settings = '/settings';
  static const String notifications = '/notifications';

  // Quiz Flow
  static const String quizzes = '/quizzes';
  static const String quizDetail = '/quiz-detail';

  // Settings & Profile Sub-screens
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';
  static const String serviceAgreement = '/service-agreement';
}
