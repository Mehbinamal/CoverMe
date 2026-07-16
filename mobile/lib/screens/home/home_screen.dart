import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../widgets/current_period_card.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/greeting_header.dart';
import '../../widgets/section_title.dart';
import '../../widgets/timetable_card.dart';
import '../leaves/add_leave_screen.dart';

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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddLeaveScreen()),
          );
        },
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
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.assignment_turned_in_outlined),
                            SizedBox(width: 8),
                            Text(
                              "Current Period Details",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (dashboard.currentPeriodTask == null)
                          const Text(
                            "No class task is scheduled for the current period.",
                          )
                        else ...[
                          Text(
                            "Class: ${dashboard.currentPeriodTask!.task.classroom}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Subject: ${dashboard.currentPeriodTask!.task.subject}",
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Teacher on leave: ${dashboard.currentPeriodTask!.absentTeacher.name}",
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Assigned teacher: ${dashboard.currentPeriodTask!.assignedTeacher?.name ?? "Pending"}",
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Period: ${dashboard.currentPeriodTask!.task.period}",
                          ),
                        ],
                      ],
                    ),
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
