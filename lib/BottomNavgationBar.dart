import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/FavoritePage/Favorite.dart';
import 'package:renty_app/homePage.dart';
import 'package:renty_app/Dashboardpage/Dashboard.dart';
import 'package:renty_app/profilepage/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BaseScaffold extends StatefulWidget {
  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _curvedNavigationKey = GlobalKey();
  final PageController _pageController = PageController();
  List<Map<String, String>> _favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteItems(); 
  }

 
  Future<void> _loadFavoriteItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoriteItemsString = prefs.getString('favoriteItems');
    if (favoriteItemsString != null) {
      List<dynamic> favoriteItemsList = json.decode(favoriteItemsString);
      setState(() {
        _favoriteItems = List<Map<String, String>>.from(favoriteItemsList);
      });
    }
  }

  Future<void> _saveFavoriteItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favoriteItemsString = json.encode(_favoriteItems);
    prefs.setString('favoriteItems', favoriteItemsString);
  }

  void _toggleFavorite(Map<String, String> item, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        _favoriteItems.add(item);
      } else {
        _favoriteItems
            .removeWhere((favItem) => favItem['title'] == item['title']);
      }
    });
    _saveFavoriteItems();
  }

  List<Widget> _getPages() {
    return [
      HomePage(),
      FavoritePage(),
      ProfileScreen(),
      DashboardPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _getPages(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _curvedNavigationKey,
        index: _currentIndex,
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
        onTap: _onItemTapped,
        letIndexChange: (index) => true,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
