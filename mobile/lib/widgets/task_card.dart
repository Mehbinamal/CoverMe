import 'package:flutter/material.dart';

import '../models/task_item.dart';
import '../models/teacher.dart';

class TaskCard extends StatelessWidget {

  final TaskItem task;

  final VoidCallback onAssign;

  const TaskCard({

    super.key,

    required this.task,

    required this.onAssign,

  });

  @override
  Widget build(BuildContext context) {

    return Card(
    margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
    ),
    child: InkWell(
        onTap: onAssign,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
        leading: CircleAvatar(
            child: Icon(Icons.assignment),
        ),
        title: Text(task.task.classroom),
        subtitle: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
                Text("Subject: ${task.task.subject}"),
                Text("Absent: ${task.absentTeacher.name}"),
                Text("Period: ${task.task.period}"),
            ],
        ),
        trailing: const Icon(
            Icons.arrow_forward_ios,
        ),
        ),
    ),
    );

  }

}