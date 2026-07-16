import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/assignment_provider.dart';
import '../../providers/task_provider.dart';
import '../../services/task_share_service.dart';
import '../../widgets/assigned_task_card.dart';
import '../../widgets/assign_bottom_sheet.dart';
import '../../widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskShareService _taskShareService = TaskShareService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Tasks",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            PopupMenuButton<String>(
              tooltip: 'Share assigned tasks',
              onSelected: (value) async {
                await _taskShareService.shareAssignedTasks(
                  context: context,
                  tasks: provider.allAssignedTasks.isNotEmpty
                      ? provider.allAssignedTasks
                      : provider.assignedTasks,
                  asPdf: value == 'pdf',
                );
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'pdf',
                  child: Row(
                    children: [
                      Icon(Icons.picture_as_pdf_outlined),
                      SizedBox(width: 8),
                      Text('Share as PDF'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'text',
                  child: Row(
                    children: [
                      Icon(Icons.share_outlined),
                      SizedBox(width: 8),
                      Text('Share as text'),
                    ],
                  ),
                ),
              ],
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.share_outlined),
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: "Pending (${provider.pendingTasks.length})"),
              Tab(text: "Assigned (${provider.assignedTasks.length})"),
            ],
          ),
        ),
        body: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  provider.pendingTasks.isEmpty
                      ? const Center(child: Text("No Pending Tasks"))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 8,
                          ),
                          itemCount: provider.pendingTasks.length,
                          itemBuilder: (context, index) {
                            final task = provider.pendingTasks[index];

                            return TaskCard(
                              task: task,
                              onAssign: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (_) {
                                    return AssignBottomSheet(task: task);
                                  },
                                );
                              },
                            );
                          },
                        ),
                  provider.assignedTasks.isEmpty
                      ? const Center(child: Text("No Assigned Tasks"))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 8,
                          ),
                          itemCount: provider.assignedTasks.length,
                          itemBuilder: (context, index) {
                            final task = provider.assignedTasks[index];

                            return AssignedTaskCard(
                              task: task,
                              onEdit: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (_) {
                                    return AssignBottomSheet(task: task);
                                  },
                                );
                              },
                              onDelete: () async {
                                final assignmentProvider = context
                                    .read<AssignmentProvider>();
                                await assignmentProvider.removeAssignment(
                                  task.task.id!,
                                );

                                if (!mounted) return;

                                if (!context.mounted) return;

                                final taskProvider = context
                                    .read<TaskProvider>();
                                await taskProvider.loadTasks();
                              },
                            );
                          },
                        ),
                  ],
                ),
      ),
    );
  }

}
