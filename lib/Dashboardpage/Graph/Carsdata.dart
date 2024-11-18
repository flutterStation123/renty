import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

SideTitles CarDara() {
  List<String> daysOfWeek = [
    'Ford',
    'BMW',
    'Mazda',
    'Audi',
    'Jeep',
    'Kia',
    'Nissan',
    'Volkswagen'
  ];

  return SideTitles(
    showTitles: true,
    getTitlesWidget: (double value, TitleMeta meta) {
      int index = value.toInt();

      if (index < daysOfWeek.length) {
        return Text(
          daysOfWeek[index], 
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        );
      }

      return Container();
    },
  );
}
