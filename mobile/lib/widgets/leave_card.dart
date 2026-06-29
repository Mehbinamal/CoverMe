import 'package:flutter/material.dart';

import '../models/leave.dart';
import '../models/teacher.dart';

class LeaveCard extends StatelessWidget {
  final Leave leave;
  final Teacher teacher;
  final VoidCallback onDelete;

  const LeaveCard({
    super.key,
    required this.leave,
    required this.teacher,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person_off),
        ),
        title: Text(teacher.name),
        subtitle: Text(
          leave.reason.isEmpty
              ? "No reason"
              : leave.reason,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}