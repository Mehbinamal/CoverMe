import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/leave_provider.dart';
import '../../widgets/leave_card.dart';
import '../../widgets/section_title.dart';
import 'add_leave_screen.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeaveProvider>().loadLeaves();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LeaveProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Leaves",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddLeaveScreen()),
          );

          provider.loadLeaves();
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await provider.loadLeaves();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SectionTitle(title: "Today's Leaves"),
            if (provider.todayLeaves.isEmpty)
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("No teachers are on leave today."),
                ),
              )
            else
              ...provider.todayLeaves.map(
                (item) => LeaveCard(
                  leave: item.leave,
                  teacher: item.teacher,
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Delete Leave?"),
                        content: const Text(
                          "Are you sure you want to delete this leave?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text("Cancel"),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await provider.delete(item.leave);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Leave deleted successfully."),
                        ),
                      );
                    }
                  },
                ),
              ),
            const SizedBox(height: 20),
            const SectionTitle(title: "Upcoming Leaves"),
            if (provider.upcomingLeaves.isEmpty)
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(Icons.event_available, size: 48, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        "No upcoming leaves",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Future leave requests will appear here.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              ...provider.upcomingLeaves.map(
                (item) => LeaveCard(
                  leave: item.leave,
                  teacher: item.teacher,
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Delete Leave?"),
                        content: const Text(
                          "Are you sure you want to delete this leave?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text("Cancel"),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await provider.delete(item.leave);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Leave deleted successfully."),
                        ),
                      );
                    }
                  },
                ),
              ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
