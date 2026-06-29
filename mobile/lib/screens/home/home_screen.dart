import 'package:flutter/material.dart';

import '../../widgets/current_period_card.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/greeting_header.dart';
import '../../widgets/timetable_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Leave"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const GreetingHeader(),

              const CurrentPeriodCard(),

              const SizedBox(height: 18),

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: const [
                    DashboardCard(
                      title: "Teachers on Leave",
                      value: "3",
                      icon: Icons.person_off,
                      color: Colors.red,
                    ),
                    SizedBox(width: 14),
                    DashboardCard(
                      title: "Pending Tasks",
                      value: "5",
                      icon: Icons.assignment,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const TimetableCard(),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}