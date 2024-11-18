import 'package:flutter/material.dart';
import 'package:renty_app/Dashboardpage/carManagement/ShowcarInfopage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color getTextColor(String status) {
  if (status == 'rented') {
    return const Color.fromARGB(255, 243, 33, 33);
  } else if (status == 'available') {
    return Colors.green;
  } else {
    return Colors.black;
  }
}

class Car {
  final String model;
  final String licensePlate;
  final String status;
  final String price;

  Car({
    required this.model,
    required this.licensePlate,
    required this.status,
    required this.price,
  });
}

class CarDataSource extends DataTableSource {
  final List<Car> cars;
  final Function(Car car) onRowTap;

  CarDataSource(this.cars, this.onRowTap);

  @override
  DataRow getRow(int index) {
    if (index >= cars.length) return DataRow(cells: []);

    final Car car = cars[index];
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (bool? selected) {
        if (selected != null && selected) {
          onRowTap(car);
        }
      },
      cells: [
        DataCell(Text(car.model)),
        DataCell(Text(car.licensePlate)),
        DataCell(
          Text(
            car.status,
            style: TextStyle(
              color: getTextColor(car.status),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataCell(Text(car.price)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => cars.length;
  @override
  int get selectedRowCount => 0;
}

class CarInventoryTable extends StatefulWidget {
  @override
  _CarInventoryTableState createState() => _CarInventoryTableState();
}

class _CarInventoryTableState extends State<CarInventoryTable> {
  final int _rowsPerPage = 5;
  late CarDataSource _carDataSource;
  List<Car> _cars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserCars();
  }

  Future<void> _loadUserCars() async {
    List<Car> cars = await getCarsByUser();
    setState(() {
      _cars = cars;
      _carDataSource = CarDataSource(_cars, _navigateToCarDetails); 
      _isLoading = false;
    });
  }

  Future<List<Car>> getCarsByUser() async {
    List<Car> carList = [];
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        print("No user is logged in.");
        return carList;
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cars')
          .where('userId', isEqualTo: userId)
          .get();

      for (var doc in querySnapshot.docs) {
        carList.add(Car(
          model: doc['Model'],
          licensePlate: doc['Plate'],
          price: doc['Price'],
          status: doc['Status'],
        ));
      }
    } catch (error) {
      print("Failed to retrieve cars: $error");
    }

    return carList;
  }

  void _navigateToCarDetails(Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarDetailsPage(
          car: car,
          onSave: (updatedCar) {
            setState(() {
              final index = _cars.indexWhere((c) => c.licensePlate == car.licensePlate);
              if (index != -1) {
                _cars[index] = updatedCar; 
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PaginatedDataTable(
              header: Text("Cars Owned"),
              columns: [
                DataColumn(label: Text('Car Model')),
                DataColumn(label: Text('License Plate')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Price')),
              ],
              source: _carDataSource,
              rowsPerPage: _rowsPerPage,
              showCheckboxColumn: false,
            ),
    );
  }
}
