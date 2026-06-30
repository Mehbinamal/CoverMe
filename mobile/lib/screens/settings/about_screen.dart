import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            const SizedBox(height: 30),

            const Icon(
              Icons.school,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              "CoverMe",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Offline Teacher Substitution Management System",
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            const Text("Version 1.0.0"),

            const SizedBox(height: 8),

            const Text(
              "Built with Flutter & SQLite",
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}