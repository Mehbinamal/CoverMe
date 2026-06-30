import 'package:flutter/material.dart';

class PeriodTile extends StatelessWidget {
  final int period;
  final String classroom;
  final String subject;
  final bool isFree;

  const PeriodTile({
    super.key,
    required this.period,
    required this.classroom,
    required this.subject,
    this.isFree = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isFree ? Colors.green.shade50 : Colors.white,
      child: ListTile(
        leading: CircleAvatar(child: Text("P$period")),
        title: Text(isFree ? "FREE PERIOD" : classroom),
        subtitle: Text(isFree ? "☕ Relax" : subject),
      ),
    );
  }
}
