import 'package:flutter/material.dart';

import '../constants/school_schedule.dart';
import '../../models/period_timing.dart';

class PeriodUtils {
  static int _toMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  static PeriodTiming? currentPeriod() {
    final now = TimeOfDay.now();

    final currentMinutes = _toMinutes(now);

    for (final period in SchoolSchedule.periods) {
      final start = _toMinutes(period.start);
      final end = _toMinutes(period.end);

      if (currentMinutes >= start && currentMinutes <= end) {
        return period;
      }
    }

    return null;
  }

  static String schoolStatus() {
    final now = TimeOfDay.now();
    final currentMinutes = _toMinutes(now);

    final first = SchoolSchedule.periods.first;
    final last = SchoolSchedule.periods.last;

    if (currentMinutes < _toMinutes(first.start)) {
      return "Before School";
    }

    if (currentMinutes > _toMinutes(last.end)) {
      return "School Over";
    }

    return "Break";
  }
}
