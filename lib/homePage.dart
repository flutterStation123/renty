import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:renty_app/CustomTitle/CustomTitles.dart';
import 'package:renty_app/FavoritePage/FavoriteLogic.dart';
import 'package:renty_app/Product/Cart.dart';
import 'package:renty_app/auth/Agency/angencyInfo.dart';
import 'package:renty_app/auth/loginPage.dart';
import 'package:renty_app/Product/CarsDetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _userInfo;

  List<Map<String, dynamic>> _cars = [];

  Set<String> _favoriteCarIds = {};

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    _fetchCars();
  }

  Future<void> _fetchUserInfo() async {
    try {
      Map<String, dynamic>? userInfo = await agencyInfo();
      setState(() {
        _userInfo = userInfo;
      });
    } catch (e) {
      print("Error fetching user info: $e");
    }
  }

  Future<void> _fetchCars() async {
    try {
      List<Map<String, dynamic>> cars = await fetchAllCars();

      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final agencyDoc = await FirebaseFirestore.instance
            .collection('agencies')
            .doc(userId)
            .get();

        final clientDoc = await FirebaseFirestore.instance
            .collection('clients')
            .doc(userId)
            .get();

        if (agencyDoc.exists) {
          final snapshot = await FirebaseFirestore.instance
              .collection('agencies')
              .doc(userId)
              .collection('favorites')
              .get();
          final favoriteCarIds = snapshot.docs.map((doc) => doc.id).toSet();

          setState(() {
            _cars = cars;
            _favoriteCarIds = favoriteCarIds;
          });
        }
        else if (clientDoc.exists) {
          final snapshot = await FirebaseFirestore.instance
              .collection('clients')
              .doc(userId)
              .collection('favorites')
              .get();
          final favoriteCarIds = snapshot.docs.map((doc) => doc.id).toSet();

          setState(() {
            _cars = cars;
            _favoriteCarIds = favoriteCarIds;
          });
        } else {
          setState(() {
            _cars = cars;
          });
        }
      } else {
        setState(() {
          _cars = cars;
        });
      }
    } catch (e) {
      print("Error fetching cars or favorites: $e");
    }
  }

  Future<void> _toggleFavorite(int index) async {
    final carId = _cars[index]['carId'];

    if (carId == null || carId.isEmpty) {
      print("Error: carId is null or empty.");
      return;
    }

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      DocumentReference? userRef;

      final agencyDoc = await FirebaseFirestore.instance
          .collection('agencies')
          .doc(userId)
          .get();

      if (agencyDoc.exists) {
        userRef = FirebaseFirestore.instance
            .collection('agencies')
            .doc(userId)
            .collection('favorites')
            .doc(carId);
      } else {
        final clientDoc = await FirebaseFirestore.instance
            .collection('clients')
            .doc(userId)
            .get();

        if (clientDoc.exists) {
          userRef = FirebaseFirestore.instance
              .collection('clients')
              .doc(userId)
              .collection('favorites')
              .doc(carId);
        } else {
          print("User is neither in agencies nor clients.");
          return;
        }
      }

      if (_favoriteCarIds.contains(carId)) {
        await userRef.delete();
        setState(() {
          _favoriteCarIds.remove(carId);
        });
      } else {
        await userRef.set({'carId': carId});
        setState(() {
          _favoriteCarIds.add(carId);
        });
      }
    } catch (e) {
      print("Error toggling favorite: $e");
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    print("Logged out successfully");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardWidh = screenWidth * 0.65;
    final cardheight = screenWidth * 0.40;
    final imageheight = screenWidth * 0.45;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 218, 215, 215),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              onPressed: () {},
              icon: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/will_smith.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userInfo != null
                                ? _userInfo!['name']
                                : 'Loading...',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _userInfo != null
                                ? _userInfo!['email']
                                : 'Loading...',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomListTile(
              title: "Log out",
              icon: Icons.logout,
              onTap: () {
                _logout();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Color.fromARGB(255, 218, 215, 215),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 204, 203, 203)
                                  .withOpacity(0.5),
                              spreadRadius: 10,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {},
                      padding: EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Text(
                    "Explore",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                ),
                Container(
                  height: 340,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _cars.length,
                    itemBuilder: (context, index) {
                      final car = _cars[index];

                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 204, 203, 203)
                                    .withOpacity(0.5),
                                spreadRadius: 10,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          width: cardWidh,
                          height: cardheight,
                          child: Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      car['Model']!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.asset(
                                            "assets/car1.png",
                                            fit: BoxFit.contain,
                                            width: cardWidh,
                                            height: imageheight,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  _favoriteCarIds.contains(
                                                          car['carId'])
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  _toggleFavorite(index);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${car['Price']} TND',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Rent Now !",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
