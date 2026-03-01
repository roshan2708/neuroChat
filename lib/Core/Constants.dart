class AppConstants {
  AppConstants._();

  static const String geminiApiKey = 'paste here';
  static const String geminiModel = 'gemini-2.5-flash';
  static const String geminiBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';

  static const String appName = 'NeuroChat';
  static const String appTagline = 'Powered by Gemini AI';

  static const double maxContentWidth = 900.0;
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 24.0;
  static const double radiusFull = 100.0;

  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 600);
  static const Duration splashDelay = Duration(seconds: 2);
  static const Duration typingDelay = Duration(milliseconds: 1200);

  static const String prefThemeMode = 'theme_mode';

  static const String systemPrompt =
      'You are NeuroChat, a helpful, friendly, and concise AI assistant. '
      'Always respond in a clear, well-structured manner. '
      'Keep responses focused and avoid unnecessary fluff.';
}
