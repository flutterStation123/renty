import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:renty_app/Dashboardpage/Graph/Carsdata.dart';
import 'package:renty_app/Dashboardpage/Graph/Dayoftheweek.dart';

class DashboardChart extends StatelessWidget {
  final String title;

  DashboardChart({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 300, // Adjusted height for charts
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: title == "Rental Performance"
                  ? RentalPerformanceChart()
                  : TopRentedCarsChart(),
            ),
          ],
        ),
      ),
    );
  }
}

class RentalPerformanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
        bottomTitles: AxisTitles(
            sideTitles: dayOfTheWeek(),
            axisNameWidget: Text('Day Of the Week')),
      ),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 5), // x: 0, y: 5
            FlSpot(1, 10), // x: 1, y: 10
            FlSpot(2, 15), // x: 2, y: 15
            FlSpot(3, 7), // x: 3, y: 7
            FlSpot(4, 12), // x: 3, y: 7
            FlSpot(5, 14), // x: 3, y: 7
            FlSpot(6, 9), // x: 3, y: 7
            FlSpot(7, 19), // x: 3, y: 7
          ],
          isCurved: true,
          color: Colors.blue,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    ));
  }
}

class TopRentedCarsChart extends StatelessWidget {
  final List<BarChartGroupData> rentalData = [
    BarChartGroupData(x: 0, barRods: [
      BarChartRodData(
          toY: 5,
          borderRadius: BorderRadius.circular(1),
          width: 20,
          color: Colors.blue)
    ]), // Sun
    BarChartGroupData(x: 1, barRods: [
      BarChartRodData(
          toY: 10,
          borderRadius: BorderRadius.circular(1),
          width: 20,
          color: Colors.blue)
    ]), // Mon
    BarChartGroupData(x: 2, barRods: [
      BarChartRodData(
          toY: 15,
          borderRadius: BorderRadius.circular(1),
          width: 20,
          color: Colors.blue)
    ]), // Tue
    BarChartGroupData(x: 3, barRods: [
      BarChartRodData(
          toY: 7,
          borderRadius: BorderRadius.circular(1),
          width: 20,
          color: Colors.blue)
    ]), // Wed
    BarChartGroupData(x: 4, barRods: [
      BarChartRodData(
          toY: 12,
          borderRadius: BorderRadius.circular(1),
          width: 20,
          color: Colors.blue)
    ]), // Thu
    BarChartGroupData(x: 5, barRods: [
      BarChartRodData(
          toY: 14,
          borderRadius: BorderRadius.circular(1),
          width: 20,
          color: Colors.blue)
    ]), // Fri
    BarChartGroupData(x: 6, barRods: [
      BarChartRodData(
          toY: 9,
          borderRadius: BorderRadius.circular(1),
          width: 20,
          color: Colors.blue)
    ]), // Sat
  ];

  double getMaxY(List<BarChartGroupData> data) {
    double maxValue = data.fold(0.0, (prev, groupData) {
      double groupMax = groupData.barRods[0].toY;
      return prev > groupMax ? prev : groupMax;
    });
    return maxValue + 5;
  }

  @override
  Widget build(BuildContext context) {
    double maxYValue = getMaxY(rentalData);

    return BarChart(
      BarChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28, // Add space for better Y-axis label visibility
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  value.toInt().toString(), // Display integer value
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: CarDara(),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 2),
        ),
        maxY: maxYValue,
        barGroups: rentalData,
      ),
    );
  }
}
