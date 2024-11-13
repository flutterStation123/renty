import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String description;

  AlertCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orangeAccent,
      child: ListTile(
        leading: Icon(Icons.notification_important, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        subtitle: Text(description, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
