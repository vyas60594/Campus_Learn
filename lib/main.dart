 import 'package:flutter/material.dart';
import 'user_screens/splash_screen.dart';

void main() {
  runApp(const CampusLearnApp());
}

class CampusLearnApp extends StatelessWidget {
  const CampusLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusLearn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF273645),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
