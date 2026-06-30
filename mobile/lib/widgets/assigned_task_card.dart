import 'package:flutter/material.dart';

import '../models/task_item.dart';

class AssignedTaskCard extends StatelessWidget {

  final TaskItem task;

  const AssignedTaskCard({

    super.key,

    required this.task,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      child: ListTile(

        leading: const CircleAvatar(

          backgroundColor: Colors.green,

          child: Icon(
            Icons.check,
            color: Colors.white,
          ),

        ),

        title: Text(
          task.task.classroom,
        ),

        subtitle: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(task.task.subject),

            Text(
              "Absent : ${task.absentTeacher.name}",
            ),

            Text(
              "Assigned : ${task.assignedTeacher!.name}",
            ),

          ],

        ),

      ),

    );

  }

}