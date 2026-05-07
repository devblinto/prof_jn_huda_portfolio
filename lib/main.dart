import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ProfMnHudaApp());
}

class ProfMnHudaApp extends StatelessWidget {
  const ProfMnHudaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skinn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC9A84C),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
