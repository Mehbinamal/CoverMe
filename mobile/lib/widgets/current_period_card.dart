import 'package:flutter/material.dart';

import '../core/utils/period_utils.dart';

class CurrentPeriodCard extends StatelessWidget {
  final int currentPeriod;
  const CurrentPeriodCard({
    super.key,
    required this.currentPeriod,
  });

  @override
  Widget build(BuildContext context) {
    final current = PeriodUtils.currentPeriod();

    final status = PeriodUtils.schoolStatus();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: current == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Status",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(
                      Icons.schedule,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Current Period",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Period ${current.period}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${current.start.format(context)} - ${current.end.format(context)}",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "ONGOING",
                      style: TextStyle(color: Colors.green),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}