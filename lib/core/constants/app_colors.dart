import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand Colors (Exact Figma sampled green)
  static const Color primary = Color(0xFF2DAD00); 
  static const Color primaryLight = Color(0xFF38C708);
  static const Color primaryDark = Color(0xFF249000);
  static const Color primarySubtle = Color(0xFFE9F9EE); // Mint green for back button & badges
  static const Color primarySoft = Color(0xFFF2FBF4);

  // Splash Screen Background
  static const Color splashBackground = Color(0xFFF6FCF4);

  // Neutral & Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8FAFC);
  static const Color inputBackground = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A); // Dark slate
  static const Color textSecondary = Color(0xFF64748B); // Slate grey
  static const Color textMuted = Color(0xFF9CA3AF); // Light grey placeholder
  static const Color textWhite = Color(0xFFFFFFFF);

  // Border & Divider Colors
  static const Color border = Color(0xFFA1A1A1); // Exact Figma spec: #A1A1A1
  static const Color borderFocused = Color(0xFF2DAD00);
  static const Color divider = Color(0xFFF1F5F9);

  // Functional Status Colors
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF2DAD00);
  static const Color warning = Color(0xFFF59E0B);
  static const Color infoBlue = Color(0xFF2563EB);
  static const Color infoBlueLight = Color(0xFFEFF6FF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2DAD00), Color(0xFF38C708)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Darkens image backgrounds while keeping the upper portion visible.
  static const LinearGradient darkOverlayGradient = LinearGradient(
    colors: [Color(0x00000000), Color(0xD9000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
