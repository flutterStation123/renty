import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/FavoritePage/Favorite.dart';
import 'package:renty_app/homePage.dart';
import 'package:renty_app/Dashboardpage/Dashboard.dart';

class BaseScaffold extends StatefulWidget {
  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _curvedNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    Center(child: Text('Search')),
    DashboardPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _curvedNavigationKey,
        index: 0,
        height: 65.0,
        items: [
          Icon(Icons.home, size: 33, color: Colors.blue),
          Icon(Icons.favorite, size: 33, color: Colors.blue),
          Icon(Icons.person, size: 33, color: Colors.blue),
          Icon(Icons.dashboard, size: 33, color: Colors.blue),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blue,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
