import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../widgets/current_period_card.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/greeting_header.dart';
import '../../widgets/section_title.dart';
import '../../widgets/timetable_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    if (provider.isLoading) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.error != null) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(child: Text(provider.error!)),
      );
    }

    final dashboard = provider.dashboard!;

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Leave"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GreetingHeader(teacherName: dashboard.hm.name),
                const SizedBox(height: 12),
                const SectionTitle(title: "Overview"),
                CurrentPeriodCard(currentPeriod: 3),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      DashboardCard(
                        title: "Teachers on Leave",
                        value: dashboard.leaveCount.toString(),
                        icon: Icons.person_off,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 12),
                      DashboardCard(
                        title: "Pending Tasks",
                        value: dashboard.pendingTasks.toString(),
                        icon: Icons.assignment,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TimetableCard(timetable: dashboard.timetable),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: const Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
