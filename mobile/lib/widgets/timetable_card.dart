import 'package:flutter/material.dart';

import 'period_tile.dart';

class TimetableCard extends StatelessWidget {
  const TimetableCard({
    super.key,
    required this.timetable,
    });

    Column(

        children: timetable.map((period){

            return PeriodTile(

                period: period.period,

                classroom: period.classroom ?? "",

                subject: period.subject ?? "",

                isFree: period.isFree,

            );

        }).toList(),

)
}