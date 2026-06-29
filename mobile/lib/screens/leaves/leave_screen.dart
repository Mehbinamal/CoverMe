import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/leave_provider.dart';
import '../../widgets/leave_card.dart';
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
      context.read<LeaveProvider>().loadTodayLeaves();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<LeaveProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Today's Leaves"),
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

          provider.loadTodayLeaves();

        },
      ),

      body: provider.todayLeaves.isEmpty
          ? const Center(
              child: Text("No leaves today."),
            )
          : ListView.builder(

              itemCount: provider.todayLeaves.length,

              itemBuilder: (context, index) {

                final item = provider.todayLeaves[index];

                return LeaveCard(

                  leave: item.leave,

                  teacher: item.teacher,

                  onDelete: () async {

                    await provider.delete(item.leave);

                  },

                );

              },

            ),

    );
  }
}