import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String _formatDate(String date) {
    final leaveDate = DateTime.parse(date);
    final today = DateTime.now();

    final todayOnly = DateTime(today.year, today.month, today.day);
    final leaveOnly = DateTime(leaveDate.year, leaveDate.month, leaveDate.day);

    final difference = leaveOnly.difference(todayOnly).inDays;

    if (difference == 0) {
      return "Today";
    }

    if (difference == 1) {
      return "Tomorrow";
    }

    if (difference < 7) {
      return DateFormat('EEEE').format(leaveDate);
    }

    return DateFormat('dd MMM').format(leaveDate);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person_off)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_formatDate(leave.date) != "Today")
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Chip(
                  avatar: const Icon(Icons.calendar_today, size: 16),
                  label: Text(_formatDate(leave.date)),
                ),
              ),
            Text(teacher.name),
          ],
        ),
        subtitle: Text(leave.reason.isEmpty ? "No reason" : leave.reason),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
