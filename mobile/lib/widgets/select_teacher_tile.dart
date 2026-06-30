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

    return ListTile(

      leading: Radio<bool>(

        value: true,

        groupValue: selected,

        onChanged: (_) => onTap(),

      ),

      title: Text(teacher.name),

      onTap: onTap,

    );

  }

}