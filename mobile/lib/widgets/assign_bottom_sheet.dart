import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_item.dart';
import '../providers/assignment_provider.dart';
import 'select_teacher_tile.dart';
import '../providers/task_provider.dart';

class AssignBottomSheet extends StatefulWidget {
  final TaskItem task;

  const AssignBottomSheet({
    super.key,
    required this.task,
  });

  @override
  State<AssignBottomSheet> createState() =>
      _AssignBottomSheetState();
}

class _AssignBottomSheetState
    extends State<AssignBottomSheet> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      context.read<AssignmentProvider>().loadTeachers(

        task: widget.task.task,

        date: widget.task.task.date,

      );

    });

  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<AssignmentProvider>();

    return SafeArea(

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: provider.isLoading

            ? const Center(
                child:
                    CircularProgressIndicator(),
              )

            : Column(

                mainAxisSize:
                    MainAxisSize.min,

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "Assign Substitute",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Class : ${widget.task.task.classroom}",
                  ),

                  Text(
                    "Subject : ${widget.task.task.subject}",
                  ),

                  Text(
                    "Period : ${widget.task.task.period}",
                  ),

                  Text(
                    "Absent : ${widget.task.teacher.name}",
                  ),

                  const SizedBox(height: 25),

                  if (provider.preferred.isNotEmpty)

                    const Text(
                      "Preferred Teachers",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                  ...provider.preferred.map(

                    (teacher) => SelectTeacherTile(

                      teacher: teacher,

                      selected:
                          provider.selectedTeacher?.id ==
                              teacher.id,

                      onTap: () {

                        provider.selectTeacher(
                          teacher,
                        );

                      },

                    ),

                  ),

                  if (provider.others.isNotEmpty)

                    const Padding(

                      padding: EdgeInsets.only(
                        top: 16,
                      ),

                      child: Text(
                        "Other Teachers",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                    ),

                  ...provider.others.map(

                    (teacher) => SelectTeacherTile(

                      teacher: teacher,

                      selected:
                          provider.selectedTeacher?.id ==
                              teacher.id,

                      onTap: () {

                        provider.selectTeacher(
                          teacher,
                        );

                      },

                    ),

                  ),

                  const SizedBox(height: 20),

                  SizedBox(

                    width: double.infinity,

                    child: FilledButton(

                      onPressed:
                          provider.selectedTeacher == null

                              ? null

                              : () async {

                                  await provider.assign(
                                    widget.task.task.id!,
                                  );

                                  if (!mounted) return;

                                  await context
                                    .read<TaskProvider>()
                                    .loadTasks();

                                  Navigator.pop(
                                      context);

                                },

                      child: const Text(
                        "ASSIGN",
                      ),

                    ),

                  ),

                ],

              ),

      ),

    );

  }

}