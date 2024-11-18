import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/BottomNavgationBar.dart';
import 'package:renty_app/Dashboardpage/Dashboard.dart';
import 'package:renty_app/FavoritePage/Favorite.dart';
import 'package:renty_app/auth/loginPage.dart';
import 'package:renty_app/homePage.dart';
import 'package:renty_app/Dashboardpage/carManagement/newCar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBL-XbnVOTjK5MpbUlR8IdK6dY4UeaVzmg',
      appId: 'com.example.renty_app',
      messagingSenderId: '564009530216',
      projectId: 'rentyapp-a235a',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget _initialScreen;

  @override
  void initState() {
    super.initState();
    _initialScreen = const Center(child: CircularProgressIndicator());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _initialScreen = user == null ? LoginPage() : BaseScaffold();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _initialScreen,
      routes: {
        '/home': (context) => HomePage(),
        '/bottom': (context) => BaseScaffold(),
        '/dashboard': (context) => DashboardPage(),
        '/favorite': (context) => FavoritePage(),
        '/newCar': (context) => newCar(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text("Unknown Route")),
            body: Center(child: Text("Page not found: ${settings.name}")),
          ),
        );
      },
    );
  }
}
