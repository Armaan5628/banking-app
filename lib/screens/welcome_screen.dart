// welcome_screen.dart
// Elegant Welcome Screen with bordered glowing icon and unique design.

import 'package:flutter/material.dart';
import 'account_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🪙 Elegant bordered glowing icon area
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xFFE3F2FD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.9),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade900.withOpacity(0.3),
                    blurRadius: 18,
                    spreadRadius: 4,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              // 🌐 Updated modern finance icon
              child: const Icon(
                Icons.apartment_rounded, // modern corporate-bank style icon
                size: 60,
                color: Color(0xFF0D47A1),
              ),
            ),

            const SizedBox(height: 35),

            // Title
            const Text(
              'Welcome to Royal Bank of Canada',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 10),

            // Today's Date
            Text(
              'Today: ${today.year}-${today.month}-${today.day}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 45),

            // View Accounts Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AccountListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0D47A1),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 14),
                shadowColor: Colors.black26,
              ),
              child: const Text(
                'View Accounts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
