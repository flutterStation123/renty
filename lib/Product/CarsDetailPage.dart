import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarsDetailPage extends StatefulWidget {
  final Map<String, String> car;

  CarsDetailPage({required this.car});

  @override
  State<CarsDetailPage> createState() => _CarsDetailPageState();
}

class _CarsDetailPageState extends State<CarsDetailPage> {
  Color favoriteIconColor = Colors.black;

  void toggleFavorite() {
    setState(() {
      favoriteIconColor =
          (favoriteIconColor == Colors.red) ? Colors.red : Colors.red;
    });
    print('it works');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            child: Image.asset(
              widget.car['image']!,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 260,
            left: 0,
            right: 0,
            child: Expanded(
              child: Container(
                height: 500,
                padding: EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.car['title']!,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 252, 172, 25),
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              '${widget.car['rate']}',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey.withOpacity(1.0)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      widget.car['description']!,
                      style: TextStyle(
                          fontSize: 15, color: Colors.grey.withOpacity(0.9)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.car['price']!,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Text(
                        'there is a weekly housekeeping to keep your room neat & clean',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey.withOpacity(0.9)),
                      ),
                    ),
                    Text(
                      'Amenities',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Free WiFi',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey.withOpacity(0.9)),
                            ),
                            const SizedBox(width: 118.0),
                            Text(
                              'CCTV',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey.withOpacity(0.9)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Washing Machine',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey.withOpacity(0.9)),
                        ),
                        const SizedBox(width: 60.0),
                        Text(
                          'Fire Extinguisher',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey.withOpacity(0.9)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('Elevated Button',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 16, 68),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9))),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 79),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0))),
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: favoriteIconColor,
                            ),
                            onPressed: () {
                              toggleFavorite();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
