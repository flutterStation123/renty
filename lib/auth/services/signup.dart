import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/auth/loginPage.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference agencies =
      FirebaseFirestore.instance.collection('agencies');
  final CollectionReference clients =
      FirebaseFirestore.instance.collection('clients');

  Future<void> signup(
      String email, String password, BuildContext context) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.of(context).pushReplacementNamed('homePage');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  Future<void> addAgency(String name, String email, String password,
      String phone, String nif, BuildContext context) async {
    try {
      final String? uid = _auth.currentUser?.uid;

      if (uid == null) {
        throw Exception("User is not authenticated");
      }

      await agencies.doc(uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'nif': nif, 
      });

      print("Agency Added");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } catch (error) {
      print("Failed to add agency: $error");
    }
  }

  Future<void> addClient(String name, String email, String password,
      String phone, BuildContext context) async {
    try {
      final String? uid = _auth.currentUser?.uid;

      if (uid == null) {
        throw Exception("User is not authenticated");
      }

      await clients.doc(uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      });

      print("Client Added");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } catch (error) {
      print("Failed to add client: $error");
    }
  }
}
