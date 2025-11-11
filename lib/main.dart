// main.dart
// Entry point of the Flutter app — sets up global theme and runs the first screen.

import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Royal Bank of Canada',
      debugShowCheckedModeBanner: false,

      // Global theme for the entire app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        scaffoldBackgroundColor: Colors.grey.shade100,

        // Custom text style
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
        ),

        // Styled buttons with rounded corners
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),

      // App starts at the Welcome screen
      home: const WelcomeScreen(),
    );
  }
}
