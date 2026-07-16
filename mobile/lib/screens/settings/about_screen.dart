import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.school, size: 80),
                  const SizedBox(height: 20),
                  const Text(
                    "CoverMe",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Offline Teacher Substitution Management System",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const Text("Version 1.5.0"),
                  const SizedBox(height: 8),
                  const Text("Built with Flutter & SQLite"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
