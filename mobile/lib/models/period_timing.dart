import 'package:flutter/material.dart';

class PeriodTiming {
  final int period;
  final TimeOfDay start;
  final TimeOfDay end;

  const PeriodTiming({
    required this.period,
    required this.start,
    required this.end,
  });
}