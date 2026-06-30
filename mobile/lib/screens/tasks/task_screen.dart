import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';
import '../../widgets/task_card.dart';
import '../../widgets/assign_bottom_sheet.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() =>
      _TaskScreenState();
}

class _TaskScreenState
    extends State<TaskScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<TaskProvider>()
          .loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<TaskProvider>();

    return Scaffold(

      body: provider.isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : provider.tasks.isEmpty

              ? const Center(
                  child:
                      Text("No Pending Tasks"),
                )

              : ListView.builder(

                  itemCount:
                      provider.tasks.length,

                  itemBuilder:
                      (context,index){

                    final task =
                        provider.tasks[index];

                    return TaskCard(

                      task: task,

                      onAssign: (){

                        showModalBottomSheet(

                          context: context,

                          isScrollControlled: true,

                          builder: (_){

                            return AssignBottomSheet(
                              task: task,
                            );

                          },

                        );

                      },

                    );

                  },

                ),

    );

  }
}