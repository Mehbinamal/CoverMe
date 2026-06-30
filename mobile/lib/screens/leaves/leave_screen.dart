import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/leave_provider.dart';
import '../../widgets/leave_card.dart';
import 'add_leave_screen.dart';
import 'package:intl/intl.dart';

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
        title: const Text("Leaves"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddLeaveScreen(),
            ),
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

              //-----------------------------------
              // Today's Leaves
              //-----------------------------------

              const Text(
                "Today's Leaves",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (provider.todayLeaves.isEmpty)

                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "No teachers are on leave today.",
                    ),
                  ),
                )

              else

                ...provider.todayLeaves.map(

                  (item) => LeaveCard(

                    leave: item.leave,

                    teacher: item.teacher,

                    onDelete: () async {

                    final confirm =
                          await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text(
                            "Delete Leave?",
                          ),
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
                      }

                    },

                  ),

                ),

              const SizedBox(height: 30),

              //-----------------------------------
              // Upcoming Leaves
              //-----------------------------------

              const Divider(),

              const SizedBox(height: 20),

              const Text(
                "Upcoming Leaves",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (provider.upcomingLeaves.isEmpty)

                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "No upcoming leaves.",
                    ),
                  ),
                )

              else

                ...provider.upcomingLeaves.map(

                  (item) => LeaveCard(

                    leave: item.leave,

                    teacher: item.teacher,

                    onDelete: () async {
                      final confirm =
                            await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text(
                              "Delete Leave?",
                            ),
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
                              content: Text(
                                "Leave deleted successfully.",
                              ),
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