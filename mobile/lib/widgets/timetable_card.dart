import 'package:flutter/material.dart';

import 'period_tile.dart';

class TimetableCard extends StatelessWidget {
  const TimetableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: const [
            Text(
              "My Timetable",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 15),
            PeriodTile(
              period: 1,
              classroom: "10A",
              subject: "Mathematics",
            ),
            PeriodTile(
              period: 2,
              classroom: "",
              subject: "",
              isFree: true,
            ),
            PeriodTile(
              period: 3,
              classroom: "9B",
              subject: "Physics",
            ),
            PeriodTile(
              period: 4,
              classroom: "Office",
              subject: "",
            ),
          ],
        ),
      ),
    );
  }
}