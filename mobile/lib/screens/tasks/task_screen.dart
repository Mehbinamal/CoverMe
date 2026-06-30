import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';
import '../../widgets/assigned_task_card.dart';
import '../../widgets/assign_bottom_sheet.dart';
import '../../widgets/task_card.dart';
import '../../providers/assignment_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
          title: const Text("Tasks"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Pending (${provider.pendingTasks.length})",
              ),
              Tab(
                text: "Assigned (${provider.assignedTasks.length})",
              ),
            ],
          ),
        ),
        body: provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [

                  //---------------------------------
                  // Pending Tasks
                  //---------------------------------

                  provider.pendingTasks.isEmpty
                      ? const Center(
                          child: Text(
                            "No Pending Tasks",
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              provider.pendingTasks.length,
                          itemBuilder: (context, index) {
                            final task =
                                provider.pendingTasks[index];

                            return TaskCard(
                              task: task,
                              onAssign: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (_) {
                                    return AssignBottomSheet(
                                      task: task,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),

                  //---------------------------------
                  // Assigned Tasks
                  //---------------------------------

                  provider.assignedTasks.isEmpty
                      ? const Center(
                          child: Text(
                            "No Assigned Tasks",
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              provider.assignedTasks.length,
                          itemBuilder: (context, index) {
                            final task =
                                provider.assignedTasks[index];

                            return AssignedTaskCard(

                              task: task,

                              onEdit: () {

                                showModalBottomSheet(

                                  context: context,

                                  isScrollControlled: true,

                                  builder: (_) {

                                    return AssignBottomSheet(
                                      task: task,
                                    );

                                  },

                                );

                              },

                              onDelete: () async {

                                await context
                                    .read<AssignmentProvider>()
                                    .removeAssignment(
                                      task.task.id!,
                                    );

                                await context
                                    .read<TaskProvider>()
                                    .loadTasks();

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