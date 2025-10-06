import 'package:flutter/material.dart';
import 'pages/resume_home.dart';

void main() {
  runApp(const ResumeMakerApp());
}

class ResumeMakerApp extends StatelessWidget {
  const ResumeMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFF1976D2);
    return MaterialApp(
      title: 'Resume Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: accentColor,
        scaffoldBackgroundColor: const Color(0xFF060606),
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentColor,
          brightness: Brightness.dark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: accentColor,
          ),
        ),
        toggleButtonsTheme: ToggleButtonsThemeData(
          selectedColor: Colors.black,
          fillColor: accentColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      home: const ResumeHomePage(),
    );
  }
}
