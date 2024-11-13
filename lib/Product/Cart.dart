import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Cart extends StatefulWidget {
  @override
  _CartStat createState() => _CartStat();
}

class _CartStat extends State<Cart> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  int quantity = 1;

  // Get color for checkbox when in different states
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return Color.fromARGB(255, 247, 153, 30);
    }
    return Color.fromARGB(0, 244, 67, 54);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemWidth = screenWidth * 0.90;
    final sheetHeight = screenHeight * 0.40;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 239, 239),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, '/Profile');
          },
        ),
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 240, 239, 239),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: itemWidth,
                margin:
                    EdgeInsets.only(left: 0, top: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: isChecked1,
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked1 = value ?? false;
                              });
                            },
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/will_smith.png',
                            width:
                                100, // Reduced width to allow more space for quantity controls
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Minimalist chair",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$235.00",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 255, 51, 0),
                                    ),
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Container(
                                      height: 32,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              iconSize: 16,
                                              constraints:
                                                  BoxConstraints(), // Removes extra padding around the icon
                                              icon:
                                                  Icon(Icons.remove, size: 16),
                                              onPressed: () {
                                                setState(() {
                                                  if (quantity > 1) quantity--;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            '$quantity',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Flexible(
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              iconSize: 16,
                                              constraints:
                                                  BoxConstraints(), // Removes extra padding around the icon
                                              icon: Icon(Icons.add, size: 16),
                                              onPressed: () {
                                                setState(() {
                                                  quantity++;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: isChecked2,
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked2 = value ?? false;
                              });
                            },
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/will_smith.png',
                            width:
                                100, // Reduced width to allow more space for quantity controls
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Minimalist chair",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$235.00",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 255, 51, 0),
                                    ),
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Container(
                                      height: 32,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              iconSize: 16,
                                              constraints:
                                                  BoxConstraints(), // Removes extra padding around the icon
                                              icon:
                                                  Icon(Icons.remove, size: 16),
                                              onPressed: () {
                                                setState(() {
                                                  if (quantity > 1) quantity--;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            '$quantity',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Flexible(
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              iconSize: 16,
                                              constraints:
                                                  BoxConstraints(), // Removes extra padding around the icon
                                              icon: Icon(Icons.add, size: 16),
                                              onPressed: () {
                                                setState(() {
                                                  quantity++;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: isChecked3,
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked3 = value ?? false;
                              });
                            },
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/will_smith.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Minimalist chair",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$235.00",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 255, 51, 0),
                                    ),
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Container(
                                      height: 32,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              iconSize: 16,
                                              constraints:
                                                  BoxConstraints(), // Removes extra padding around the icon
                                              icon:
                                                  Icon(Icons.remove, size: 16),
                                              onPressed: () {
                                                setState(() {
                                                  if (quantity > 1) quantity--;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            '$quantity',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Flexible(
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              iconSize: 16,
                                              constraints:
                                                  BoxConstraints(), // Removes extra padding around the icon
                                              icon: Icon(Icons.add, size: 16),
                                              onPressed: () {
                                                setState(() {
                                                  quantity++;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: sheetHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 50,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "Selected items",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          "\$235.00",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 51, 0),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "Shipping Fee",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          "\$30.00",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 51, 0),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(
                      thickness: 2.0,
                      color: const Color.fromARGB(255, 134, 132, 132),
                      indent: screenWidth * 0.10,
                      endIndent: screenWidth * 0.10,
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "SubTotal",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "\$265.00",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 51, 0),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    SizedBox(height: 25.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Checkout",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        fixedSize: Size(screenWidth * 0.80, sheetHeight * 0.20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
