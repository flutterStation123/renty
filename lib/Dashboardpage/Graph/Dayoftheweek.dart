import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

SideTitles dayOfTheWeek() {
  List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  return SideTitles(
    showTitles: true,
    getTitlesWidget: (double value, TitleMeta meta) {
      int index = value.toInt();

      // Only show titles for the first 7 spots (one for each day of the week)
      if (index < daysOfWeek.length) {
        return Text(
          daysOfWeek[index], // Directly map to day of the week
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        );
      }

      // Return an empty container for positions that should not show titles
      return Container();
    },
  );
}
