import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchAllCars() async {
  try {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cars').get();

    final List<Map<String, dynamic>> cars = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> carData = doc.data() as Map<String, dynamic>;
      carData['carId'] = doc.id; 
      cars.add(carData);
    }

    return cars;
  } catch (e) {
    print('Error fetching cars: $e');
    return [];
  }
}
