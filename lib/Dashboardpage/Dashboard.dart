import 'package:flutter/material.dart';
import 'package:renty_app/Dashboardpage/Graph/Chart.dart';
import 'package:renty_app/Dashboardpage/Styles/History.dart';
import 'package:renty_app/Dashboardpage/Analytics/MetricCard.dart';
import 'package:renty_app/Dashboardpage/Tables/Table.dart';
import 'package:renty_app/Dashboardpage/carManagement/newCar.dart';
import 'package:renty_app/Dashboardpage/rentRequets/requestedRent.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int pendingRequests =
      5; 

  void navigateToRequestsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RentRequestsPage(),
      ),
    );
  }

  void navigateToNewCarPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => newCar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.notifications, size: 30),
                onPressed: navigateToRequestsPage,
              ),
              if (pendingRequests > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$pendingRequests',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio:
                          constraints.maxWidth / (crossAxisCount * 150),
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      List<Map<String, dynamic>> metrics = [
                        {
                          "title": "Total Cars",
                          "value": "20",
                          "icon": Icons.directions_car_filled_outlined,
                          "Status": "Rented"
                        },
                        {
                          "title": "Available Cars",
                          "value": "15",
                          "icon": Icons.check_circle_outline,
                        },
                        {
                          "title": "Active Rentals",
                          "value": "5",
                          "icon": Icons.sync,
                          "Status": "Rented"
                        },
                        {
                          "title": "Average Sales",
                          "value": "2.542",
                          "icon": Icons.show_chart_outlined,
                          "Status": "Rented"
                        },
                      ];

                      return MetricCard(
                        title: metrics[index]["title"]!,
                        value: metrics[index]["value"]!,
                        icon: metrics[index]["icon"],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              child: PageView(
                children: [
                  DashboardChart(title: "Rental Performance"),
                  DashboardChart(title: "Top-Rented Cars"),
                ],
              ),
            ),
            SizedBox(height: 20),
            CarInventoryTable(),
            RecentActivityList(
                imageUrl: "assets/will_smith.png",
                name: "Will smith",
                subtitle: "has rented a car for 7 days",
                payment: "230 DT"),
            RecentActivityList(
                imageUrl: "assets/will_smith.png",
                name: "Will smith",
                subtitle: "has rented a car for 7 days",
                payment: "230 DT"),
            RecentActivityList(
                imageUrl: "assets/will_smith.png",
                name: "Will smith",
                subtitle: "has rented a car for 7 days",
                payment: "230 DT"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToNewCarPage,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_circle),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      ),
    );
  }
}
