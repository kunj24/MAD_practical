import 'package:flutter/material.dart';
import 'pages/resume_home.dart';

void main() {
  runApp(const ResumeMakerApp());
}

class ResumeMakerApp extends StatelessWidget {
  const ResumeMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber[600],
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
      ),
      home: const ResumeHomePage(),
    );
  }
}
