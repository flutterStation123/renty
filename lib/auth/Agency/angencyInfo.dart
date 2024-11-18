import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> agencyInfo() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('agencies') 
          .doc(user
              .uid) 
          .get();

      if (snapshot.exists) {
        return {
          'name': snapshot['name'] ?? 'No Name',
          'email': user.email ?? 'No Email',
          'photoUrl': user.photoURL,
        };
      } else {
        return {
          'name': 'No Name',
          'email': user.email ?? 'No Email',
          'photoUrl': user.photoURL,
        };
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  return null; 
}
