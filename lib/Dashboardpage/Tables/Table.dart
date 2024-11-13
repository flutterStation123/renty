import 'package:flutter/material.dart';

Color getTextColor(String text) {
  if (text == 'Rented') {
    return const Color.fromARGB(255, 243, 33, 33);
  } else if (text == 'Available') {
    return Colors.green;
  } else {
    return Colors.black; // Default color if text doesn't match any condition
  }
}

class Car {
  final String model;
  final String licensePlate;
  final String status;

  Car({required this.model, required this.licensePlate, required this.status});
}

class CarDataSource extends DataTableSource {
  final List<Car> cars;

  CarDataSource(this.cars);

  @override
  DataRow getRow(int index) {
    if (index >= cars.length) return DataRow(cells: []);

    final Car car = cars[index];
    return DataRow.byIndex(
      index: index,
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
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          ],
        )),
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
  final List<Car> _cars = List.generate(
    20,
    (index) => Car(
      model: 'Car Model ${index + 1}',
      licensePlate: 'Plate${1000 + index}',
      status: index % 2 == 0 ? 'Available' : 'Rented',
    ),
  );

  late CarDataSource _carDataSource;

  @override
  void initState() {
    super.initState();
    _carDataSource = CarDataSource(_cars);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: Text("Cars Owned"),
        columns: [
          DataColumn(label: Text('Car Model')),
          DataColumn(label: Text('License Plate')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        source: _carDataSource,
        rowsPerPage: _rowsPerPage,
      ),
    );
  }
}
