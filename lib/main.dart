import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Core/AppTheme.dart';
import 'Providers/ThemeProvider.dart';
import 'Providers/AuthProvider.dart';
import 'Providers/ChatProvider.dart';
import 'Screens/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NeuroChatApp());
}

class NeuroChatApp extends StatelessWidget {
  const NeuroChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return AnimatedTheme(
            data:
                themeProvider.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
            duration: const Duration(milliseconds: 300),
            child: MaterialApp(
              title: 'NeuroChat',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
