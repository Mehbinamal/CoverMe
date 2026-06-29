import 'package:flutter/material.dart';

class CurrentPeriodCard extends StatelessWidget {
  const CurrentPeriodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Current Period",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Period 3",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text("10:20 - 11:00"),
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
                borderRadius:
                    BorderRadius.circular(30),
              ),
              child: const Text(
                "ONGOING",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}