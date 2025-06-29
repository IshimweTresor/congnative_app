import 'package:flutter/material.dart';
import 'services/theme_service.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeService(),
      builder: (context, child) {
        final themeService = ThemeService();
        return MaterialApp(
          title: 'Cognitive Assistant',
          debugShowCheckedModeBanner: false,
          theme: themeService.lightTheme,
          darkTheme: themeService.darkTheme,
          themeMode: themeService.themeMode,
          home: SplashScreen(),
        );
      },
    );
  }
}
