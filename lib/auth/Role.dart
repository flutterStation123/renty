import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/auth/Agency/agencySignupPage.dart';
import 'package:renty_app/auth/Client/clientSignupPage.dart';

class userRole extends StatefulWidget {
  State<userRole> createState() => _userRoleState();
}

class _userRoleState extends State<userRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgencySignupPage(),
                  ),
                );
              },
              child: Text(
                "Travel Agency",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => clientSignupPage(),
                  ),
                );
              },
              child: Text(
                "Client",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
