import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/teacher.dart';
import '../../providers/teacher_details_provider.dart';
import '../../widgets/day_timetable_card.dart';

class TeacherDetailsScreen extends StatefulWidget {
  final Teacher teacher;

  const TeacherDetailsScreen({super.key, required this.teacher});

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  static const dayNames = [
    "",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeacherDetailsProvider>().loadTeacher(widget.teacher);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TeacherDetailsProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(widget.teacher.name)),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                final day = index + 1;

                return DayTimetableCard(
                  dayName: dayNames[day],
                  timetable: provider.weeklyTimetable[day]!,
                );
              },
            ),
    );
  }
}
