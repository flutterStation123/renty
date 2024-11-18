import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
