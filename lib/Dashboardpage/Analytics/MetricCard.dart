import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  MetricCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.08;
    double textSize = screenWidth * 0.08;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the left
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: iconSize,
            ), // Optional: add color to the icon
            SizedBox(height: 4),
            Text(value,
                style: TextStyle(fontSize: textSize, color: Colors.black)),
            Text(title,
                style: TextStyle(
                    color: const Color.fromARGB(255, 94, 94, 94)
                        .withOpacity(0.9))),
          ],
        ),
      ),
    );
  }
}
