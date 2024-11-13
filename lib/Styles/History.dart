import 'package:flutter/material.dart';

class RecentActivityList extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String subtitle;
  final String payment;

  const RecentActivityList({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.subtitle,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Color.fromARGB(255, 22, 252, 72),
                  ),
                  label: Text(
                    payment,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 22, 252, 72),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
