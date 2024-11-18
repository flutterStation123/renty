import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

enum CarStatus { available, rented }

class newCar extends StatefulWidget {
  @override
  State<newCar> createState() => _newCarState();
}

class _newCarState extends State<newCar> {
  final TextEditingController _model = TextEditingController();
  final TextEditingController _plate = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference cars = FirebaseFirestore.instance.collection('cars');

  CarStatus _status = CarStatus.available; 

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxWidth = screenWidth * 0.90;

    Future<void> addCar() async {
      try {
        String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

        if (userId.isEmpty) {
          print("No user is logged in.");
          return;
        }

        await cars.add({
          'Model': _model.text,
          'Plate': _plate.text,
          'Price': _price.text,
          'Status': _status.toString().split('.').last,
          'userId': userId,
        });

        print("Car Added by user $userId");
      } catch (error) {
        print("Failed to add car: $error");
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/CarPov.png",
                      fit: BoxFit.cover,
                      height: 140,
                    ),
                  ),
                ),
                Text(
                  "New Car",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 17, 91, 151),
                  ),
                ),
                Text(
                  "Add a new Car for rent",
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 50.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: boxWidth,
                        child: TextFormField(
                          controller: _model,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            labelText: 'Model',
                            hintText: 'Enter Your Car Model',
                            prefixIcon: Icon(
                              LineAwesomeIcons.car_alt_solid,
                              color: Colors.cyan,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your car model';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: boxWidth,
                        child: TextFormField(
                          controller: _plate,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            labelText: 'Plate',
                            hintText: 'Enter Your Car\'s Plate ',
                            prefixIcon: Icon(
                              LineAwesomeIcons.hashtag_solid,
                              color: Colors.cyan,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your car\'s plate';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: boxWidth,
                        child: TextFormField(
                          controller: _price,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            labelText: 'Price',
                            hintText: 'Enter Your Car\'s Price ',
                            prefixIcon: Icon(
                              LineAwesomeIcons.dollar_sign_solid,
                              color: Colors.cyan,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your car\'s price';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: boxWidth,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await addCar();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Color.fromARGB(255, 7, 97, 172),
                    ),
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
