import 'package:flutter/material.dart';

import '../models/teacher.dart';

class SelectTeacherTile extends StatelessWidget {
  final Teacher teacher;
  final bool selected;
  final VoidCallback onTap;

  const SelectTeacherTile({
    super.key,
    required this.teacher,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: ListTile(
        leading: CircleAvatar(child: Text(teacher.name.substring(0, 1))),
        title: Text(teacher.name),
        trailing: selected ? const Icon(Icons.check_circle) : null,
        onTap: onTap,
      ),
    );
  }
}
