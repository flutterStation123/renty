import 'package:flutter/material.dart';

class RentRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Rent Requests'),
      ),
      body: Center(
        child: Text('List of pending rent requests will go here.'),
      ),
    );
  }
}
