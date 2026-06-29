import 'package:flutter/material.dart';

import '../models/timetable.dart';
import 'period_tile.dart';

class TimetableCard extends StatelessWidget {
  final List<Timetable?> timetable;

  const TimetableCard({
    super.key,
    required this.timetable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
  timetable.length,
  (index) {
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
  },
),
            ),
        ),
    );
  }
}