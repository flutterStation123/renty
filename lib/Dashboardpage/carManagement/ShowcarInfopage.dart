import 'package:flutter/material.dart';
import 'package:renty_app/Dashboardpage/Tables/Table.dart';

class CarDetailsPage extends StatefulWidget {
  final Car car;
  final ValueChanged<Car> onSave;

  CarDetailsPage({required this.car, required this.onSave});

  @override
  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  late TextEditingController _modelController;
  late TextEditingController _licensePlateController;
  late TextEditingController _priceController;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _modelController = TextEditingController(text: widget.car.model);
    _licensePlateController =
        TextEditingController(text: widget.car.licensePlate);
    _priceController = TextEditingController(text: widget.car.price);
    _selectedStatus = widget.car.status ??
        'Available'; // Default to 'Available' if status is null
  }

  @override
  void dispose() {
    _modelController.dispose();
    _licensePlateController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void saveChanges() {
    Car updatedCar = Car(
      model: _modelController.text,
      licensePlate: _licensePlateController.text,
      status: _selectedStatus,
      price: _priceController.text,
    );
    widget.onSave(updatedCar); // Pass updated car back to parent
    Navigator.pop(context); // Close the details page and return to the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit Car Information',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            TextField(
              controller: _modelController,
              decoration: InputDecoration(
                labelText: 'Car Model',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _licensePlateController,
              decoration: InputDecoration(
                labelText: 'License Plate',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
              },
              items: ['available', 'rented']
                  .map((status) => DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Status',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    // Add car removal functionality here if needed
                  },
                  child: Text(
                    'Remove Car',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: saveChanges,
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
