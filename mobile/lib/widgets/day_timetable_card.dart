import 'package:flutter/material.dart';

import '../models/timetable.dart';
import 'period_tile.dart';

class DayTimetableCard extends StatelessWidget {
  final String dayName;
  final List<Timetable?> timetable;

  const DayTimetableCard({
    super.key,
    required this.dayName,
    required this.timetable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            ...List.generate(timetable.length, (index) {
              final period = timetable[index];

              if (period == null) {
                return PeriodTile(
                  period: index + 1,
                  classroom: "",
                  subject: "",
                  isFree: true,
                );
              }

              return PeriodTile(
                period: period.period,
                classroom: period.classroom,
                subject: period.subject,
              );
            }),
          ],
        ),
      ),
    );
  }
}
