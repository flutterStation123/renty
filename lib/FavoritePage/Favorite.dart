import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/FavoritePage/CustomFavoriteList.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          title: Text(
            "Favorite Page ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue),
      body: CustomFavoriteList(
        imageUrl: "assets/car1.png",
        name: "Fiat Car",
        subtitle: "dzakgd",
      ),
    );
  }
}
