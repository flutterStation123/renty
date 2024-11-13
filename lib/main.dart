import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/BottomNavgationBar.dart';
import 'package:renty_app/Dashboardpage/Dashboard.dart';
import 'package:renty_app/FavoritePage/Favorite.dart';
import 'package:renty_app/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBL-XbnVOTjK5MpbUlR8IdK6dY4UeaVzmg',
          appId: 'com.example.renty_app',
          messagingSenderId: '564009530216',
          projectId: 'rentyapp-a235a'));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaseScaffold(), 
      routes: {
        '/home': (context) => HomePage(),
        '/dashboard': (context) => DashboardPage(),
        '/favorite': (context) => FavoritePage(),
      },
    );
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
}
