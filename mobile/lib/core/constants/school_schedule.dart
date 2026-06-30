import 'package:flutter/material.dart';

import '../../models/period_timing.dart';

class SchoolSchedule {
  static const List<PeriodTiming> periods = [
    PeriodTiming(
      period: 1,
      start: TimeOfDay(hour: 9, minute: 30),
      end: TimeOfDay(hour: 10, minute: 15),
    ),
    PeriodTiming(
      period: 2,
      start: TimeOfDay(hour: 10, minute: 15),
      end: TimeOfDay(hour: 11, minute: 00),
    ),
    PeriodTiming(
      period: 3,
      start: TimeOfDay(hour: 11, minute: 15),
      end: TimeOfDay(hour: 12, minute: 00),
    ),
    PeriodTiming(
      period: 4,
      start: TimeOfDay(hour: 12, minute: 00),
      end: TimeOfDay(hour: 12, minute: 45),
    ),
    PeriodTiming(
      period: 5,
      start: TimeOfDay(hour: 13, minute: 45),
      end: TimeOfDay(hour: 14, minute: 45),
    ),
    PeriodTiming(
      period: 6,
      start: TimeOfDay(hour: 14, minute: 45),
      end: TimeOfDay(hour: 15, minute: 25),
    ),
    PeriodTiming(
      period: 7,
      start: TimeOfDay(hour: 15, minute: 30),
      end: TimeOfDay(hour: 16, minute: 00),
    ),
  ];
}
