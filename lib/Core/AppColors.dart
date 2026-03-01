import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color darkGraphite = Color(0xFF262626);
  static const Color lightBeige = Color(0xFFE2E8CE);
  static const Color solidWhite = Color(0xFFFFFFFF);

  static const Color primary = darkGraphite;
  static const Color primaryLight = darkGraphite;
  static const Color primaryDark = darkGraphite;
  static const Color accent = darkGraphite;
  static const Color accentLight = darkGraphite;

  static const Color lightBackground = lightBeige;
  static const Color lightSurface = lightBeige;
  static const Color lightSurfaceVariant = lightBeige;
  static const Color lightBorder = darkGraphite;

  static const Color darkBackground = darkGraphite;
  static const Color darkSurface = darkGraphite;
  static const Color darkSurfaceVariant = darkGraphite;
  static const Color darkBorder = lightBeige;

  static const Color lightTextPrimary = darkGraphite;
  static const Color lightTextSecondary = darkGraphite;
  static const Color lightTextHint = darkGraphite;

  static const Color darkTextPrimary = lightBeige;
  static const Color darkTextSecondary = lightBeige;
  static const Color darkTextHint = lightBeige;

  static const Color success = darkGraphite;
  static const Color error = darkGraphite;
  static const Color warning = darkGraphite;

  static const Color userBubbleLight = darkGraphite;
  static const Color aiBubbleLight = lightBeige;
  static const Color userBubbleDark = lightBeige;
  static const Color aiBubbleDark = darkGraphite;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [darkGraphite, darkGraphite],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [darkGraphite, darkGraphite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
