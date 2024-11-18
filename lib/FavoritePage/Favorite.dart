import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/FavoritePage/FavoriteLogic.dart';

class FavoritePage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchFavoriteItems() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return [];

      CollectionReference favoritesRef;

      final agencyDoc = await FirebaseFirestore.instance
          .collection('agencies')
          .doc(userId)
          .get();

      if (agencyDoc.exists) {
        favoritesRef = FirebaseFirestore.instance
            .collection('agencies')
            .doc(userId)
            .collection('favorites');
      } else {
        final clientDoc = await FirebaseFirestore.instance
            .collection('clients')
            .doc(userId)
            .get();

        if (clientDoc.exists) {
          favoritesRef = FirebaseFirestore.instance
              .collection('clients')
              .doc(userId)
              .collection('favorites');
        } else {
          print("User is neither in agencies nor clients.");
          return [];
        }
      }

      final snapshot = await favoritesRef.get();

      List<Map<String, dynamic>> favoriteItems = [];

      for (var doc in snapshot.docs) {
        final carId = doc['carId'];

        if (carId != null && carId.isNotEmpty) {
          final carDoc = await FirebaseFirestore.instance
              .collection('cars')
              .doc(carId)
              .get();

          if (carDoc.exists) {
            final carData = carDoc.data() as Map<String, dynamic>;
            favoriteItems.add({
              'favorite': doc.data(),
              'car': carData,
            });
          }
        }
      }

      return favoriteItems;
    } catch (e) {
      print("Error fetching favorite items with car info: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.favorite, color: Colors.white),
        title: Text(
          "Favorite Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchFavoriteItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No favorites found.'));
            } else {
              final favoriteItems = snapshot.data!;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: favoriteItems.length,
                  itemBuilder: (context, index) {
                    final item = favoriteItems[index];
                    final car = item['car'];
                    return Card(
                      margin: EdgeInsets.only(top: 10.0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            child: car['imageUrl'] != null
                                ? Image.network(
                                    car['imageUrl'],
                                    height: 100.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/car1.png",
                                    height: 100.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              car['Model'] ?? 'No model',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              car['Status'] ?? 'No status',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${car['Price']} TND' ?? 'No price available',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Check Out",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 10.0),
                                  backgroundColor: Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
